import 'package:hexcolor/hexcolor.dart';
import '/responsive.dart';
import '../subViews/homeView/navTopView.dart';
import '/core/viewModel/notificationViewModel.dart';
import '/core/viewModel/orderViewModel.dart';
import '/core/viewModel/categoryViewModel.dart';
import '../../const.dart';
import '../../core/viewModel/homeViewModel.dart';
import '../../core/viewModel/authViewModel.dart';
import '../../widgets/customText.dart';
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
                    leading: IconButton(
                      icon: Icon(
                        Icons.menu,
                        color: Colors.black,
                      ),
                      onPressed: () => homeController
                          .homeScaffoldKey.currentState
                          .openDrawer(),
                    ),
                    title: CustomText(
                      txt: 'Ecommerce App',
                      txtColor: swatchColor,
                      fSize: 20,
                      fWeight: FontWeight.bold,
                    ),
                    actions: [
                      NavTopView(),
                    ],
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
                )),
                child: SideMenu(
                    homeItems: homeItems,
                    onTap: (i) => homeController.handleClickItem(i)),
              ),
            ),
            body: Responsive(
              mobile: Container(),
              tablet: child,
              desktop: Row(
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
                            child: SideMenu(
                          homeItems: homeItems,
                          onTap: (i) => homeController.handleClickItem(i),
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
                                color: Colors.grey[200],
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
              ),
            ),
          );
        },
      );
}

class SideMenu extends StatelessWidget {
  SideMenu({
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
