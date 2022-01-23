import '/core/viewModel/authViewModel.dart';
import '/model/topCustomerModel.dart';
import '/model/userModel.dart';
import '/core/service/fireStore_product.dart';
import '/model/orderModel.dart';
import '/model/salesModel.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DashboardViewModel extends GetxController {
  ValueNotifier isLoading = ValueNotifier(false);
  AuthViewModel _authViewModel = Get.find();
  DateTime _dateTime = DateTime.now();
  int totalProducts=0;

  onInit() {
    getTotalProductsOnStore();
    super.onInit();
  }

  double getTotalRevenuePerThisMonth(List<OrderModel> orders) {
    double totalRevenue = 0;
    orders.forEach((order) {
      if (order.createdAt.toDate().month == _dateTime.month) {
        totalRevenue += double.parse(order.totalPrice);
      }
    });
    return totalRevenue;
  }

  getTotalProductsOnStore() {
    isLoading.value = true;
    update();
    FireStoreProduct().getProductsfromFireStore().then((prods) {
      totalProducts = prods.length;
      isLoading.value = false;
      update();
    });
  }

  int getTotalOrdersPerThisMonth(List<OrderModel> orders) {
    List<OrderModel> tempList = [];
    orders.forEach((order) {
      if (order.createdAt.toDate().month == _dateTime.month) {
        tempList.add(order);
      }
    });
    return tempList.length;
  }

  List<SalesModel> getTotalRevenuePerMonths(List<OrderModel> orders) {
    List<SalesModel> tempList = [];
    orders.forEach((order) {
      if (order.createdAt.toDate().month <= _dateTime.month) {
        String month = DateFormat("MMMM").format(order.createdAt.toDate());
        double revenue = double.parse(order.totalPrice);
        int index = tempList.indexWhere((element) => element.month == month);
        if (index < 0) {
          tempList.add(SalesModel(month: month, revenue: revenue));
        } else {
          tempList[index].revenue += revenue;
        }
      }
    });
    return tempList;
  }

  List<TopCustomerModel> getTopCustomers(List<OrderModel> orders) {
    List<TopCustomerModel> tempList = [];
    orders.forEach((order) {
      UserModel user = _authViewModel.users
          .firstWhere((user) => user.id == order.customerId);
      int index =
          tempList.indexWhere((element) => element.id == order.customerId);
      double totalPrice = double.parse(order.totalPrice);
      if (index < 0) {
        tempList.add(TopCustomerModel(
          id: user.id,
          name: user.userName,
          pic: user.pic,
          ordersNum: 1,
          totalPrice: totalPrice,
        ));
      } else {
        tempList[index].ordersNum += 1;
        tempList[index].totalPrice += totalPrice;
      }
    });
    tempList.sort((a,b)=>a.ordersNum.compareTo(b.ordersNum));
    return tempList;
  }
}
