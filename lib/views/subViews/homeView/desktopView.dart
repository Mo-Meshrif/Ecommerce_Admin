import '/widgets/customText.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../const.dart';
import 'homeWidgets/navTopView.dart';
import 'homeWidgets/sideMenuView.dart';

class DesktopView extends StatelessWidget {
  const DesktopView({
    required this.homeItems,
    required this.child,
    required this.itemTap,
  });

  final List<Map<String, String>> homeItems;
  final Widget child;
  final void Function(int i) itemTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                HexColor('#0f0c29'),
                HexColor('#2B32B2'),
                HexColor('#0f0c29'),
              ],
            ),
          ),
          width: 220,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: CustomText(
                  txt: 'Ecommerce App',
                  txtColor: swatchColor,
                  fSize: 20,
                  fWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                  child: SideMenuView(
                homeItems: homeItems,
                onTap: itemTap,
              ))
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Container(
                height: 30,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[200] as Color,
                      offset: Offset(3, 5),
                      blurRadius: 10,
                    )
                  ],
                ),
                margin: EdgeInsets.symmetric(vertical: 10),
                child: NavTopView(),
              ),
              Expanded(child: child),
            ],
          ),
        ),
      ],
    );
  }
}
