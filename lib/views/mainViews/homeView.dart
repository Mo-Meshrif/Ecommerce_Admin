import '../subViews/homeView/homeWidgets/customAppBar/appBarActions.dart';
import '../subViews/homeView/homeWidgets/customAppBar/appBarTitle.dart';
import '../subViews/homeView/homeWidgets/customAppBar/appBarLeading.dart';
import '/views/subViews/homeView/homeWidgets/sideMenuView.dart';
import '/views/subViews/homeView/desktopView.dart';
import 'package:hexcolor/hexcolor.dart';
import '/responsive.dart';
import '/core/viewModel/notificationViewModel.dart';
import '/core/viewModel/orderViewModel.dart';
import '/core/viewModel/categoryViewModel.dart';
import '../../const.dart';
import '../../core/viewModel/homeViewModel.dart';
import '../../core/viewModel/authViewModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  final Widget child;
  HomeView({@required this.child});
  @override
  Widget build(BuildContext context) => GetBuilder<HomeViewModel>(
        builder: (homeController) {
          AuthViewModel _auth = Get.find();
          if (_auth.users.isEmpty) _auth.getUsers();
          List<Map<String, String>> homeItems = homeController.items;
          Get.put(CategoryViewModel());
          Get.put(OrderViewModel());
          Get.put(NotificationViewModel());
          return Scaffold(
            key: homeController.homeScaffoldKey,
            appBar: !Responsive.isDesktop(context)
                ? AppBar(
                    backgroundColor: swatchColor,
                    elevation: 0,
                    leading: AppBarLeading(),
                    centerTitle: true,
                    title: AppBarTitle(),
                    actions: [AppBarActions()]
                  )
                : null,
            drawer: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 220),
              child: Container(
                padding: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      HexColor('#0f0c29'),
                      HexColor('#2B32B2'),
                      HexColor('#0f0c29'),
                    ],
                  ),
                ),
                child: SideMenuView(
                  homeItems: homeItems,
                  onTap: (i) => homeController.handleClickItem(i),
                ),
              ),
            ),
            body: Responsive(
              mobile: child,
              tablet: child,
              desktop: DesktopView(
                homeItems: homeItems,
                child: child,
                itemTap: (i) => homeController.handleClickItem(i),
              ),
            ),
          );
        },
      );
}
