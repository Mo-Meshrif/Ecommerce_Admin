import '/core/viewModel/messageViewModel.dart';
import '/model/userModel.dart';
import '/../../../../const.dart';
import '/widgets/customText.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class UpperBodyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MessageViewModel>(
      builder: (messageController) {
        UserModel notMe = messageController.toUser;
        return notMe != null
            ? Padding(
                padding: const EdgeInsets.fromLTRB(8, 15, 0, 8),
                child: Row(
                  children: [
                    CustomText(
                      txt: 'To:',
                    ),
                    SizedBox(width: 15),
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: priColor,
                          borderRadius: BorderRadius.circular(5)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomText(
                            txt: notMe.userName,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: GestureDetector(
                                onTap: () =>
                                    messageController.restToUserValues(),
                                child: Icon(
                                  Icons.close,
                                  size: 15,
                                )),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : Padding(padding: EdgeInsets.only(top: 5));
      },
    );
  }
}
