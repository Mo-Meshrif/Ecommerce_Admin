import '../core/viewModel/authViewModel.dart';
import '../views/mainViews/authView.dart';
import '../views/mainViews/homeView.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ControlView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthViewModel>(
      builder: (authController) =>
          authController.isAuth() ? HomeView() : AuthView(),
    );
  }
}
