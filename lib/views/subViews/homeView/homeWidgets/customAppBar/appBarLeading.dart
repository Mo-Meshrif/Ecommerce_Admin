import '/core/viewModel/categoryViewModel.dart';
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
      String currentItem = homeController.currentItem;
      return currentItem != 'dash' && Responsive.isMobile(context)
          ? IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                switch (currentItem) {
                  case 'addCategory':
                    Get.find<CategoryViewModel>().restCatParameters();
                    Get.find<CategoryViewModel>().getMobileViewStatus(false);
                    break;
                  case 'editCategory':
                    Get.find<CategoryViewModel>().restCatParameters();
                    Get.find<CategoryViewModel>().getMobileViewStatus(false);
                    break;
                  case 'chat':
                    Get.find<MessageViewModel>().getIndexOfShownMessage(null);
                    break;
                  case 'order':
                    Get.find<OrderViewModel>().getMobileViewStatus(false);
                    break;
                  case 'addProduct':
                    Get.find<ProductViewModel>().restProdParameters();
                    Get.find<ProductViewModel>().getMobileViewStatus(false);
                    break;
                  case 'editProduct':
                    Get.find<ProductViewModel>().restProdParameters();
                    Get.find<ProductViewModel>().getMobileViewStatus(false);
                    break;
                  default:
                }
                homeController.getCurrentItem('dash');
              },
            )
          : IconButton(
              icon: Icon(
                Icons.menu,
                color: Colors.black,
              ),
              onPressed: () =>
                  homeController.homeScaffoldKey.currentState!.openDrawer(),
            );
    });
  }
}
