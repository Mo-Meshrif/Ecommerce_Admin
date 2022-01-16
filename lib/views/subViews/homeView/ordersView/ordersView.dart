import 'package:cloud_firestore/cloud_firestore.dart';
import '/responsive.dart';
import '/core/viewModel/homeViewModel.dart';
import '/core/viewModel/messageViewModel.dart';
import '/views/subViews/homeView/ordersView/orderDetailsView/orderDetailsBody.dart';
import '/core/viewModel/orderViewModel.dart';
import '/model/orderModel.dart';
import '/model/userModel.dart';
import '/widgets/customText.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'orderDetailsView/orderDetailsHeader.dart';

class OrdersView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('Orders')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        List<DocumentSnapshot> ordersSnap =
            snapshot.hasData ? snapshot.data.docs : [];
        List<OrderModel> orders = ordersSnap.map((element) {
          Map<String, dynamic> data = element.data();
          return OrderModel.fromJson(element.id, data);
        }).toList();
        return snapshot.connectionState == ConnectionState.waiting
            ? Center(child: CircularProgressIndicator())
            : GetBuilder<OrderViewModel>(
                builder: (orderController) => orders.isNotEmpty
                    ? SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          showCheckboxColumn: false,
                          columns: orderController.orderheaders
                              .map((e) => DataColumn(
                                      label: CustomText(
                                    txt: e,
                                  )))
                              .toList(),
                          rows: orders.map((order) {
                            Map<String, dynamic> address = order.shippingAdress;
                            UserModel customer =
                                orderController.authViewModel.users.firstWhere(
                                    (user) => user.id == order.customerId);
                            return DataRow(
                                onSelectChanged: (val) {
                                  orderController.getSelectedOrder(order);
                                  showDialog(
                                    context: context,
                                    barrierColor: Colors.grey[50],
                                    builder: (ctx) => AlertDialog(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 24),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      title: OrderDetailsHeader(
                                        order: order,
                                        sendMessage: () {
                                          Navigator.of(ctx).pop();
                                          MessageViewModel _messageController =
                                              Get.put(MessageViewModel());
                                          _messageController
                                              .isNewMessage.value = true;
                                          _messageController.getOrderNumber(
                                              orderController
                                                  .selectedOrder.orderNumber);
                                          _messageController.toUser =
                                              orderController
                                                  .authViewModel.users
                                                  .firstWhere((user) =>
                                                      user.id ==
                                                      orderController
                                                          .selectedOrder
                                                          .customerId);
                                          Get.find<HomeViewModel>()
                                              .handleClickItem(1);
                                        },
                                      ),
                                      content: Container(
                                        width: Responsive.isDesktop(context)
                                            ? (size.width - 220) * 0.75
                                            : size.width * 0.75,
                                        child: OrderDetailsBody(),
                                      ),
                                    ),
                                  );
                                },
                                cells: [
                                  DataCell(
                                    CustomText(
                                        txt:
                                            '#' + order.orderNumber.toString()),
                                  ),
                                  DataCell(
                                    Row(
                                      children: [
                                        CircleAvatar(
                                            radius: 15,
                                            backgroundImage: customer.pic !=
                                                    null
                                                ? NetworkImage(customer.pic)
                                                : AssetImage(
                                                    'assets/order/person.png')),
                                        SizedBox(width: 5),
                                        CustomText(txt: customer.userName),
                                      ],
                                    ),
                                  ),
                                  DataCell(
                                    CustomText(
                                        txt: address['street'] +
                                            ',' +
                                            address['city'] +
                                            ',' +
                                            address['state']),
                                  ),
                                  DataCell(
                                    CustomText(
                                      txt: order.paymentMehod['paymentMehod'],
                                    ),
                                  ),
                                  DataCell(
                                    CustomText(
                                      txt: order.promoCode != ''
                                          ? order.promoCode
                                          : 'Not defined',
                                    ),
                                  ),
                                  DataCell(
                                    CustomText(
                                      txt: DateFormat('d/M/y').format(
                                        order.createdAt.toDate(),
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    CustomText(
                                      txt: order.totalPrice,
                                    ),
                                  ),
                                  DataCell(
                                    CustomText(
                                      txt: order.status,
                                      txtColor: order.status == 'Pending'
                                          ? Colors.red
                                          : Colors.green,
                                    ),
                                  ),
                                ]);
                          }).toList(),
                        ),
                      )
                    : Center(
                        child: CustomText(txt: 'No Orders !'),
                      ),
              );
      },
    );
  }
}
