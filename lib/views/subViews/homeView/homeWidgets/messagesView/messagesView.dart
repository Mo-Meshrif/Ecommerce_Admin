import '/core/viewModel/messageViewModel.dart';
import 'package:get/get.dart';
import 'messageBodyView/messageBodyView.dart';
import 'messsagesHeader.dart';
import 'package:flutter/material.dart';

class MessagesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MessageViewModel>(
        init: MessageViewModel(),
        builder: (messageController) =>
            messageController.headerMessages.isEmpty &&
                    messageController.isLoading.value
                ? Center(child: CircularProgressIndicator())
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
