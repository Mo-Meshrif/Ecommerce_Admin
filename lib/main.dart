import '/views/controlView.dart';
import 'package:url_strategy/url_strategy.dart';
import 'helper/binds.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'helper/navigation_service.dart';
import 'locator.dart';
import 'views/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocator();
  setPathUrlStrategy();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Mega Store',
      initialBinding: Binds(),
      debugShowCheckedModeBanner: false,
      navigatorKey: locator<NavigationService>().navigatorKey,
      onGenerateRoute: generateRoute,
      builder: (_, child) =>ControlView(child: child),
    );
  }
}
