import '../../../core/viewModel/authViewModel.dart';
import '../../../widgets/customText.dart';
import '../../../widgets/customTextField.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ForgetPasswordView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    GlobalKey<FormState> _key = GlobalKey<FormState>();
    return GetBuilder<AuthViewModel>(
      builder: (authController) => Form(
        key: _key,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                txt: "FORGET PASSWORD",
                fSize: 22,
                fWeight: FontWeight.bold,
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                onChanged: (val) => null,
                valid: (val) {
                  if (val.trim().isEmpty) {
                    return 'Enter your email !';
                  }
                  if (!val.trim().contains('@')) {
                    return 'Entered email is not valid';
                  }
                  return null;
                },
                bodyColor: Colors.grey[200],
                hintTxt: 'Email',
                icon: Icon(Icons.mail),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                width: size.width,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.indigo,
                    padding: EdgeInsets.all(15),
                  ),
                  onPressed: () => null,
                  child: CustomText(
                    txt: "SUBMET",
                    fSize: 22,
                    txtColor: Colors.white,
                    fWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () => authController.getAuthIndex(0),
                  child: CustomText(
                    txt: "Log in here. ",
                    fSize: 16,
                    txtColor: Colors.indigo,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
