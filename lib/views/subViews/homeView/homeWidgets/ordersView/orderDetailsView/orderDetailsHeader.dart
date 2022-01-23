import 'package:get/get.dart';
import '/model/orderModel.dart';
import '/widgets/customText.dart';
import 'package:flutter/material.dart';
import '/../../../../const.dart';
import 'orderTrack.dart';
class OrderDetailsHeader extends StatelessWidget {
  final OrderModel order;
  final void Function() sendMessage;
  OrderDetailsHeader({@required this.order, @required this.sendMessage});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Order Number ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: '#' + order.orderNumber.toString(),
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: sendMessage,
              child: Container(
                  margin: EdgeInsets.only(left: 10),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.message,
                        color: swatchColor,
                        size: 12,
                      ),
                      SizedBox(width: 5),
                      CustomText(
                        txt: 'Message Customer',
                        txtColor: swatchColor,
                        fSize: 12,
                      ),
                    ],
                  )),
            ),
          ],
        ),
        GestureDetector(
          onTap: () => Get.dialog(
            AlertDialog(
              insetPadding: EdgeInsets.zero,
              alignment: Alignment.centerRight,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                ),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    txt: 'Track Order',
                  ),
                  IconButton(
                    onPressed: () =>
                        Get.offNamedUntil(ordersPageRoute, (route) => false),
                    icon: Icon(Icons.close),
                  )
                ],
              ),
              content: Container(
                width: 250,
                child: OrderTrack(),
              ),
            ),
            barrierColor: Colors.grey[50],
          ),
          child: CircleAvatar(
            child: Icon(Icons.delivery_dining),
          ),
        )
      ],
    );
  }
}
