import 'package:cloud_firestore/cloud_firestore.dart';
import '/model/notificationModel.dart';

class FireStoreNotification {
  final collectionNotification =
      FirebaseFirestore.instance.collection('Notifications');
  final collectionToken = FirebaseFirestore.instance.collection('DevicesToken');

  Future<List<QueryDocumentSnapshot>> getTokensfromFireStore() async {
    var val = await collectionToken.get();
    return val.docs;
  }

  Future<void> addTokenToFireStore(String id, token) async {
    return await collectionToken.doc(id).set({'token': token});
  }

  Future<List<QueryDocumentSnapshot>> getNotificationsfromFireStore() async {
    var val = await collectionNotification.get();
    return val.docs;
  }

  Future<void> addNotificationToFireStore(
      NotificationModel notification) async {
    return await collectionNotification.add(notification.toJson());
  }

  Future<void> updateSeenValue(String id) async {
    await collectionNotification.doc(id).update({'seen': true});
  }
}
