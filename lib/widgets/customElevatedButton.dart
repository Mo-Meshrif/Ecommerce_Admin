import 'package:flutter/material.dart';
import 'customText.dart';

class CustomElevatedButton extends StatelessWidget {
  final Color buttonColor;
  final void Function() onpress;
  final String title;
  final Color? titleColor;

  CustomElevatedButton({
    required this.buttonColor,
    required this.onpress,
    required this.title,
    this.titleColor,
  });
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: buttonColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      onPressed: onpress,
      child: CustomText(
        txt: title,
        txtColor: titleColor,
      ),
    );
  }
}
