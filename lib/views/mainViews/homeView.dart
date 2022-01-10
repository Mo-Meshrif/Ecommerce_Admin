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
            body: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: priColor,
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
                          child: ListView.separated(
                        itemCount: homeItems.length,
                        padding: EdgeInsets.only(left: 20),
                        itemBuilder: (context, i) => GestureDetector(
                          onTap: () => homeController.handleClickItem(i),
                          child: Container(
                            color: priColor,
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
                        ),
                        separatorBuilder: (context, i) => SizedBox(
                          height: 10,
                        ),
                      ))
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      NavTopView(),
                      Expanded(child: child),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
}
