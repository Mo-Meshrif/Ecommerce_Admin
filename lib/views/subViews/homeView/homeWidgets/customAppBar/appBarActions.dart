import '/responsive.dart';
import '/core/viewModel/orderViewModel.dart';
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
      String currentItem = homeController.currentItem;
      UserModel me = homeController.savedUser as UserModel;
      List<MessageModel> headerMessages = [];
      int indexOfShownMessage = 0;
      MessageModel currentMessage;
      UserModel? notMe, toUser;
      if (currentItem == 'chat') {
        toUser = Get.find<MessageViewModel>().toUser as UserModel;
        headerMessages = Get.find<MessageViewModel>().headerMessages;
        indexOfShownMessage =
            Get.find<MessageViewModel>().indexOfShownMessage ?? 0;
        if (headerMessages.isNotEmpty) {
          currentMessage = headerMessages[indexOfShownMessage];
          notMe = me.id == currentMessage.to!.id
              ? currentMessage.from
              : currentMessage.to;
          if (notMe == null) {
            notMe = toUser;
          }
        }
      }
      Widget _widget;
      switch (currentItem) {
        case 'chat':
          _widget = Padding(
            padding: const EdgeInsets.only(right: 10),
            child: CircleAvatar(
              radius: 20,
              backgroundImage: notMe!.pic == null
                  ? AssetImage('assets/order/person.png')
                  : NetworkImage(notMe.pic as String) as ImageProvider,
            ),
          );
          break;
        case 'order':
          _widget = GestureDetector(
            onTap: () {
              MessageViewModel _messageController = Get.put(MessageViewModel());
              OrderViewModel _orderController = Get.find<OrderViewModel>();
              _messageController
                  .getOrderNumber(_orderController.selectedOrder.orderNumber);
              _messageController.toUser = _orderController.authViewModel.users
                  .firstWhere((user) =>
                      user.id == _orderController.selectedOrder.customerId);
              homeController.handleClickItem(2);
              homeController.getCurrentItem('chat');
              _orderController.getMobileViewStatus(false);
            },
            child: Padding(
              padding: EdgeInsets.only(top: 5, right: 15),
              child: Icon(Icons.message, color: Colors.black),
            ),
          );
          break;
        default:
          _widget = NavTopView();
      }
      return Responsive.isMobile(context) ? _widget : NavTopView();
    });
  }
}
