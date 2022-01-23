import 'package:cloud_firestore/cloud_firestore.dart';
import '/core/viewModel/homeViewModel.dart';
import '/core/viewModel/messageViewModel.dart';
import '/model/userModel.dart';
import '/responsive.dart';
import '/widgets/customText.dart';
import '/widgets/customTextField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MobileNewMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.bottomSheet(
        GetBuilder<MessageViewModel>(
          builder: (messageController) {
            String myRole = Get.find<HomeViewModel>().savedUser.role;
            String toVal = messageController.toValue;
            return Column(
              children: [
                Container(
                  height: 40,
                  child: CustomTextField(
                    bodyColor: null,
                    onTaped: () => null,
                    onChanged: (val) => messageController.getToVal(val),
                    valid: null,
                    hintTxt: null,
                    icon: null,
                    autoFocus: true,
                    prefix: Padding(
                      padding: const EdgeInsets.only(top: 13),
                      child: CustomText(
                        txt: 'To:',
                      ),
                    ),
                  ),
                ),
                Divider(
                  color: Colors.black,
                  thickness: 0.5,
                ),
                Expanded(
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('Users')
                            .where('role',
                                isEqualTo:
                                    myRole == 'Admin' ? 'Manger' : 'Admin')
                            .snapshots(),
                        builder: (context, snapshot) {
                          List<DocumentSnapshot> userSnap =
                              snapshot.hasData ? snapshot.data.docs : [];
                          List<UserModel> spUsers = toVal == ''
                              ? userSnap
                                  .map((doc) => UserModel.fromJson(
                                      false, doc.id, doc.data()))
                                  .toList()
                              : userSnap
                                  .map((doc) => UserModel.fromJson(
                                      false, doc.id, doc.data()))
                                  .where((element) => toVal != ''
                                      ? element.userName
                                          .toLowerCase()
                                          .startsWith(toVal.toLowerCase())
                                      : false)
                                  .toList();
                          return spUsers.isEmpty
                              ? toVal != ''
                                  ? Center(
                                      child: CustomText(
                                        txt: 'No User ! Try a new search',
                                      ),
                                    )
                                  : Padding(padding: EdgeInsets.zero)
                              : ListView.builder(
                                  controller: ScrollController(),
                                  itemCount: spUsers.length,
                                  itemBuilder: (context, i) => Column(
                                        children: [
                                          i == 0
                                              ? CustomText(
                                                  txt: 'SUGGESTED',
                                                )
                                              : Padding(
                                                  padding: EdgeInsets.zero),
                                          GestureDetector(
                                            onTap: () {
                                              messageController
                                                  .getOrderNumber(null);
                                              messageController
                                                  .getToUser(spUsers[i]);
                                              messageController.closeToBar();
                                              if (Responsive.isMobile(
                                                  context)) {
                                                Get.find<HomeViewModel>()
                                                    .getCurrentIndex(1);
                                                Get.back();
                                              }
                                            },
                                            child: ListTile(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 5,
                                                      vertical: 10),
                                              horizontalTitleGap: 8,
                                              leading: CircleAvatar(
                                                radius: 30,
                                                backgroundImage: spUsers[i]
                                                            .pic ==
                                                        null
                                                    ? AssetImage(
                                                        'assets/order/person.png')
                                                    : NetworkImage(
                                                        spUsers[i].pic),
                                              ),
                                              title: CustomText(
                                                  txt: spUsers[i]
                                                      .userName
                                                      .capitalizeFirst),
                                            ),
                                          ),
                                        ],
                                      ));
                        }))
              ],
            );
          },
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        backgroundColor: Colors.grey[400],
        barrierColor: Colors.grey[50],
      ),
      child: CircleAvatar(
        child: Icon(Icons.post_add),
      ),
    );
  }
}
