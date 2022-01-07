import '/model/userModel.dart';
import '/model/messageModel.dart';
import '/core/viewModel/messageViewModel.dart';
import '../../../../widgets/customText.dart';
import '../../../../widgets/customTextField.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class MessagesHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MessageViewModel>(builder: (messageController) {
      UserModel me = messageController.homeViewModel.savedUser;
      List<MessageModel> headerMesssage = messageController.headerMessages;
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    bodyColor: Colors.grey[200],
                    onChanged: (val) =>
                        messageController.getSearchedMessage(val),
                    valid: null,
                    hintTxt: 'Search Messanger',
                    icon: null,
                    prefix: Icon(Icons.search),
                    shapeIsCircular: true,
                  ),
                ),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: () => messageController.isNew(),
                  child: CircleAvatar(
                    child: Icon(messageController.isNewMessage.value
                        ? Icons.close
                        : Icons.post_add),
                  ),
                )
              ],
            ),
          ),
          Expanded(
              child: headerMesssage.isEmpty
                  ? Center(
                      child: CustomText(
                        txt: 'No Message !',
                      ),
                    )
                  : ListView.builder(
                      controller: ScrollController(),
                      itemCount: headerMesssage.length,
                      itemBuilder: (context, i) {
                        bool isOpened = headerMesssage[i].isOpened ||
                            headerMesssage[i].from.id ==
                                messageController.homeViewModel.savedUser.id;
                        UserModel notMe = me.id == headerMesssage[i].from.id
                            ? headerMesssage[i].to
                            : headerMesssage[i].from;
                        return GestureDetector(
                          onTap: () {
                            messageController.getIndexOfShownMessage(i);
                            if (me.id == headerMesssage[i].to.id) {
                              messageController
                                  .updateMessage(headerMesssage[i].id);
                            }
                          },
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(horizontal: 5),
                            horizontalTitleGap: 8,
                            leading: CircleAvatar(
                              radius: 30,
                              backgroundImage: notMe.pic == null
                                  ? AssetImage('assets/order/person.png')
                                  : NetworkImage(notMe.pic),
                            ),
                            title: CustomText(
                              txt: notMe.userName.capitalizeFirst,
                            ),
                            subtitle: CustomText(
                              txt: headerMesssage[i].lastMessage ??
                                  ('${notMe.userName.capitalizeFirst}' +
                                      ' sent a photo'),
                              txtColor: isOpened ? Colors.grey : null,
                            ),
                            trailing: Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  CustomText(
                                    txt: DateFormat('h:mm a').format(
                                        headerMesssage[i].messageTime.toDate()),
                                    fSize: 17,
                                  ),
                                  isOpened
                                      ? Padding(padding: EdgeInsets.zero)
                                      : Padding(
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          child: CircleAvatar(
                                            radius: 6,
                                          ),
                                        )
                                ],
                              ),
                            ),
                          ),
                        );
                      })),
        ],
      );
    });
  }
}
