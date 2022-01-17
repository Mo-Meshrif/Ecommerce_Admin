import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../const.dart';
import '/core/service/fireStore_user.dart';
import '/core/viewModel/authViewModel.dart';
import '/core/viewModel/homeViewModel.dart';
import '/model/notificationModel.dart';
import 'notificationsView/notificationsView.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavTopView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeViewModel>(
      builder: (homeController) => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          StreamBuilder(
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
                        notify.to.indexOf(homeController.savedUser.id) >= 0)
                    .toList();
                bool hasNew = notifications
                        .indexWhere((notify) => !notify.seen)
                        .isNegative
                    ? false
                    : true;
                return GestureDetector(
                  onTap: () => Get.isDialogOpen
                      ? Navigator.of(Get.overlayContext).pop()
                      : Get.dialog(
                          NotificationsView(notifications: notifications),
                          barrierColor: Colors.grey[50],
                        ),
                  child: Stack(
                    children: [
                      Icon(
                        Icons.notifications,
                        size: 40,color: Colors.black,
                      ),
                      hasNew
                          ? Positioned(
                              top: 4,
                              left: 9,
                              child: Container(
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                            )
                          : Padding(padding: EdgeInsets.zero)
                    ],
                  ),
                );
              }),
          GestureDetector(
            onTap: () {
              FireStoreUser().updateOnlineState(
                homeController.savedUser.id,
                false,
              );
              Get.find<AuthViewModel>().logout();
              Get.offNamedUntil(rootRoute, (route) => false);
            },
            child: Icon(
              Icons.power_settings_new,
              size: 40,color: Colors.black,
            ),
          ),
          SizedBox(width: 10)
        ],
      ),
    );
  }
}
