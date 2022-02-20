import '/responsive.dart';
import '/widgets/customText.dart';
import '/core/viewModel/messageViewModel.dart';
import '/model/messageModel.dart';
import '/model/userModel.dart';
import '/views/subViews/homeView/homeWidgets/messagesView/widgets/messageBodyView/LowerBodyView.dart';
import '/views/subViews/homeView/homeWidgets/messagesView/widgets/messageBodyView/upperBodyView.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class MessageBodyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      GetBuilder<MessageViewModel>(builder: (messageController) {
        UserModel? notMe = messageController.toUser;
        UserModel me = messageController.homeViewModel.savedUser as UserModel;
        List<MessageModel> headerMessages = messageController.headerMessages;
        int indexOfShownMessage = messageController.indexOfShownMessage as int;
        MessageModel currentMessage;
        UserModel? to;
        UserModel? from;
        if (headerMessages.isNotEmpty && !indexOfShownMessage.isNegative) {
          currentMessage = headerMessages[indexOfShownMessage];
          to = currentMessage.to;
          from = currentMessage.from;
        }
        bool hasNotMe = notMe != null ? true : false;
        return hasNotMe
            ? Column(
                children: [
                  Responsive.isMobile(context)
                      ? Padding(padding: EdgeInsets.zero)
                      : UpperBodyView(),
                  hasNotMe
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
                    notMe: me.id == to.id ? from as UserModel : to,
                    me: me,
                  )
                : messageController.headerMessages.isEmpty
                    ? Padding(padding: EdgeInsets.zero)
                    : indexOfShownMessage.isNegative
                        ? Center(
                            child: CustomText(
                              txt:
                                  "Select your message from the left corner to see it's content !",
                              maxLine: 2,
                              fSize: 15,
                            ),
                          )
                        : Padding(padding: EdgeInsets.zero);
      });
}
