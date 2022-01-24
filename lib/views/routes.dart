import '/const.dart';
import '/views/mainViews/authView.dart';
import '/views/subViews/homeView/homeWidgets/categoriesView/categoriesView.dart';
import 'subViews/homeView/homeWidgets/dashboardView/dashboardView.dart';
import '/views/subViews/homeView/homeWidgets/messagesView/messagesView.dart';
import '/views/subViews/homeView/homeWidgets/ordersView/ordersView.dart';
import '/views/subViews/homeView/homeWidgets/productsView/productsView.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case rootRoute:
      return _getPageRoute(settings, AuthView());
    case dashboardPageRoute:
      return _getPageRoute(settings, DashboardView());
    case categoriesPageRoute:
      return _getPageRoute(settings, CategoriesView());
    case messagesPageRoute:
      return _getPageRoute(settings, MessagesView());
    case ordersPageRoute:
      return _getPageRoute(settings, OrdersView());
    case productsPageRoute:
      return _getPageRoute(settings, ProductsView());
    default:
      return _getPageRoute(settings, AuthView());
  }
}

_getPageRoute(RouteSettings settings, Widget child) {
  return MaterialPageRoute(
    settings: settings,
    builder: (context) => child,
  );
}
