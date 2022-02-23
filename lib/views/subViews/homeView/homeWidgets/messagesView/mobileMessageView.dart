import '/core/viewModel/messageViewModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'widgets/messageBodyView/messageBodyView.dart';
import 'widgets/messsagesHeader.dart';

class MoblieMessageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MessageViewModel>(
        builder: (messageController) =>
            messageController.indexOfShownMessage == -1 &&
                    messageController.toUser == null
                ? MessagesHeader()
                : MessageBodyView());
  }
}
