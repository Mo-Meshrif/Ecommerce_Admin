import '../../../../../responsive.dart';
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
      String currentItem = homeController.currentItem;
      UserModel me = homeController.savedUser;
      List<MessageModel> headerMessages = [];
      int indexOfShownMessage = 0;
      MessageModel currentMessage;
      UserModel notMe, toUser;
      if (currentItem == 'chat') {
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
      switch (currentItem) {
        case 'chat':
          _widget = CustomText(
            txt: toUser != null ? toUser.userName : notMe.userName,
            fSize: 18,
          );
          break;
        case 'order':
          _widget = CustomText(
            txt: 'Order Track',
            fSize: 18,
          );
          break;
        case 'addProduct':
          _widget = CustomText(
            txt: 'Add Product',
            fSize: 18,
          );
          break;
        case 'editProduct':
          _widget = CustomText(
            txt: 'Edit Product',
            fSize: 18,
          );
          break;
        default:
          _widget = CustomText(
            txt: 'Ecommerce App',
            fSize: 18,
          );
      }
      return Responsive.isMobile(context)
          ? _widget
          : CustomText(
              txt: 'Ecommerce App',
              fSize: 18,
            );
    });
  }
}
