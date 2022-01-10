import '/core/viewModel/authViewModel.dart';
import '/core/viewModel/notificationViewModel.dart';
import '/model/notificationModel.dart';
import '/model/userModel.dart';
import 'package:get/get.dart';
import '/widgets/notificationItem.dart';
import '../../widgets/customText.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationsView extends StatelessWidget {
  final List<NotificationModel> notifications;
  NotificationsView({@required this.notifications});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationViewModel>(
      builder: (notificationController) => AlertDialog(
        alignment: Alignment.topRight,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: CustomText(
          txt: 'Notifications',
          fSize: 15,
          txtColor: Colors.grey[900],
        ),
        content: Container(
            height: 400,
            width: 300,
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
                          itemCount: notifications.length,
                          itemBuilder: (_, i) {
                            UserModel from = Get.find<AuthViewModel>()
                                .users
                                .firstWhere((user) =>
                                    user.id == notifications[i].from);
                            bool isMessage =
                                notifications[i].message.contains('message')
                                    ? true
                                    : false;
                            return GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                                notificationController
                                    .handleNotificationTapped(
                                  notifications[i].id,
                                  notifications[i].message,
                                );
                              },
                              child: NotificationItem(
                                seen: notifications[i].seen,
                                icon: isMessage
                                    ? Icons.mail
                                    : Icons.delivery_dining,
                                content: notifications[i].message,
                                from: from.userName,
                                time: DateFormat('hh:mm a').format(
                                  notifications[i].createdAt.toDate(),
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
