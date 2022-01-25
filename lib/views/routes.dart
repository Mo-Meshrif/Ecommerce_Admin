import '/helper/generatePageRoute.dart';
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
      return GeneratePageRoute(settings, AuthView());
    case dashboardPageRoute:
      return GeneratePageRoute(settings, DashboardView());
    case categoriesPageRoute:
      return GeneratePageRoute(settings, CategoriesView());
    case messagesPageRoute:
      return GeneratePageRoute(settings, MessagesView());
    case ordersPageRoute:
      return GeneratePageRoute(settings, OrdersView());
    case productsPageRoute:
      return GeneratePageRoute(settings, ProductsView());
    default:
      return GeneratePageRoute(settings, AuthView());
  }
}
