import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '/core/viewModel/notificationViewModel.dart';
import '/model/orderModel.dart';
import 'package:get/get.dart';
import 'authViewModel.dart';

class OrderViewModel extends GetxController {
  AuthViewModel authViewModel = Get.find();
  NotificationViewModel _notificationViewModel = Get.find();
  final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('Orders');
  List<String> orderheaders = [
    'Order ID',
    'Customer',
    'Address',
    'Payment',
    'Promo Code',
    'Deilevery Date',
    'Deilevery Pricing',
    'Deilevery Status',
  ];
  List<String> itemheaders = [
    'Items',
    'Size',
    'QTY',
    'Price',
    'Total Price',
  ];
  late OrderModel selectedOrder;

  ValueNotifier isMobileTrackOrder = ValueNotifier(false);
  getMobileViewStatus(bool val) {
    isMobileTrackOrder.value = val;
    update();
  }

  getSelectedOrder(OrderModel order) {
    selectedOrder = order;
    update();
  }

  String getTotalPrice(double price, qty) {
    return (price * qty).toStringAsFixed(2);
  }

  changeOrderStatus(String uid, orderId, status) async {
    selectedOrder.orderTrack = status;
    update();
    await _collectionReference
        .doc(orderId)
        .update({'orderTrack': status}).then((_) {
      int index = selectedOrder.orderTrack!
          .lastIndexWhere((orderTrack) => orderTrack['status']);
      int orderNumber = selectedOrder.orderNumber as int;
      switch (index) {
        case 1:
          _notificationViewModel.sendNotification(
              uid, 'Your order #$orderNumber has been Confirmed !');
          break;
        case 2:
          _notificationViewModel.sendNotification(
              uid, 'Your order #$orderNumber has been Processed !');
          break;
        case 3:
          _notificationViewModel.sendNotification(
              uid, 'Your order #$orderNumber has been Shipped !');
          break;
        case 4:
          _collectionReference
              .doc(orderId)
              .update({'status': 'Completed'}).then((_) =>
                  _notificationViewModel.sendNotification(
                      uid, 'Your order #$orderNumber has been Completed !'));
          break;
        default:
      }
    });
  }

  cancelOrder(String uid, orderId) {
    _collectionReference.doc(orderId).update({'status': 'Cancelled'}).then(
        (_) => _notificationViewModel.sendNotification(
            uid, 'Your order has been canceled !'));
  }
}
