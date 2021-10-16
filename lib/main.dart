import 'views/controlView.dart';
import 'helper/binds.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Ecommerce Admin',
      initialBinding: Binds(),
      home:ControlView(),
    );
  }
}
