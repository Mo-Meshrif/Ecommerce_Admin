import '/widgets/notificationItem.dart';
import '../../widgets/customText.dart';
import 'package:flutter/material.dart';

class NotificationsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 60),
      child: AlertDialog(
        alignment: Alignment.bottomRight,
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
            child: Column(
              children: [
                Divider(
                  thickness: 1,
                  color: Colors.grey,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: 7,
                    itemBuilder: (_, i) => GestureDetector(
                      onTap: () => null,
                      child: NotificationItem(
                        icon: Icons.mail,
                        content: 'New message from ',
                        from: 'meshrif',
                        time: '1 hour ago',
                      ),
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
