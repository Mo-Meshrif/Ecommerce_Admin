import '/widgets/customText.dart';
import '/core/viewModel/messageViewModel.dart';
import '/model/messageModel.dart';
import '/model/userModel.dart';
import '/views/subViews/homeView/messagesView/messageBodyView/LowerBodyView.dart';
import '/views/subViews/homeView/messagesView/messageBodyView/upperBodyView.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class MessageBodyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      GetBuilder<MessageViewModel>(builder: (messageController) {
        UserModel notMe = messageController.toUser;
        UserModel me = messageController.homeViewModel.savedUser;
        List<MessageModel> headerMessages = messageController.headerMessages;
        int indexOfShownMessage = messageController.indexOfShownMessage;
        MessageModel currentMessage;
        UserModel to;
        UserModel from;
        if (headerMessages.isNotEmpty && indexOfShownMessage != null) {
          currentMessage = headerMessages[indexOfShownMessage];
          to = currentMessage.to;
          from = currentMessage.from;
        }
        return messageController.isNewMessage.value
            ? Column(
                children: [
                  UpperBodyView(myRole: me.role),
                  notMe != null
                      ? Expanded(
                          child: LowerBodyView(
                            notMe: notMe,
                            me: me,
                          ),
                        )
                      : Padding(padding: EdgeInsets.zero),
                ],
              )
            : to != null
                ? LowerBodyView(
                    notMe: me.id == to.id ? from : to,
                    me: me,
                  )
                : indexOfShownMessage==null
                    ? Center(
                      child: CustomText(
                          txt:
                              "Select your message from the left corner to see it's content !",
                          maxLine: 2,
                          fSize: 18,
                        ),
                    )
                    : Padding(padding: EdgeInsets.zero);
      });
}
