import '../../const.dart';
import '../../core/viewModel/homeViewModel.dart';
import '../../core/viewModel/authViewModel.dart';
import '../../widgets/customText.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: GetBuilder<HomeViewModel>(
          init: HomeViewModel(),
          builder: (homeController) {
            int index = homeController.currentItem;
            return Row(
              children: [
                Container(
                  color: Colors.indigo,
                  width: 220,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: CustomText(
                          txt: 'Ecommerce App',
                          txtColor: Colors.white,
                          fSize: 20,
                          fWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(
                          child: ListView.separated(
                        itemCount: homeItems.length,
                        padding: EdgeInsets.only(left: 20),
                        itemBuilder: (context, i) {
                          Color bodyColor = index == i && i != 6
                              ? Colors.white
                              : Colors.indigo;
                          Color iconColor =
                              index == i && i != 6 ? null : Colors.white;
                          BorderRadiusGeometry borderR = index == i && i != 6
                              ? BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  bottomLeft: Radius.circular(5))
                              : null;
                          Color contentColor = index == i && i != 6
                              ? Colors.indigo
                              : Colors.white;
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
                    child: index != 6
                        ? homeViews[index]
                        : Center(
                            child: CustomText(
                              txt: 'Good bye !',
                            ),
                          ),
                  ),
                ),
              ],
            );
          },
        ),
      );
}
