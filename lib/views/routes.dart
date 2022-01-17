import '/const.dart';
import '/views/mainViews/authView.dart';
import '/views/subViews/homeView/homeWidgets/categoriesView/categoriesView.dart';
import 'subViews/homeView/homeWidgets/customersView.dart';
import 'subViews/homeView/homeWidgets/dashboardView/dashboardView.dart';
import '/views/subViews/homeView/homeWidgets/messagesView/messagesView.dart';
import '/views/subViews/homeView/homeWidgets/ordersView/ordersView.dart';
import '/views/subViews/homeView/homeWidgets/productsView/productsView.dart';
import 'subViews/homeView/homeWidgets/shopsView.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case rootRoute:
      return _getPageRoute(settings, AuthView());
    case categoriesPageRoute:
      return _getPageRoute(settings, CategoriesView());
    case messagesPageRoute:
      return _getPageRoute(settings, MessagesView());
    case customersPageRoute:
      return _getPageRoute(settings, CustomersView());
    case shopsPageRoute:
      return _getPageRoute(settings, ShopsView());
    case dashboardPageRoute:
      return _getPageRoute(settings, DashboardView());
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
