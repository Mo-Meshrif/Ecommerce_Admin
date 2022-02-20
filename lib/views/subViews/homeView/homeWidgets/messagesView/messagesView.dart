import '/widgets/customText.dart';
import '/core/viewModel/homeViewModel.dart';
import 'mobileMessageView.dart';
import '/responsive.dart';
import '/core/viewModel/messageViewModel.dart';
import 'package:get/get.dart';
import 'widgets/messageBodyView/messageBodyView.dart';
import 'widgets/messsagesHeader.dart';
import 'package:flutter/material.dart';

class MessagesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MessageViewModel>(
        init: MessageViewModel(),
        builder: (messageController) => messageController.isLoading.value
            ? Center(child: CircularProgressIndicator())
            : messageController.headerMessages.isEmpty &&
                    messageController.toUser == null
                ? Center(
                    child: CustomText(
                      txt: 'No messages yet !',
                      fSize: 20,
                    ),
                  )
                : Responsive.isMobile(context)
                    ? WillPopScope(
                        onWillPop: () async =>
                            Get.find<HomeViewModel>().currentItem == 'dash'
                                ? true
                                : false,
                        child: MoblieMessageView(),
                      )
                    : Row(
                        children: [
                          LimitedBox(
                            maxWidth: 300,
                            child: MessagesHeader(),
                          ),
                          VerticalDivider(
                            color: Colors.grey,
                            thickness: 0.5,
                          ),
                          Expanded(child: MessageBodyView())
                        ],
                      ));
  }
}
