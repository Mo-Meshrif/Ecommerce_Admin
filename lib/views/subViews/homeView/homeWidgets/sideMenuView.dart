import 'package:ecommerce_admin/widgets/customText.dart';
import 'package:flutter/material.dart';
import '../../../../const.dart';

class SideMenuView extends StatelessWidget {
  SideMenuView({
    @required this.homeItems,
    @required this.onTap,
  });
  final List<Map<String, String>> homeItems;
  final void Function(int val) onTap;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: homeItems.length,
      padding: EdgeInsets.only(left: 20),
      itemBuilder: (context, i) => GestureDetector(
        onTap: () => onTap(i),
        child: ListTile(
          leading: Image.asset(
            homeItems[i]['icon'],
            color: swatchColor,
            width: 40,
            height: 40,
          ),
          title: CustomText(
            txt: homeItems[i]['title'],
            txtColor: swatchColor,
          ),
        ),
      ),
      separatorBuilder: (context, i) => SizedBox(
        height: 10,
      ),
    );
  }
}
