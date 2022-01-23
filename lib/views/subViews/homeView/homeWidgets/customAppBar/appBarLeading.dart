import '/core/viewModel/productViewModel.dart';
import '/core/viewModel/orderViewModel.dart';
import '/core/viewModel/messageViewModel.dart';
import '/core/viewModel/homeViewModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../responsive.dart';

class AppBarLeading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeViewModel>(builder: (homeController) {
      int currentIndex = homeController.currentIndex;
      return currentIndex != 0 && Responsive.isMobile(context)
          ? IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                switch (currentIndex) {
                  case 1:
                    Get.find<MessageViewModel>().getIndexOfShownMessage(null);
                    break;
                  case 2:
                    Get.find<OrderViewModel>().getMobileViewStatus(false);
                    break;
                  case 3:
                    Get.find<ProductViewModel>().restProdParameters();
                    Get.find<ProductViewModel>().getMobileViewStatus(false);
                    break;
                  default:
                }
                homeController.getCurrentIndex(0);
              },
            )
          : IconButton(
              icon: Icon(
                Icons.menu,
                color: Colors.black,
              ),
              onPressed: () =>
                  homeController.homeScaffoldKey.currentState.openDrawer(),
            );
    });
  }
}
