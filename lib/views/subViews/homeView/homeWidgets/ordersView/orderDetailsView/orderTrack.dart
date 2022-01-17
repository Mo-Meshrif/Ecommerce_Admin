import 'package:cloud_firestore/cloud_firestore.dart';
import '/core/viewModel/orderViewModel.dart';
import '/model/orderModel.dart';
import '/widgets/customText.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timelines/timelines.dart';
import '/../../../../const.dart';

class OrdrTrack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderViewModel>(
      builder: (orderController) {
        OrderModel order = orderController.selectedOrder;
        return FixedTimeline.tileBuilder(
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
            connectionDirection: ConnectionDirection.before,
            itemCount: order.orderTrack.length,
            contentsBuilder: (_, index) {
              int x = order.orderTrack
                  .indexWhere((element) => element['status'] == false);
              return Padding(
                padding: EdgeInsets.only(
                    left: 8.0, bottom: index == x ? 20 : 50),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CustomText(
                          txt: order.orderTrack[index]['title'],
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
                            padding: const EdgeInsets.only(top: 10),
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                              children: [
                                TextButton(
                                    onPressed: () {
                                      if (x == 1) {
                                        order.orderTrack[1]['createdAt'] =
                                            Timestamp.now();
                                      }
                                      order.orderTrack[x]['status'] =
                                          true;
                                      orderController.changeOrderStatus(
                                        order.customerId,
                                        order.orderId,
                                        order.orderTrack,
                                      );
                                    },
                                    child: CustomText(
                                      txt: 'Yes',
                                      txtColor: Colors.green,
                                    )),
                                TextButton(
                                    onPressed: () =>
                                        orderController.cancelOrder(
                                            order.customerId,
                                            order.orderId),
                                    child: CustomText(
                                      txt: 'No',
                                      txtColor: Colors.red,
                                    ))
                              ],
                            ),
                          )
                        : Padding(padding: EdgeInsets.zero),
                  ],
                ),
              );
            },
            indicatorBuilder: (_, index) {
              if (order.orderTrack[index]['status'] == true) {
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
            connectorBuilder: (_, index, ___) => SolidLineConnector(
              color: order.orderTrack[index]['status'] == true
                  ? priColor
                  : null,
            ),
          ),
        );
      },
    );
  }
}
