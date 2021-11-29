import 'customText.dart';
import 'package:flutter/material.dart';

class CustomPopupMenu extends StatelessWidget {
  final String title;
  final List<String> items;

  CustomPopupMenu({@required this.title, @required this.items});
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), color: Colors.grey[350]),
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                txt: title,
                txtColor: Colors.grey,
              ),
              Icon(
                Icons.arrow_drop_down,
                color: Colors.grey,
              )
            ],
          ),
        ),
        itemBuilder: (ctx) => items
            .map((e) => PopupMenuItem(
                    child: CustomText(
                  txt: e,
                )))
            .toList());
  }
}
