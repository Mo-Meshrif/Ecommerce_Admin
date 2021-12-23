import 'package:cloud_firestore/cloud_firestore.dart';
import '/model/topCustomerModel.dart';
import '/core/viewModel/dashboardViewModel.dart';
import '/model/orderModel.dart';
import '/model/salesModel.dart';
import '/widgets/cardItem.dart';
import '/widgets/customText.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashboardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Orders')
            .orderBy('createdAt')
            .snapshots(),
        builder: (context, snapshot) {
          List<DocumentSnapshot> ordersSnap =
              snapshot.hasData ? snapshot.data.docs : [];
          List<OrderModel> orders = ordersSnap.map((element) {
            Map<String, dynamic> data = element.data();
            return OrderModel.fromJson(element.id, data);
          }).toList();
          return GetBuilder<DashboardViewModel>(
            init: DashboardViewModel(),
            builder: (dashBoardController) {
              List<TopCustomerModel> topCustomers =
                  dashBoardController.getTopCustomers(orders);
              return snapshot.connectionState == ConnectionState.waiting &&
                      dashBoardController.isLoading.value
                  ? Center(child: CircularProgressIndicator())
                  : ListView(
                      children: [
                        Container(
                          height: 120,
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CardItem(
                                  title: "Revenue",
                                  subtitle: "Revenue this month",
                                  value:
                                      "\$ ${dashBoardController.getTotalRevenuePerThisMonth(orders)}",
                                  color1: Colors.green.shade700,
                                  color2: Colors.green,
                                ),
                                CardItem(
                                  title: "Products",
                                  subtitle: "Total products on store",
                                  value: "${dashBoardController.totalProducts}",
                                  color1: Colors.lightBlueAccent,
                                  color2: Colors.blue,
                                ),
                                CardItem(
                                  title: "Orders",
                                  subtitle: "Total orders for this month",
                                  value:
                                      "${dashBoardController.getTotalOrdersPerThisMonth(orders)}",
                                  color1: Colors.redAccent,
                                  color2: Colors.red,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          child: Container(
                            height: size.height - 210,
                            child: Row(
                              children: [
                                Card(
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: SfCartesianChart(
                                        primaryXAxis: CategoryAxis(),
                                        legend: Legend(isVisible: true),
                                        series: <
                                            ChartSeries<SalesModel, String>>[
                                          ColumnSeries<SalesModel, String>(
                                              dataSource: dashBoardController
                                                  .getTotalRevenuePerMonths(
                                                      orders),
                                              xValueMapper:
                                                  (SalesModel sales, _) =>
                                                      sales.month,
                                              yValueMapper:
                                                  (SalesModel sales, _) =>
                                                      sales.revenue,
                                              name: 'Revenues',
                                              dataLabelSettings:
                                                  DataLabelSettings(
                                                      isVisible: true)),
                                        ]),
                                  ),
                                ),
                                SizedBox(width: 5),
                                Expanded(
                                    child: Card(
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Column(
                                      children: [
                                        CustomText(
                                          txt: 'Top Customers',
                                          fSize: 20,
                                        ),
                                        Expanded(
                                          child: ListView.builder(
                                              itemCount: topCustomers.length,
                                              itemBuilder: (context, i) =>
                                                  ListTile(
                                                    leading: CircleAvatar(
                                                      backgroundImage:
                                                          topCustomers[i].pic ==
                                                                  null
                                                              ? AssetImage(
                                                                  'assets/order/person.png')
                                                              : NetworkImage(
                                                                  topCustomers[
                                                                          i]
                                                                      .pic),
                                                    ),
                                                    title: CustomText(
                                                      txt: topCustomers[i].name,
                                                    ),
                                                    subtitle: CustomText(
                                                      txt:
                                                          '${topCustomers[i].ordersNum} orders',
                                                      txtColor: Colors.grey,
                                                    ),
                                                    trailing: CustomText(
                                                      txt:
                                                          '\$ ${topCustomers[i].totalPrice}',
                                                      txtColor:
                                                          Colors.green.shade800,
                                                      fWeight: FontWeight.bold,
                                                    ),
                                                  )),
                                        ),
                                      ],
                                    ),
                                  ),
                                ))
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
            },
          );
        });
  }
}
