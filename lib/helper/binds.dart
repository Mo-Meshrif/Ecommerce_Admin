import '/core/viewModel/notificationViewModel.dart';
import '/core/viewModel/dashboardViewModel.dart';
import '/core/viewModel/orderViewModel.dart';
import '/core/viewModel/productViewModel.dart';
import '/core/viewModel/messageViewModel.dart';
import '/core/viewModel/categoryViewModel.dart';
import '/core/viewModel/homeViewModel.dart';
import '/helper/localStorageData.dart';
import '/core/viewModel/authViewModel.dart';
import 'package:get/get.dart';

class Binds extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthViewModel());
    Get.lazyPut(() => LocalStorageData());
    Get.lazyPut(() => HomeViewModel());
    Get.lazyPut(() => CategoryViewModel());
    Get.lazyPut(() => MessageViewModel());
    Get.lazyPut(() => ProductViewModel());
    Get.lazyPut(() => OrderViewModel());
    Get.lazyPut(() => DashboardViewModel());
    Get.lazyPut(() => NotificationViewModel());
  }
}
