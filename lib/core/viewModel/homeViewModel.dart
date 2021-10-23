import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class HomeViewModel extends GetxController {
  int currentItem = 0;
  ValueNotifier<bool> isNotify=ValueNotifier(false);
  changeItemsIndex(val) {
    currentItem = val;
    isNotify.value=false;
    update();
  }
  changeNotifyState(){
    isNotify.value=true;
    update();
  }
}
