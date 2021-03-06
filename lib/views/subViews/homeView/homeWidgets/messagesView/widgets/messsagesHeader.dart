import '/core/viewModel/homeViewModel.dart';
import '/model/userModel.dart';
import '/model/messageModel.dart';
import '/core/viewModel/messageViewModel.dart';
import '/../../../widgets/customText.dart';
import '/../../../widgets/customTextField.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class MessagesHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MessageViewModel>(builder: (messageController) {
      UserModel me = messageController.homeViewModel.savedUser as UserModel;
      List<MessageModel> headerMesssage = messageController.headerMessages;
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            child: CustomTextField(
              bodyColor: Colors.grey[200] as Color,
              onChanged: (val) => messageController.getSearchedMessage(val),
              valid: null,
              hintTxt: 'Search Messanger',
              icon: null,
              prefix: Icon(Icons.search),
              shapeIsCircular: true,
            ),
          ),
          Expanded(
              child: ListView.builder(
                  controller: ScrollController(),
                  itemCount: headerMesssage.length,
                  itemBuilder: (context, i) {
                    bool isOpened = (headerMesssage[i].isOpened as bool) ||
                        headerMesssage[i].from!.id ==
                            messageController.homeViewModel.savedUser!.id;
                    UserModel notMe = me.id == headerMesssage[i].from!.id
                        ? headerMesssage[i].to as UserModel
                        : headerMesssage[i].from as UserModel;
                    return GestureDetector(
                      onTap: () {
                        messageController.getIndexOfShownMessage(i);
                        if (me.id == headerMesssage[i].to!.id) {
                          messageController.updateMessage(headerMesssage[i].id);
                        }
                        Get.find<HomeViewModel>().getCurrentItem('chat');
                      },
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 5),
                        horizontalTitleGap: 8,
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundImage: notMe.pic == null
                              ? AssetImage('assets/order/person.png')
                              : NetworkImage(notMe.pic as String)
                                  as ImageProvider,
                        ),
                        title: CustomText(
                          txt: notMe.userName!.capitalizeFirst as String,
                        ),
                        subtitle: CustomText(
                          txt: headerMesssage[i].lastMessage ??
                              ('${notMe.userName!.capitalizeFirst}' +
                                  ' sent a photo'),
                          txtColor: isOpened ? Colors.grey : null,
                        ),
                        trailing: Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              CustomText(
                                txt: DateFormat('h:mm a').format(
                                  headerMesssage[i].messageTime!.toDate(),
                                ),
                                fSize: 17,
                              ),
                              isOpened
                                  ? Padding(padding: EdgeInsets.zero)
                                  : Padding(
                                      padding: const EdgeInsets.only(top: 5),
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
