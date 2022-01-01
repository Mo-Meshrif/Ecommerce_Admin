import '/core/viewModel/notificationViewModel.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'customElevatedButton.dart';
import 'customText.dart';

class OnMessageNotify extends StatelessWidget {
  final RemoteNotification notification;
  
  OnMessageNotify({@required this.notification});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      title: CustomText(
        txt: 'Alert',
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomText(
            txt: notification.body,
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomElevatedButton(
                title: 'Dismiss',
                onpress: () => Navigator.pop(context),
                buttonColor: Colors.red,
              ),
              GetBuilder<NotificationViewModel>(
                builder: (notificationController) => CustomElevatedButton(
                  title: 'Details',
                  onpress: () {
                    Navigator.pop(context);
                    notificationController
                        .handleOnMessageDetails(notification.body);
                  },
                  buttonColor: Colors.green,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
