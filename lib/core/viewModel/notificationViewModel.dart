import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/widgets/onMessageNotify.dart';
import '/model/notificationModel.dart';
import 'package:http/http.dart' as http;
import '/core/service/fireStore_notification.dart';
import '/core/viewModel/homeViewModel.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import '../../const.dart';

class NotificationViewModel extends GetxController {
  FirebaseMessaging fbMessaging = FirebaseMessaging.instance;
  HomeViewModel _homeViewModel = Get.find();
  late List<Map<String, dynamic>> _tokens;
  onInit() {
    addDeviceToken();
    getDevicesToken();
    FirebaseMessaging.onMessage.listen((event) => onMessage(event));
    super.onInit();
  }

  getDevicesToken() {
    FireStoreNotification().getTokensfromFireStore().then((value) {
      _tokens = value.map((e) {
        Map<String, dynamic> data = e.data() as Map<String, dynamic>;
        return {'id': e.id, 'token': data['token']};
      }).toList();
      update();
    });
  }

  addDeviceToken() async {
    await fbMessaging.getToken(vapidKey: vapidKey).then(
          (value) => FireStoreNotification().addTokenToFireStore(
            _homeViewModel.savedUser!.id as String,
            value,
          ),
        );
  }

  sendNotification(String uid, body) async {
    var userToken =
        _tokens.firstWhere((element) => element['id'] == uid)['token'];
    if (userToken != null) {
      await http
          .post(
            Uri.parse('https://fcm.googleapis.com/fcm/send'),
            headers: <String, String>{
              'Content-Type': 'application/json',
              'Authorization': 'key=$serverToken',
            },
            body: jsonEncode(
              <String, dynamic>{
                'notification': <String, dynamic>{
                  'body': body,
                  'title': 'Notification',
                  'sound': 'default',
                },
                'priority': 'high',
                'data': <String, dynamic>{
                  'click_action': 'FLUTTER_NOTIFICATION_CLICK',
                  'id': '1',
                  'status': 'done'
                },
                'to': userToken,
              },
            ),
          )
          .then(
            (_) => FireStoreNotification().addNotificationToFireStore(
              NotificationModel(
                from: _homeViewModel.savedUser!.id,
                to: [uid],
                message: body,
                createdAt: Timestamp.now(),
                seen: false,
              ),
            ),
          );
    }
  }

  onMessage(RemoteMessage message) {
    if (Get.currentRoute != '/:messages') {
      Get.dialog(OnMessageNotify(
          notification: message.notification as RemoteNotification));
    }
  }

  handleOnMessageDetails(String message) {
    if (message == 'New message ') {
      _homeViewModel.handleClickItem(2);
    } else {
      _homeViewModel.handleClickItem(3);
    }
  }

  handleNotificationTapped(String id, message) {
    handleOnMessageDetails(message);
    FireStoreNotification().updateSeenValue(id);
  }
}
