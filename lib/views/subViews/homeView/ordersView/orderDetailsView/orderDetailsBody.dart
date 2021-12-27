import 'package:timelines/timelines.dart';
import '/core/viewModel/orderViewModel.dart';
import '/model/orderModel.dart';
import '/widgets/customText.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../const.dart';

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
            child: Row(
              crossAxisAlignment: hasPaymentCard
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: DataTable(
                            columns: orderController.itemheaders
                                .map((e) =>
                                    DataColumn(label: CustomText(txt: e)))
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
                                      subTitle:
                                          paymentDetails['cardHolderName'],
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
                ),
                Expanded(
                    flex: 1,
                    child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(17),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                txt: 'Order Summary',
                                fSize: 20,
                              ),
                              Divider(),
                              CustomText(
                                txt: 'Order Created : ' +
                                    DateFormat('d/M/y').format(
                                      order.createdAt.toDate(),
                                    ),
                              ),
                              CustomText(
                                txt: 'Order Time : ' +
                                    DateFormat('hh:mm a').format(
                                      order.createdAt.toDate(),
                                    ),
                              ),
                              CustomText(
                                txt: 'Total : ' + order.totalPrice,
                              ),
                              SizedBox(height: 30),
                              CustomText(
                                txt: 'Order Track',
                                fSize: 20,
                              ),
                              Divider(),
                              SizedBox(height: 10),
                              FixedTimeline.tileBuilder(
                                mainAxisSize: MainAxisSize.min,
                                theme: TimelineThemeData(
                                  nodePosition: 0,
                                  color: Color(0xff989898),
                                  indicatorTheme: IndicatorThemeData(
                                    position: 0,
                                    size: 20.0,
                                  ),
                                  connectorTheme: ConnectorThemeData(
                                    thickness: 2.5,
                                  ),
                                ),
                                builder: TimelineTileBuilder.connected(
                                  connectionDirection:
                                      ConnectionDirection.before,
                                  itemCount: order.orderTrack.length,
                                  contentsBuilder: (_, index) {
                                    int x = order.orderTrack.indexWhere(
                                        (element) =>
                                            element['status'] == false);
                                    return Padding(
                                      padding: EdgeInsets.only(
                                          left: 8.0,
                                          bottom: index == x ? 20 : 50),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              CustomText(
                                                txt: order.orderTrack[index]
                                                    ['title'],
                                              ),
                                              index == x
                                                  ? CustomText(txt: ' ?')
                                                  : Padding(
                                                      padding: EdgeInsets.zero,
                                                    ),
                                            ],
                                          ),
                                          index == x
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      TextButton(
                                                          onPressed: () {
                                                            order.orderTrack[x]
                                                                    ['status'] =
                                                                true;
                                                            orderController
                                                                .changeOrderStatus(
                                                              order.customerId,
                                                              order.orderId,
                                                              order.orderTrack,
                                                            );
                                                          },
                                                          child: CustomText(
                                                            txt: 'Yes',
                                                            txtColor:
                                                                Colors.green,
                                                          )),
                                                      TextButton(
                                                          onPressed: () =>
                                                              orderController
                                                                  .cancelOrder(
                                                                      order
                                                                          .customerId,
                                                                      order
                                                                          .orderId),
                                                          child: CustomText(
                                                            txt: 'No',
                                                            txtColor:
                                                                Colors.red,
                                                          ))
                                                    ],
                                                  ),
                                                )
                                              : Padding(
                                                  padding: EdgeInsets.zero),
                                        ],
                                      ),
                                    );
                                  },
                                  indicatorBuilder: (_, index) {
                                    if (order.orderTrack[index]['status'] ==
                                        true) {
                                      return DotIndicator(
                                        size: 30,
                                        color: priColor,
                                        child: Icon(
                                          Icons.check,
                                          color: Colors.white,
                                          size: 20.0,
                                        ),
                                      );
                                    } else {
                                      return OutlinedDotIndicator(
                                        size: 30,
                                        borderWidth: 2.5,
                                      );
                                    }
                                  },
                                  connectorBuilder: (_, index, ___) =>
                                      SolidLineConnector(
                                    color: order.orderTrack[index]['status'] ==
                                            true
                                        ? priColor
                                        : null,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )))
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
