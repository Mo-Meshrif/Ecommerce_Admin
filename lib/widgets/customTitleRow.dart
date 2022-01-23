import 'package:flutter/material.dart';
import 'customText.dart';

class CustomTitleRow extends StatelessWidget {
  final String title;
  final Widget content;

  CustomTitleRow({@required this.title, @required this.content});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          txt: title,
          txtColor: Colors.grey[700],
        ),
        content
      ],
    );
  }
}
