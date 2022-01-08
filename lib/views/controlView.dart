import '/views/mainViews/homeView.dart';
import '../core/viewModel/homeViewModel.dart';
import '../core/viewModel/authViewModel.dart';
import '../views/mainViews/authView.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ControlView extends GetWidget<AuthViewModel> {
  final Widget child;

  ControlView({@required this.child});
  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.user != null
        ? GetBuilder<HomeViewModel>(
            init: HomeViewModel(),
            builder: (homeController) =>
                homeController.savedUser == null && child == AuthView()
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : HomeView(child: child),
          )
        : child);
  }
}
