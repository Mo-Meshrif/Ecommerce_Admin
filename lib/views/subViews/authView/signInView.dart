import '/const.dart';
import '../../../core/viewModel/authViewModel.dart';
import '../../../widgets/customText.dart';
import '../../../widgets/customTextField.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class SignInView extends StatelessWidget {
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
                txt: "LOG IN",
                fSize: 22,
                fWeight: FontWeight.bold,
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
                  return null;
                },
                obscure: true,
                bodyColor: Colors.grey[200] as Color,
                hintTxt: 'Password',
                icon: Icon(Icons.lock_open),
              ),
              SizedBox(
                height: 5,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () => authController.getAuthIndex(2),
                  child: CustomText(
                    txt: "Forgot password?",
                    fSize: 16,
                    txtColor: Colors.grey,
                  ),
                ),
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
                            authController.signIn();
                          }
                        },
                        child: CustomText(
                          txt: "LOG IN",
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
                    txt: "Do not have an account ? ",
                    fSize: 16,
                    txtColor: Colors.grey,
                  ),
                  GestureDetector(
                    onTap: () => authController.getAuthIndex(1),
                    child: CustomText(
                      txt: "Sign up here. ",
                      fSize: 16,
                      txtColor: priColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
