import 'views/subViews/homeView/customersView.dart';
import 'views/subViews/homeView/dashboardView.dart';
import 'views/subViews/homeView/messagesView.dart';
import 'views/subViews/homeView/ordersView.dart';
import 'views/subViews/homeView/productsView.dart';
import 'views/subViews/homeView/settingsView.dart';
import 'package:flutter/material.dart';

List<Map<String, String>> homeItems = [
  {
    'title': 'Dashboard',
    'icon': 'assets/home/dashboard.png',
  },
  {
    'title': 'Customers',
    'icon': 'assets/home/customers.png',
  },
  {
    'title': 'Messages',
    'icon': 'assets/home/messages.png',
  },
  {
    'title': 'Orders',
    'icon': 'assets/home/orders.png',
  },
  {
    'title': 'Products',
    'icon': 'assets/home/products.png',
  },
  {
    'title': 'Settings',
    'icon': 'assets/home/settings.png',
  },
  {
    'title': 'Logout',
    'icon': 'assets/home/logout.png',
  },
];
List<Widget> homeViews = [
  DashboardView(),
  CustomersView(),
  MessagesView(),
  OrdersView(),
  ProductsView(),
  SettingsView(),
];
