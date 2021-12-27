import 'views/subViews/homeView/categoriesView/categoriesView.dart';
import 'views/subViews/homeView/shopsView.dart';
import 'views/subViews/homeView/customersView.dart';
import 'views/subViews/homeView/dashboardView.dart';
import 'views/subViews/homeView/messagesView/messagesView.dart';
import 'views/subViews/homeView/ordersView/ordersView.dart';
import 'views/subViews/homeView/productsView/productsView.dart';
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
    'title': 'Messages',
    'icon': 'assets/home/messages.png',
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
    'title': 'Logout',
    'icon': 'assets/home/logout.png',
  },
];
List<Widget> adminViews = [
  CategoriesView(),
  MessagesView(),
  CustomersView(),
  ShopsView(),
];
List<Widget> mangerViews = [
  DashboardView(),
  MessagesView(),
  OrdersView(),
  ProductsView(),
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
String serverToken =
    'AAAAOtJSvxg:APA91bFGC9EUaMW6eilnS3OM0qu3bvWswykHs1BbNh6uZISX6kqr77D8-cnF8jkGdt9HKEQ8N8VsTCy76cBY3p5D5UERU4C-1XqI1LoavWyVWxCVPe-XV0XE1cQJvZ0NuuBlzEZ9it95';
String vapidKey =
    'BLmKD0J1hMxp3bCZORqQpj53Q5F6YtUN9ZdrfbmokNRugj-ePwrSnH2WZ5mHmPnD95IYKZi3Ohvd_9XhWjVg2gc';
