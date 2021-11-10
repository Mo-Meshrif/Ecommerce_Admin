import 'messageBodyView.dart';
import 'messsagesHeader.dart';
import 'package:flutter/material.dart';

class MessagesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        Container(
          width: 350,
          height: size.height,
          child: MessagesHeader(),
        ),
        VerticalDivider(
          color: Colors.grey,
          thickness: 0.5,
        ),
        Expanded(
          child: MessageBody(),
        )
      ],
    );
  }
}
