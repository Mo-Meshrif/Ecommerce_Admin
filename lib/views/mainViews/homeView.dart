import '/core/viewModel/messageViewModel.dart';
import '/core/viewModel/orderViewModel.dart';
import '/core/service/fireStore_user.dart';
import '/core/viewModel/categoryViewModel.dart';
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
        builder: (homeController) {
          AuthViewModel _auth = Get.find();
          if (_auth.users.isEmpty) _auth.getUsers();
          String userRole = homeController.savedUser.role;
          List<Map<String, String>> homeItems =
              userRole == 'Admin' ? adminItems : mangerItems;
          List<Widget> homeViews =
              userRole == 'Admin' ? adminViews : mangerViews;
          int index = homeController.currentItem;
          int messagesIndex = userRole == 'Admin' ? 3 : 1;
          int logoutIndex = homeItems.indexOf(homeItems.last);
          bool isNotify = homeController.isNotify.value;
          Get.put(CategoryViewModel());
          Get.put(OrderViewModel());
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
                        itemBuilder: (context, i) {
                          Color bodyColor =
                              index == i && i != logoutIndex && !isNotify
                                  ? swatchColor
                                  : priColor;
                          Color iconColor =
                              index == i && i != logoutIndex && !isNotify
                                  ? null
                                  : swatchColor;
                          BorderRadiusGeometry borderR =
                              index == i && i != logoutIndex
                                  ? BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      bottomLeft: Radius.circular(5))
                                  : null;
                          Color contentColor =
                              index == i && i != logoutIndex && !isNotify
                                  ? priColor
                                  : swatchColor;
                          return GestureDetector(
                            onTap: () {
                              homeController.changeItemsIndex(i);
                              if (i == logoutIndex) {
                                FireStoreUser().updateOnlineState(
                                  homeController.savedUser.id,
                                  false,
                                );
                                Get.delete<MessageViewModel>();
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
                        : index != logoutIndex
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
            floatingActionButton:
                index != logoutIndex && index != messagesIndex && !isNotify
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
