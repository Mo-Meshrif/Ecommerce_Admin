import '/widgets/customText.dart';
import '/core/viewModel/homeViewModel.dart';
import '/core/viewModel/messageViewModel.dart';
import '/model/messageModel.dart';
import '/model/userModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppBarTitle extends StatelessWidget {
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
          _widget = CustomText(
            txt: toUser != null ? toUser.userName : notMe.userName,
            fSize: 18,
          );
          break;
        case 2:
          _widget = CustomText(
            txt: 'Order Track',
            fSize: 18,
          );
          break;
        default:
          _widget = CustomText(
            txt: 'Ecommerce App',
            fSize: 18,
          );
      }
      return _widget;
    });
  }
}
