import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobile, tablet, desktop;
  Responsive({
    @required this.mobile,
    @required this.tablet,
    @required this.desktop,
  });
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 613;
  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 613 &&
      MediaQuery.of(context).size.width < 1024;
  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1024;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) => constraints.maxWidth >= 1024
            ? desktop
            : constraints.maxWidth >= 613
                ? tablet
                : mobile);
  }
}
