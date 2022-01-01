import 'package:flutter/material.dart';
import 'customText.dart';

class NotificationItem extends StatelessWidget {
  final bool seen;
  final IconData icon;
  final String content, from, time;

  NotificationItem({
    @required this.seen,
    @required this.icon,
    @required this.content,
    @required this.from,
    @required this.time,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        !seen
            ? CircleAvatar(
                backgroundColor: Colors.red,
                radius: 6,
              )
            : Padding(padding: EdgeInsets.only(left: 12)),
        Expanded(
          child: ListTile(
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
                    text: content+'from ',
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
          ),
        ),
      ],
    );
  }
}
