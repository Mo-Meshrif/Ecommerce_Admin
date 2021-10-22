import 'package:get/get.dart';

class HomeViewModel extends GetxController {
  int currentItem = 0;
  changeItemsIndex(val) {
    currentItem = val;
    update();
  }
}
