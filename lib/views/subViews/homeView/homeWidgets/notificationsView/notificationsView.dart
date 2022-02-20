import '/core/viewModel/authViewModel.dart';
import '/core/viewModel/notificationViewModel.dart';
import '/model/notificationModel.dart';
import '/model/userModel.dart';
import 'package:get/get.dart';
import 'widgets/notificationItem.dart';
import '../../../../../widgets/customText.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationsView extends StatelessWidget {
  final List<NotificationModel> notifications;
  NotificationsView({required this.notifications});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<NotificationViewModel>(
      builder: (notificationController) => AlertDialog(
        alignment: Alignment.topRight,
        insetPadding: EdgeInsets.fromLTRB(0, 10, 20, 0),
        contentPadding: const EdgeInsets.all(5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: CustomText(
          txt: 'Notifications',
          fSize: 15,
          txtColor: Colors.grey[900],
        ),
        content: Container(
            height: size.height * 0.6,
            width: 200,
            child: notifications.isEmpty
                ? Center(
                    child: CustomText(
                      txt: "You haven't any notifications !",
                    ),
                  )
                : Column(
                    children: [
                      Divider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                      Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: notifications.length,
                          itemBuilder: (_, i) {
                            UserModel from = Get.find<AuthViewModel>()
                                .users
                                .firstWhere(
                                    (user) => user.id == notifications[i].from);
                            bool isMessage =
                                notifications[i].message!.contains('message')
                                    ? true
                                    : false;
                            return GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                                notificationController.handleNotificationTapped(
                                  notifications[i].id as String,
                                  notifications[i].message,
                                );
                              },
                              child: NotificationItem(
                                seen: notifications[i].seen as bool,
                                icon: isMessage
                                    ? Icons.mail
                                    : Icons.delivery_dining,
                                content: notifications[i].message as String,
                                from: from.userName as String,
                                time: DateFormat('hh:mm a').format(
                                  notifications[i].createdAt!.toDate(),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  )),
      ),
    );
  }
}
