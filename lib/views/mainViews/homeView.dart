import '/views/subViews/notificationsView.dart';
import '../../const.dart';
import '../../core/viewModel/homeViewModel.dart';
import '../../core/viewModel/authViewModel.dart';
import '../../widgets/customText.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) => GetBuilder<HomeViewModel>(
        init: HomeViewModel(),
        builder: (homeController) {
          int index = homeController.currentItem;
          bool isNotify = homeController.isNotify.value;
          return Scaffold(
            body: Row(
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
                        itemBuilder: (context, i) {
                          Color bodyColor = index == i && i != 6 && !isNotify
                              ? swatchColor
                              : priColor;
                          Color iconColor = index == i && i != 6 && !isNotify
                              ? null
                              : swatchColor;
                          BorderRadiusGeometry borderR = index == i && i != 6
                              ? BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  bottomLeft: Radius.circular(5))
                              : null;
                          Color contentColor = index == i && i != 6 && !isNotify
                              ? priColor
                              : swatchColor;
                          return GestureDetector(
                            onTap: () {
                              homeController.changeItemsIndex(i);
                              if (i == 6) {
                                Get.find<AuthViewModel>().logout();
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: bodyColor,
                                borderRadius: borderR,
                              ),
                              child: ListTile(
                                leading: Image.asset(
                                  homeItems[i]['icon'],
                                  color: iconColor,
                                  width: 40,
                                  height: 40,
                                ),
                                title: CustomText(
                                  txt: homeItems[i]['title'],
                                  txtColor: contentColor,
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, i) => SizedBox(
                          height: 10,
                        ),
                      ))
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: isNotify
                        ? NotificationsView()
                        : index != 6
                            ? homeViews[index]
                            : Center(
                                child: CustomText(
                                  txt: 'Good bye !',
                                ),
                              ),
                  ),
                ),
              ],
            ),
            floatingActionButton: index != 6 && !isNotify
                ? FloatingActionButton(
                    backgroundColor: priColor,
                    onPressed: () => homeController.changeNotifyState(),
                    child: Icon(Icons.notifications),
                  )
                : null,
          );
        },
      );
}
