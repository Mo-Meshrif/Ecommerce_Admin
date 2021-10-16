import '../../core/viewModel/authViewModel.dart';
import '../../widgets/customText.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomText(
          txt: 'HomeView',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=>Get.find<AuthViewModel>().logout(),
        child: Icon(Icons.close),
      ),
    );
  }
}
