import 'views/subViews/homeView/categoriesView/categoriesView.dart';
import 'views/subViews/homeView/shopsView.dart';
import 'views/subViews/homeView/customersView.dart';
import 'views/subViews/homeView/dashboardView.dart';
import 'views/subViews/homeView/messagesView/messagesView.dart';
import 'views/subViews/homeView/ordersView.dart';
import 'views/subViews/homeView/productsView.dart';
import 'views/subViews/homeView/settingsView.dart';
import 'package:responsive_table/DatatableHeader.dart';
import 'package:flutter/material.dart';

const Color priColor = Colors.indigo;
const Color swatchColor = Colors.white;
List<Map<String, String>> adminItems = [
  {
    'title': 'Categories',
    'icon': 'assets/home/categories.png',
  },
  {
    'title': 'Customers',
    'icon': 'assets/home/customers.png',
  },
  {
    'title': 'Shops',
    'icon': 'assets/home/shops.png',
  },
  {
    'title': 'Messages',
    'icon': 'assets/home/messages.png',
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
List<Map<String, String>> mangerItems = [
  {
    'title': 'Dashboard',
    'icon': 'assets/home/dashboard.png',
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
List<Widget> adminViews = [
  CategoriesView(),
  CustomersView(),
  ShopsView(),
  MessagesView(),
  SettingsView(),
];
List<Widget> mangerViews = [
  DashboardView(),
  OrdersView(),
  ProductsView(),
  MessagesView(),
  SettingsView(),
];
List<DatatableHeader> headers = [
  DatatableHeader(
      text: "ID",
      value: "id",
      show: true,
      sortable: true,
      textAlign: TextAlign.left),
  DatatableHeader(
      text: "Name",
      value: "name",
      show: true,
      flex: 2,
      sortable: true,
      textAlign: TextAlign.left),
  DatatableHeader(
      text: "Email",
      value: "email",
      show: true,
      sortable: true,
      textAlign: TextAlign.left),
];
