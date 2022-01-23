import '/helper/navigation_service.dart';
import '/locator.dart';
import '/const.dart';
import '../../helper/localStorageData.dart';
import '../../model/userModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeViewModel extends GetxController {
  final GlobalKey<ScaffoldState> homeScaffoldKey = GlobalKey<ScaffoldState>();
  List<Map<String, String>> items = [];
  int currentIndex = 0;
  LocalStorageData _localStorageData = Get.find<LocalStorageData>();
  UserModel savedUser;
  ValueNotifier<bool> sortCustomersAscending = ValueNotifier(true);
  ValueNotifier<bool> sortShopsAscending = ValueNotifier(true);
  String sortCustomersColumn, sortShopsColumn;
  onInit() {
    getSavedUser();
    super.onInit();
  }

  getSavedUser() {
    _localStorageData.getUser.then((user) {
      savedUser = user;
      update();
      initHomeView();
    });
  }

  initHomeView() {
    if (savedUser != null) {
      String role = savedUser.role;
      items = role == 'Admin' ? adminItems : mangerItems;
      update();
      String initRoute =
          role == 'Admin' ? categoriesPageRoute : dashboardPageRoute;
      locator<NavigationService>().navigateTo(initRoute);
    }
  }

  handleClickItem(int i) {
    if (Get.currentRoute != items[i]['route'])
      locator<NavigationService>().navigateTo(items[i]['route']);
  }

  getCurrentIndex(val) {
    currentIndex = val;
    update();
  }

  //Customers_Logic
  onSortCustomer(List<Map<String, dynamic>> customersList, val) {
    sortCustomersColumn = val;
    sortCustomersAscending.value = !sortCustomersAscending.value;
    if (sortCustomersAscending.value) {
      customersList.sort((a, b) =>
          b["$sortCustomersColumn"].compareTo(a["$sortCustomersColumn"]));
    } else {
      customersList.sort((a, b) =>
          a["$sortCustomersColumn"].compareTo(b["$sortCustomersColumn"]));
    }
    update();
  }

  //Shops_Logic
  onSortShops(List<Map<String, dynamic>> shopsList, val) {
    sortShopsColumn = val;
    sortShopsAscending.value = !sortShopsAscending.value;
    if (sortShopsAscending.value) {
      shopsList.sort(
          (a, b) => b["$sortShopsColumn"].compareTo(a["$sortShopsColumn"]));
    } else {
      shopsList.sort(
          (a, b) => a["$sortShopsColumn"].compareTo(b["$sortShopsColumn"]));
    }
    update();
  }
}
