import '/core/viewModel/homeViewModel.dart';
import '/core/viewModel/messageViewModel.dart';
import '/model/messageModel.dart';
import '/model/userModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../navTopView.dart';

class AppBarActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeViewModel>(builder: (homeController) {
      int currentIndex = homeController.currentIndex;
      UserModel me = homeController.savedUser;
      List<MessageModel> headerMessages = [];
      int indexOfShownMessage = 0;
      MessageModel currentMessage;
      UserModel notMe, toUser;
      if (currentIndex == 1) {
        toUser = Get.find<MessageViewModel>().toUser;
        headerMessages = Get.find<MessageViewModel>().headerMessages;
        indexOfShownMessage =
            Get.find<MessageViewModel>().indexOfShownMessage ?? 0;
        if (headerMessages.isNotEmpty) {
          currentMessage = headerMessages[indexOfShownMessage];
          notMe = me.id == currentMessage.to.id
              ? currentMessage.from
              : currentMessage.to;
        }
      }
      Widget _widget;
      switch (homeController.currentIndex) {
        case 1:
          _widget = Padding(
            padding: const EdgeInsets.only(right: 10),
            child: CircleAvatar(
              radius: 20,
              backgroundImage: notMe.pic == null || toUser.pic == null
                  ? AssetImage('assets/order/person.png')
                  : NetworkImage(notMe.pic),
            ),
          );
          break;
        default:
          _widget = NavTopView();
      }
      return _widget;
    });
  }
}
