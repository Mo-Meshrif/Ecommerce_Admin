import 'package:flutter/material.dart';
import '../../../../../../widgets/customText.dart';

class CardItem extends StatelessWidget {
  final String subtitle;
  final String title;
  final String value;
  final Color? color1;
  final Color? color2;

  CardItem({
    required this.title,
    required this.value,
    this.color1,
    this.color2,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          gradient: LinearGradient(
              colors: [color1 ?? Colors.green, color2 ?? Colors.blue],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[300] as Color,
              offset: Offset(0, 3),
              blurRadius: 16,
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ListTile(
                title: CustomText(
                  txt: title,
                  fWeight: FontWeight.bold,
                  txtColor: Colors.white,
                ),
                subtitle: CustomText(
                  txt: subtitle,
                  fWeight: FontWeight.w400,
                  txtColor: Colors.white,
                  maxLine: 2,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 14),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    txt: value,
                    fSize: 18,
                    fWeight: FontWeight.bold,
                    txtColor: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
