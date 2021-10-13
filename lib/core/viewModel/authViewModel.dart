import '../../views/subViews/authView/forgetPasswordView.dart';
import '../../views/subViews/authView/signInView.dart';
import '../../views/subViews/authView/signUpView.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthViewModel extends GetxController {
  int currentIndex = 0;
  List<Widget> authViews = [
    SignInView(),
    SignUpView(),
    ForgetPasswordView(),
  ];
  getAuthIndex(val) {
    currentIndex = val;
    update();
  }
}
