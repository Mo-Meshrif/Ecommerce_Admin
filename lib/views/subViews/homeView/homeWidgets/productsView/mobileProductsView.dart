import 'package:cloud_firestore/cloud_firestore.dart';
import '/core/viewModel/homeViewModel.dart';
import '/views/subViews/homeView/homeWidgets/productsView/widgets/productsHeader.dart';
import '/core/viewModel/productViewModel.dart';
import 'package:get/get.dart';
import '/model/productModel.dart';
import '/widgets/customText.dart';
import '/widgets/customTitleRow.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class MobileProductsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductViewModel>(
      builder: (productsController) => productsController
              .isMobileAddProduct.value
          ? ProductsHeader()
          : Column(
              children: [
                GestureDetector(
                  onTap: () {
                    productsController.getMobileViewStatus(true);
                    Get.find<HomeViewModel>().getCurrentIndex(3);
                  },
                  child: Container(
                    height: 100,
                    child: Card(
                      color: Colors.grey[200],
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.black, width: 1.0),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.add,
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Expanded(
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('Products')
                            .snapshots(),
                        builder: (context, snapshot) {
                          List<DocumentSnapshot> productsSnap =
                              snapshot.hasData ? snapshot.data.docs : [];
                          List<ProductModel> prods = productsSnap
                              .map((element) => ProductModel.fromJson(
                                  element.id, element.data()))
                              .toList();
                          return ListView.separated(
                            itemCount: prods.length,
                            itemBuilder: (context, i) {
                              Map<String, dynamic> classification =
                                  prods[i].classification;
                              return Card(
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: Colors.black,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Theme(
                                  data: ThemeData().copyWith(
                                      dividerColor: Colors.transparent),
                                  child: ExpansionTile(
                                    leading: Image.network(
                                      prods[i].imgUrl,
                                      width: 40,
                                      height: 40,
                                    ),
                                    title: CustomText(
                                      txt: prods[i].prodName,
                                      txtColor: Colors.red,
                                    ),
                                    subtitle: CustomText(
                                      txt: prods[i].price,
                                    ),
                                    trailing: GestureDetector(
                                      onTap: () {
                                        productsController
                                            .getMobileProdData(prods[i]);
                                        productsController
                                            .getMobileViewStatus(true);
                                        Get.find<HomeViewModel>()
                                            .getCurrentIndex(3);
                                      },
                                      child: Icon(
                                        Icons.edit,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    childrenPadding:
                                        EdgeInsets.symmetric(horizontal: 15),
                                    children: [
                                      Divider(
                                        color: Colors.grey,
                                        thickness: 0.5,
                                      ),
                                      SizedBox(height: 10),
                                      CustomTitleRow(
                                        title: 'Classification',
                                        content: RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: classification['sub-cat'],
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              TextSpan(
                                                text:
                                                    ' "${classification['category']}"',
                                                style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      CustomTitleRow(
                                        title: 'Season',
                                        content:
                                            CustomText(txt: prods[i].season),
                                      ),
                                      CustomTitleRow(
                                        title: 'Brand',
                                        content:
                                            CustomText(txt: prods[i].brand),
                                      ),
                                      CustomTitleRow(
                                        title: 'Material',
                                        content:
                                            CustomText(txt: prods[i].material),
                                      ),
                                      CustomTitleRow(
                                        title: 'Sku',
                                        content: CustomText(txt: prods[i].sku),
                                      ),
                                      CustomTitleRow(
                                        title: 'Color(s)',
                                        content: Row(
                                          children: prods[i]
                                              .color
                                              .map((color) => Container(
                                                    height: 20,
                                                    width: 20,
                                                    margin: EdgeInsets.only(
                                                        right: 2),
                                                    decoration: BoxDecoration(
                                                      color: HexColor(color),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                  ))
                                              .toList(),
                                        ),
                                      ),
                                      CustomTitleRow(
                                        title: 'Size(s)',
                                        content: prods[i].size.isNotEmpty
                                            ? Row(
                                                children: prods[i]
                                                    .size
                                                    .map((size) => CustomText(
                                                        txt: size + ','))
                                                    .toList(),
                                              )
                                            : CustomText(txt: 'Not defined'),
                                      ),
                                      SizedBox(height: 10)
                                    ],
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, i) => SizedBox(
                              height: 10,
                            ),
                          );
                        }))
              ],
            ),
    );
  }
}
