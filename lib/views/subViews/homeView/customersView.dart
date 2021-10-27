import '../../../const.dart';
import '../../../core/viewModel/homeViewModel.dart';
import 'package:responsive_table/ResponsiveDatatable.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CustomersView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Users')
            .where('role', isEqualTo: 'Customer')
            .snapshots(),
        builder: (context, snapshot) {
          List<DocumentSnapshot> docs =
              snapshot.hasData ? snapshot.data.docs : [];
          List<Map<String, dynamic>> customersList = docs
              .map((e) => {
                    'id': e['id'],
                    'name': e['userName'],
                    'email': e['email'],
                  })
              .toList();
          return GetBuilder<HomeViewModel>(
              builder: (homeController) => SingleChildScrollView(
                      child: Container(
                    constraints: BoxConstraints(
                      maxHeight: 700,
                    ),
                    child: Card(
                      elevation: 1,
                      shadowColor: Colors.black,
                      clipBehavior: Clip.none,
                      child: ResponsiveDatatable(
                        headers: headers,
                        source: customersList,
                        autoHeight: false,
                        onSort: (val) =>
                            homeController.onSortCustomer(customersList, val),
                        sortAscending:
                            homeController.sortCustomersAscending.value,
                        sortColumn: homeController.sortCustomersColumn,
                        isLoading: customersList.isEmpty ? true : false,
                        footers: [],
                      ),
                    ),
                  )));
        });
  }
}
