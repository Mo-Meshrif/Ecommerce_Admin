import '/helper/navigation_service.dart';
import '/locator.dart';
import '/const.dart';
import '../../helper/localStorageData.dart';
import '../../model/userModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeViewModel extends GetxController {
  final GlobalKey<ScaffoldState> homeScaffoldKey = GlobalKey<ScaffoldState>();
  String currentItem = 'dash';
  LocalStorageData _localStorageData = Get.find<LocalStorageData>();
  UserModel? savedUser;
  onInit() {
    getSavedUser();
    super.onInit();
  }

  getSavedUser() {
    _localStorageData.getUser.then((user) {
      savedUser = user;
      update();
      if (savedUser != null) {
        locator<NavigationService>().navigateTo(dashboardPageRoute);
      }
    });
  }

  handleClickItem(int i) {
    if (Get.currentRoute != items[i]['route'])
      locator<NavigationService>().navigateTo(items[i]['route']as String);
  }

  getCurrentItem(String val) {
    currentItem = val;
    update();
  }
}
