import 'package:cloud_firestore/cloud_firestore.dart';
import '/model/notificationModel.dart';
import '/core/viewModel/notificationViewModel.dart';
import '/core/viewModel/messageViewModel.dart';
import '/core/viewModel/orderViewModel.dart';
import '/core/service/fireStore_user.dart';
import '/core/viewModel/categoryViewModel.dart';
import '/views/subViews/notificationsView.dart';
import '../../const.dart';
import '../../core/viewModel/homeViewModel.dart';
import '../../core/viewModel/authViewModel.dart';
import '../../widgets/customText.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) => GetBuilder<HomeViewModel>(
        builder: (homeController) {
          AuthViewModel _auth = Get.find();
          if (_auth.users.isEmpty) _auth.getUsers();
          String userRole = homeController.savedUser.role;
          List<Map<String, String>> homeItems =
              userRole == 'Admin' ? adminItems : mangerItems;
          List<Widget> homeViews =
              userRole == 'Admin' ? adminViews : mangerViews;
          int index = homeController.currentItem;
          int logoutIndex = homeItems.indexOf(homeItems.last);
          Get.put(CategoryViewModel());
          Get.put(OrderViewModel());
          Get.put(NotificationViewModel());
          return Scaffold(
            body: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: priColor,
                  width: 220,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: CustomText(
                          txt: 'Ecommerce App',
                          txtColor: swatchColor,
                          fSize: 20,
                          fWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(
                          child: ListView.separated(
                        itemCount: homeItems.length,
                        padding: EdgeInsets.only(left: 20),
                        itemBuilder: (context, i) {
                          Color bodyColor = index == i && i != logoutIndex
                              ? swatchColor
                              : priColor;
                          Color iconColor = index == i && i != logoutIndex
                              ? null
                              : swatchColor;
                          BorderRadiusGeometry borderR =
                              index == i && i != logoutIndex
                                  ? BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      bottomLeft: Radius.circular(5))
                                  : null;
                          Color contentColor = index == i && i != logoutIndex
                              ? priColor
                              : swatchColor;
                          return GestureDetector(
                            onTap: () {
                              homeController.changeItemsIndex(i);
                              if (i == logoutIndex) {
                                FireStoreUser().updateOnlineState(
                                  homeController.savedUser.id,
                                  false,
                                );
                                Get.delete<MessageViewModel>();
                                Get.find<AuthViewModel>().logout();
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: bodyColor,
                                borderRadius: borderR,
                              ),
                              child: ListTile(
                                leading: Image.asset(
                                  homeItems[i]['icon'],
                                  color: iconColor,
                                  width: 40,
                                  height: 40,
                                ),
                                title: CustomText(
                                  txt: homeItems[i]['title'],
                                  txtColor: contentColor,
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, i) => SizedBox(
                          height: 10,
                        ),
                      ))
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: index != logoutIndex
                        ? homeViews[index]
                        : Center(
                            child: CustomText(
                              txt: 'Good bye !',
                            ),
                          ),
                  ),
                ),
              ],
            ),
            floatingActionButton: index != logoutIndex && index != 1
                ? StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('Notifications')
                        .orderBy('createdAt', descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      List<DocumentSnapshot> notificationsSnap =
                          snapshot.hasData ? snapshot.data.docs : [];
                      List<NotificationModel> notifications = notificationsSnap
                          .map(
                            (e) => NotificationModel.fromJson(
                              e.id,
                              e.data(),
                            ),
                          )
                          .where((notify) =>
                              notify.to.indexOf(homeController.savedUser.id) >=
                              0)
                          .toList();
                      bool hasNew = notifications
                              .indexWhere((notify) => !notify.seen)
                              .isNegative
                          ? false
                          : true;
                      return FloatingActionButton(
                        backgroundColor: priColor,
                        onPressed: () => showDialog(
                            context: context,
                            builder: (ctx) => NotificationsView(
                                notifications: notifications)),
                        child: Icon(
                          Icons.notifications,
                          color: hasNew ? Colors.red : null,
                        ),
                      );
                    })
                : null,
          );
        },
      );
}
