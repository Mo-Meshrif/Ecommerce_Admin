import '/responsive.dart';
import '/core/viewModel/orderViewModel.dart';
import '/model/orderModel.dart';
import '/widgets/customText.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderDetailsBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) => GetBuilder<OrderViewModel>(
        builder: (orderController) {
          OrderModel order = orderController.selectedOrder;
          Map<String, dynamic> address = order.shippingAdress;
          bool hasPaymentCard =
              order.paymentMehod.containsKey('delails') ? true : false;
          Map<String, dynamic> paymentDetails =
              hasPaymentCard ? order.paymentMehod['delails'] : {};
          return SingleChildScrollView(
            controller: ScrollController(),
            child: Column(
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: DataTable(
                      columnSpacing: Responsive.isTablet(context) ? 20 : 50,
                      columns: orderController.itemheaders
                          .map((e) => DataColumn(label: CustomText(txt: e)))
                          .toList(),
                      rows: order.items.map((item) {
                        String quantity = item['quantity'].toString();
                        return DataRow(cells: [
                          DataCell(Row(
                            children: [
                              Image.network(
                                item['imgUrl'],
                                height: 30,
                                width: 30,
                              ),
                              SizedBox(width: 10),
                              CustomText(txt: item['name'])
                            ],
                          )),
                          DataCell(
                            CustomText(txt: item['size']),
                          ),
                          DataCell(
                            CustomText(txt: quantity),
                          ),
                          DataCell(
                            CustomText(txt: item['price']),
                          ),
                          DataCell(
                            CustomText(
                              txt: orderController.getTotalPrice(
                                double.parse(item['price']),
                                double.parse(quantity),
                              ),
                            ),
                          ),
                        ]);
                      }).toList()),
                ),
                Card(
                  margin: EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          txt: 'Customer Details',
                          fSize: 20,
                        ),
                        Divider(
                          height: 25,
                        ),
                        RowText(
                          title: 'Customer Name',
                          subTitle: address['fullName'],
                        ),
                        Divider(
                          height: 25,
                        ),
                        RowText(
                          title: 'Phone Number',
                          subTitle: address['mobileNumber'],
                        ),
                        Divider(
                          height: 25,
                        ),
                        RowText(
                            title: 'Delivery Address',
                            subTitle: address['street'] +
                                ',' +
                                address['city'] +
                                ',' +
                                address['state']),
                        !hasPaymentCard
                            ? Column(
                                children: [
                                  Divider(
                                    height: 25,
                                  ),
                                  RowText(
                                      title: 'Payment',
                                      subTitle: 'Cash on Delivery'),
                                ],
                              )
                            : Padding(padding: EdgeInsets.zero)
                      ],
                    ),
                  ),
                ),
                hasPaymentCard
                    ? Card(
                        margin: EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                txt: 'Payment Details',
                                fSize: 20,
                              ),
                              Divider(
                                height: 25,
                              ),
                              RowText(
                                title: 'Card Holder Name',
                                subTitle: paymentDetails['cardHolderName'],
                              ),
                              Divider(
                                height: 25,
                              ),
                              RowText(
                                title: 'Card Number',
                                subTitle: paymentDetails['cardNumber'],
                              ),
                              Divider(
                                height: 25,
                              ),
                              RowText(
                                title: 'Cvv',
                                subTitle: paymentDetails['cvv'],
                              ),
                              Divider(
                                height: 25,
                              ),
                              RowText(
                                title: 'ExpireDate',
                                subTitle: paymentDetails['expireDate'],
                              ),
                            ],
                          ),
                        ),
                      )
                    : Padding(padding: EdgeInsets.zero)
              ],
            ),
          );
        },
      );
}

class RowText extends StatelessWidget {
  final String title, subTitle;

  RowText({@required this.title, @required this.subTitle});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          txt: title,
        ),
        CustomText(
          txt: subTitle,
        )
      ],
    );
  }
}
