import '/core/viewModel/notificationViewModel.dart';
import '/core/service/fireStore_message.dart';
import '/core/viewModel/authViewModel.dart';
import '/core/viewModel/homeViewModel.dart';
import '/model/messageModel.dart';
import '/model/userModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessageViewModel extends GetxController {
  ValueNotifier<bool> isLoading = ValueNotifier(false);
  UserModel? toUser;
  String toValue = '';
  String searchVal = '';
  HomeViewModel homeViewModel = Get.find();
  AuthViewModel _authViewModel = Get.find();
  NotificationViewModel _notificationViewModel = Get.find();
  List<MessageModel> _headerMessages = [];
  List<MessageModel> _searchdMessages = [];
  List<MessageModel> get headerMessages => _searchdMessages.isNotEmpty
      ? _searchdMessages
      : searchVal == ''
          ? _headerMessages
          : [];
  int indexOfShownMessage = -1;
  int? orderNumber;

  onInit() {
    getLastMessages();
    super.onInit();
  }

  getOrderNumber(val) {
    orderNumber = val;
    update();
  }

  getToVal(val) {
    toValue = val;
    update();
  }

  getToUser(UserModel user) {
    toUser = user;
    update();
  }

  restToUserValues() {
    toUser = null;
    toValue = '';
    update();
  }

  uploadMessage({
    required Timestamp createdAt,
    required String vendorId,
    required String customerId,
    required String from,
    required String to,
    required String message,
    int? orderNumber,
  }) {
    FireStoreMessage()
        .addMessageToFireStore(
      createdAt: createdAt,
      vendorId: vendorId,
      customerId: customerId,
      from: from,
      to: to,
      message: message,
      orderNumber: orderNumber as int,
    )
        .then((value) {
      getLastMessages();
      if (toUser != null) toUser = null;
      indexOfShownMessage = 0;
      update();
      _notificationViewModel.sendNotification(to, 'New message ');
    });
  }

  getLastMessages() {
    isLoading.value = true;
    update();
    List<UserModel> _users = _authViewModel.users;
    FireStoreMessage().getChatsFromFireStore().then((messages) {
      messages.forEach((message) {
        if (homeViewModel.savedUser?.id == message['from'] ||
            homeViewModel.savedUser?.id == message['to']) {
          int index = _headerMessages.indexWhere((element) =>
              (element.from!.id == message['from'] ||
                  element.from!.id == message['to']) &&
              (element.to!.id == message['from'] ||
                  element.to!.id == message['to']));
          UserModel to = _users.firstWhere((user) => user.id == message['to']);
          UserModel from =
              _users.firstWhere((user) => user.id == message['from']);
          if (index >= 0) {
            _headerMessages.removeAt(index);
            _headerMessages.insert(
                0,
                MessageModel(
                  id: message.id,
                  messageTime: message['createdAt'],
                  vendorId: message['vendorId'],
                  customerId: message['customerId'],
                  from: from,
                  to: to,
                  lastMessage: message['message'],
                  orderNumber: message['orderNumber'],
                  isOpened: message['isOpened'],
                ));
          } else {
            _headerMessages.insert(
                0,
                MessageModel(
                  id: message.id,
                  messageTime: message['createdAt'],
                  vendorId: message['vendorId'],
                  customerId: message['customerId'],
                  from: from,
                  to: to,
                  lastMessage: message['message'],
                  orderNumber: message['orderNumber'],
                  isOpened: message['isOpened'],
                ));
          }
        }
      });
      isLoading.value = false;
      update();
    });
  }

  getIndexOfShownMessage(int i) {
    indexOfShownMessage = i;
    if (indexOfShownMessage == -1) {
      toUser = null;
    }
    update();
  }

  getSearchedMessage(String val) {
    searchVal = val;
    _searchdMessages = _headerMessages
        .where((message) => message.from!.id == homeViewModel.savedUser?.id
            ? message.to!.userName
                .toString()
                .toLowerCase()
                .startsWith(val.toLowerCase())
            : message.from!.userName
                .toString()
                .toLowerCase()
                .startsWith(val.toLowerCase()))
        .toList();
    if (_searchdMessages.isNotEmpty) {
      indexOfShownMessage = -1;
    }
    update();
  }

  updateMessage(id) {
    FireStoreMessage()
        .updateIsOpenedParameter(id)
        .then((_) => getLastMessages());
  }
}
