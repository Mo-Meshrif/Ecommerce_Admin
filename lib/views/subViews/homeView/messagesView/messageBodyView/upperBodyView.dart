import '/core/viewModel/messageViewModel.dart';
import '/model/userModel.dart';
import '../../../../../const.dart';
import '/widgets/customText.dart';
import '/widgets/customTextField.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class UpperBodyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<MessageViewModel>(
      builder: (messageController) {
        String messageVal = messageController.toValue;
        UserModel notMe = messageController.toUser;
        return Column(
          children: [
            SizedBox(height: 5),
            notMe != null
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
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
                : Container(
                    height: 40,
                    child: CustomTextField(
                      bodyColor: null,
                      onTaped: () => messageController.openToBar(),
                      onChanged: (val) => messageController.getToVal(val),
                      valid: null,
                      hintTxt: null,
                      icon: null,
                      prefix: Padding(
                        padding: const EdgeInsets.only(top: 13),
                        child: CustomText(
                          txt: 'To:',
                        ),
                      ),
                    )),
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Divider(
                    color: Colors.grey[350],
                    thickness: 0.5,
                  ),
                ),
                messageController.isToBarClicked.value
                    ? Container(
                        margin: EdgeInsets.only(left: 50),
                        height: 400,
                        width: (size.width - 350) * 0.3,
                        child: Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('Users')
                                  .where('role', isEqualTo: 'Manger')
                                  .snapshots(),
                              builder: (context, snapshot) {
                                List<DocumentSnapshot> userSnap =
                                    snapshot.hasData ? snapshot.data.docs : [];
                                List<UserModel> spUsers = userSnap
                                    .map(
                                        (doc) => UserModel.fromJson(doc.data()))
                                    .where((element) => messageVal != ''
                                        ? element.userName
                                            .startsWith(messageVal)
                                        : false)
                                    .toList();
                                return ListView.builder(
                                    controller: ScrollController(),
                                    itemCount: spUsers.length,
                                    itemBuilder: (context, i) {
                                      return GestureDetector(
                                        onTap: () {
                                          messageController
                                              .getToUser(spUsers[i]);
                                          messageController.closeToBar();
                                        },
                                        child: ListTile(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 5, vertical: 10),
                                          horizontalTitleGap: 8,
                                          leading: CircleAvatar(
                                            radius: 30,
                                            child: Icon(Icons.person),
                                          ),
                                          title: CustomText(
                                            txt: spUsers[i].userName,
                                          ),
                                        ),
                                      );
                                    });
                              }),
                        ),
                      )
                    : Padding(padding: EdgeInsets.zero),
              ],
            ),
          ],
        );
      },
    );
  }
}
