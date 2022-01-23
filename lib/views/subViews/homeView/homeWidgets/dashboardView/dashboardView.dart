import 'package:cloud_firestore/cloud_firestore.dart';
import '/responsive.dart';
import '/model/topCustomerModel.dart';
import '/core/viewModel/dashboardViewModel.dart';
import '/model/orderModel.dart';
import '/model/salesModel.dart';
import 'widgets/cardItem.dart';
import '/widgets/customText.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashboardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<DashboardViewModel>(
      init: DashboardViewModel(),
      builder: (dashBoardController) => StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Orders')
            .orderBy('createdAt')
            .snapshots(),
        builder: (context, snapshot) {
          List<DocumentSnapshot> ordersSnap =
              snapshot.hasData ? snapshot.data.docs : [];
          List<OrderModel> orders = ordersSnap.isEmpty
              ? []
              : ordersSnap.map((element) => OrderModel.fromJson(element.id, element.data())).toList();
          List<TopCustomerModel> topCustomers =
              dashBoardController.getTopCustomers(orders);
          return snapshot.connectionState == ConnectionState.waiting &&
                  dashBoardController.isLoading.value
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      LimitedBox(
                        maxHeight: Responsive.isMobile(context) ? 300 : 100,
                        child: GridView(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount:
                                Responsive.isMobile(context) ? 1 : 3,
                            mainAxisExtent: 100,
                          ),
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
                      Container(
                        height: Responsive.isMobile(context)
                            ? size.height - 380
                            : size.height - 180,
                        margin: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: RotatedBox(
                                quarterTurns:
                                    Responsive.isMobile(context) ? 45 : 0,
                                child: Card(
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(color: Colors.black, width: 2.0),
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
                              ),
                            ),
                            SizedBox(width: 5),
                            Container(
                              width: 220,
                              child: Card(
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                   side: BorderSide(color: Colors.black, width: 2.0),
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
                                                    backgroundImage: topCustomers[
                                                                    i]
                                                                .pic ==
                                                            null
                                                        ? AssetImage(
                                                            'assets/order/person.png')
                                                        : NetworkImage(
                                                            topCustomers[i]
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
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 10)
                    ],
                  ),
                );
        },
      ),
    );
  }
}
