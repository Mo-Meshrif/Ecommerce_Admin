import '../../helper/localStorageData.dart';
import '../../model/userModel.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class HomeViewModel extends GetxController {
  int currentItem = 0;
  LocalStorageData _localStorageData = Get.find<LocalStorageData>();
  UserModel savedUser;
  ValueNotifier<bool> isNotify = ValueNotifier(false);
  onInit() {
    getSavedUser();
    super.onInit();
  }

  changeItemsIndex(val) {
    currentItem = val;
    isNotify.value = false;
    update();
  }

  changeNotifyState() {
    isNotify.value = true;
    update();
  }

  getSavedUser() {
    _localStorageData.getUser.then((user) {
      savedUser = user;
      update();
    });
  }
}
