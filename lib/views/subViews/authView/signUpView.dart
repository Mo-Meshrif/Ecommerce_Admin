import '/const.dart';
import '../../../core/viewModel/authViewModel.dart';
import '../../../widgets/customText.dart';
import '../../../widgets/customTextField.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class SignUpView extends StatelessWidget {
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
                txt: "SIGN UP",
                fSize: 22,
                fWeight: FontWeight.bold,
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                onChanged: (val) => authController.userName = val,
                valid: (val) {
                  if (val!.trim().isEmpty) {
                    return 'Enter your username !';
                  }
                  return null;
                },
                bodyColor: Colors.grey[200] as Color,
                hintTxt: 'Username',
                icon: Icon(Icons.person_outline_outlined),
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                onChanged: (val) => authController.email = val,
                valid: (val) {
                  if (val!.trim().isEmpty) {
                    return 'Enter your email !';
                  }
                  if (!val.trim().contains('@')) {
                    return 'Entered email is not valid';
                  }
                  return null;
                },
                bodyColor: Colors.grey[200] as Color,
                hintTxt: 'Email',
                icon: Icon(Icons.mail),
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                onChanged: (val) => authController.password = val,
                valid: (val) {
                  if (val!.isEmpty) {
                    return 'Enter your password !';
                  }
                  if (val.length < 6) {
                    return 'Password must be greater than six';
                  }
                  return null;
                },
                obscure: true,
                bodyColor: Colors.grey[200] as Color,
                hintTxt: 'Password',
                icon: Icon(Icons.lock_open),
              ),
              SizedBox(
                height: 40,
              ),
              authController.loading.value
                  ? CustomText(
                      txt: 'Loading',
                      fSize: 18,
                      txtColor: priColor,
                    )
                  : Container(
                      width: size.width,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: priColor,
                          padding: EdgeInsets.all(15),
                        ),
                        onPressed: () {
                          _key.currentState!.save();
                          if (_key.currentState!.validate()) {
                            authController.signUp();
                          }
                        },
                        child: CustomText(
                          txt: "SIGN UP",
                          fSize: 22,
                          txtColor: swatchColor,
                          fWeight: FontWeight.bold,
                        ),
                      ),
                    ),
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    txt: "Have an account ? ",
                    fSize: 16,
                    txtColor: Colors.grey,
                  ),
                  GestureDetector(
                      onTap: () => authController.getAuthIndex(0),
                      child: CustomText(
                        txt: "Sign in here. ",
                        fSize: 16,
                        txtColor: priColor,
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
