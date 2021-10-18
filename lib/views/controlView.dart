import '../core/viewModel/authViewModel.dart';
import '../views/mainViews/authView.dart';
import '../views/mainViews/homeView.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ControlView extends GetWidget<AuthViewModel> {
  @override
  Widget build(BuildContext context) {
    return Obx(()=>controller.user!=null? HomeView() : AuthView());
  }
}
