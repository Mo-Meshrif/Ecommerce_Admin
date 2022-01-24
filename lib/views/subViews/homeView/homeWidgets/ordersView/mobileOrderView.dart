import '/widgets/customTitleRow.dart';
import '/core/viewModel/homeViewModel.dart';
import '/core/viewModel/orderViewModel.dart';
import '/model/orderModel.dart';
import '/model/userModel.dart';
import '/views/subViews/homeView/homeWidgets/ordersView/orderDetailsView/orderTrack.dart';
import '/widgets/customText.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MobileOrderView extends StatelessWidget {
  final List<OrderModel> orders;
  MobileOrderView({@required this.orders});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderViewModel>(
      builder: (orderController) => orderController.isMobileTrackOrder.value
          ? Padding(
              padding: const EdgeInsets.all(20),
              child: OrderTrack(),
            )
          : ListView.separated(
              itemCount: orders.length,
              itemBuilder: (context, i) {
                UserModel customer = orderController.authViewModel.users
                    .firstWhere((user) => user.id == orders[i].customerId);
                return Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.black, width: 1.0),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Theme(
                    data:
                        ThemeData().copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      title: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '#',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: orders[i].orderNumber.toString(),
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                      subtitle: CustomText(
                        txt: DateFormat('dd-MM-yyyy hh:mm a').format(
                          orders[i].createdAt.toDate(),
                        ),
                      ),
                      trailing: GestureDetector(
                        onTap: () {
                          orderController.getSelectedOrder(orders[i]);
                          orderController.getMobileViewStatus(true);
                          Get.find<HomeViewModel>().getCurrentItem('order');
                        },
                        child: Icon(
                          Icons.delivery_dining,
                          color: Colors.grey[600],
                        ),
                      ),
                      childrenPadding: EdgeInsets.symmetric(horizontal: 15),
                      children: [
                        Divider(
                          color: Colors.grey,
                          thickness: 0.5,
                        ),
                        SizedBox(height: 10),
                        CustomTitleRow(
                          title: 'Customer',
                          content: CustomText(
                            txt: customer.userName,
                          ),
                        ),
                        CustomTitleRow(
                          title: 'Products',
                          content: Row(
                            children: orders[i].items.map((item) {
                              int index = orders[i].items.indexOf(item);
                              return Row(
                                children: [
                                  CustomText(
                                    txt: item['name'] + '"${item['quantity']}"',
                                  ),
                                  index != orders[i].items.length - 1
                                      ? CustomText(
                                          txt: ',',
                                        )
                                      : Padding(padding: EdgeInsets.zero),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                        CustomTitleRow(
                          title: 'Price',
                          content: CustomText(
                            txt: orders[i].totalPrice,
                          ),
                        ),
                        CustomTitleRow(
                          title: 'Delivery Status',
                          content: CustomText(
                            txt: orders[i].status,
                            txtColor: orders[i].status == 'Pending'
                                ? Colors.red
                                : Colors.green,
                          ),
                        ),
                        SizedBox(height: 10)
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, i) => SizedBox(height: 10),
            ),
    );
  }
}
