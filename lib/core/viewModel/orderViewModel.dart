import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin/core/viewModel/notificationViewModel.dart';
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
    'Items Summary',
    'Size',
    'QTY',
    'Price',
    'Total Price',
  ];
  OrderModel selectedOrder;

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
      if (selectedOrder.orderTrack.last['status']) {
        _collectionReference.doc(orderId).update({'status': 'Completed'}).then(
            (_) => _notificationViewModel.sendNotification(
                uid, 'Your order has been Completed !'));
      }
    });
  }

  cancelOrder(String uid, orderId) {
    _collectionReference.doc(orderId).update({'status': 'Cancelled'}).then(
        (_) => _notificationViewModel.sendNotification(
            uid, 'Your order has been canceled !'));
  }
}
