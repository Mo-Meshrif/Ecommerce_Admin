import '../../../../core/viewModel/homeViewModel.dart';
import '../../../../const.dart';
import 'package:responsive_table/ResponsiveDatatable.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ShopsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Users')
            .where('role', isEqualTo: 'Manger')
            .snapshots(),
        builder: (context, snapshot) {
          List<DocumentSnapshot> docs =
              snapshot.hasData ? snapshot.data.docs : [];
          List<Map<String, dynamic>> shopsList = docs
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
                    child: ResponsiveDatatable(
                      headers: headers,
                      source: shopsList,
                      autoHeight: false,
                      onSort: (val) =>
                          homeController.onSortShops(shopsList, val),
                      sortAscending: homeController.sortShopsAscending.value,
                      sortColumn: homeController.sortShopsColumn,
                      isLoading: shopsList.isEmpty ? true : false,
                     
                      footers: [],
                    ),
                  )));
        });
  }
}
