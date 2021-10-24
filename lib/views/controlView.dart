import '../core/viewModel/homeViewModel.dart';
import '../core/viewModel/authViewModel.dart';
import '../views/mainViews/authView.dart';
import '../views/mainViews/homeView.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ControlView extends GetWidget<AuthViewModel> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.user != null
        ? GetBuilder<HomeViewModel>(
            init: HomeViewModel(),
            builder: (homeController) => homeController.savedUser == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : HomeView())
        : AuthView());
  }
}
