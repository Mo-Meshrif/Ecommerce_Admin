import 'package:flutter/material.dart';
import 'customText.dart';

class NotificationItem extends StatelessWidget {
  final IconData icon;
  final String content, from, time;

  NotificationItem(
      {@required this.icon,
      @required this.content,
      @required this.from,
      @required this.time});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 40,
        child: Row(
          children: [
            Icon(icon),
            VerticalDivider(),
          ],
        ),
      ),
      title: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: content,
              style: TextStyle(color: Colors.black),
            ),
            TextSpan(
              text: from,
              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
      ),
      subtitle: CustomText(
        txt: time,
        txtColor: Colors.grey,
      ),
    );
  }
}
