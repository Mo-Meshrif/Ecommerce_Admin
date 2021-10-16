import 'package:ecommerce_admin/helper/localStorageData.dart';

import '/core/viewModel/authViewModel.dart';
import 'package:get/get.dart';

class Binds extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => AuthViewModel());
    Get.lazyPut(() =>LocalStorageData());
  }

}