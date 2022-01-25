import 'package:flutter/material.dart';

class GeneratePageRoute extends PageRouteBuilder {
  final Widget widget;
  final RouteSettings route;
  GeneratePageRoute(this.route, this.widget)
      : super(
            settings: route,
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return widget;
            },
            transitionDuration: Duration(milliseconds: 50),
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            });
}
