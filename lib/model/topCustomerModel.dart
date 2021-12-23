import 'package:flutter/cupertino.dart';

class TopCustomerModel {
  String id, name, pic;
  int ordersNum;
  double totalPrice;
  TopCustomerModel({
    @required this.id,
    @required this.name,
    @required this.pic,
    @required this.ordersNum,
    @required this.totalPrice,
  });
}
