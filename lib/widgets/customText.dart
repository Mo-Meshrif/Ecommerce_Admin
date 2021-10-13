import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String txt;
  final double fSize;
  final int maxLine;
  final Color txtColor;
  final FontWeight fWeight;
  CustomText({this.txt, this.fSize, this.txtColor, this.fWeight, this.maxLine});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        txt,
        maxLines: maxLine ?? 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: fSize,
          color: txtColor ?? Colors.black,
          fontWeight: fWeight,
        ),
      ),
    );
  }
}
