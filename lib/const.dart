import 'package:responsive_table/DatatableHeader.dart';
import 'package:flutter/material.dart';

const Color priColor = Colors.indigo;
const Color swatchColor = Colors.white;
const rootRoute = "/";
const categoriesPageDisplayName = "Categories";
const categoriesPageRoute = "/categories";
const messagesPageDisplayName = "Messages";
const messagesPageRoute = "/messages";
const customersPageDisplayName = "Customers";
const customersPageRoute = "/customers";
const shopsPageDisplayName = "Shops";
const shopsPageRoute = "/shops";
const dashboardPageDisplayName = "Dashboard";
const dashboardPageRoute = "/dashboard";
const ordersPageDisplayName = "Orders";
const ordersPageRoute = "/orders";
const productsDisplayName = "Products";
const productsPageRoute = "/products";
List<Map<String, String>> adminItems = [
  {
    'title': categoriesPageDisplayName,
    'icon': 'assets/home/categories.png',
    'route': categoriesPageRoute,
  },
  {
    'title': messagesPageDisplayName,
    'icon': 'assets/home/messages.png',
    'route': messagesPageRoute
  },
  {
    'title': customersPageDisplayName,
    'icon': 'assets/home/customers.png',
    'route': customersPageRoute
  },
  {
    'title': shopsPageDisplayName,
    'icon': 'assets/home/shops.png',
    'route': shopsPageRoute
  },
  {
    'title': 'Logout',
    'icon': 'assets/home/logout.png',
  },
];
List<Map<String, String>> mangerItems = [
  {
    'title': dashboardPageDisplayName,
    'icon': 'assets/home/dashboard.png',
    'route': dashboardPageRoute
  },
  {
    'title': messagesPageDisplayName,
    'icon': 'assets/home/messages.png',
    'route': messagesPageRoute
  },
  {
    'title': ordersPageDisplayName,
    'icon': 'assets/home/orders.png',
    'route': ordersPageRoute
  },
  {
    'title': productsDisplayName,
    'icon': 'assets/home/products.png',
    'route': productsPageRoute
  },
  {
    'title': 'Logout',
    'icon': 'assets/home/logout.png',
  },
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
