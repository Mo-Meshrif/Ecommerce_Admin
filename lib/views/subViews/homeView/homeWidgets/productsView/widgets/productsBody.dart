import '/../../../responsive.dart';
import '/core/viewModel/productViewModel.dart';
import '/model/productModel.dart';
import 'editProductView.dart';
import '/widgets/customText.dart';
import '/widgets/deleteAlert.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class ProductBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ScrollController scollBarController = ScrollController();
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Products').snapshots(),
        builder: (context, snapshot) {
          List<DocumentSnapshot> productsSnap =
              snapshot.hasData ? (snapshot.data as QuerySnapshot).docs : [];
          List<ProductModel> prods = productsSnap.map((element) {
            Map<String, dynamic> data = element.data() as Map<String, dynamic>;
            return ProductModel.fromJson(element.id, data);
          }).toList();
          return GetBuilder<ProductViewModel>(
            builder: (productController) => Scrollbar(
              isAlwaysShown: true,
              scrollbarOrientation: ScrollbarOrientation.top,
              controller: scollBarController,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                controller: scollBarController,
                child: DataTable(
                  showCheckboxColumn: false,
                  columns: productController.headers
                      .map((e) => DataColumn(
                              label: CustomText(
                            txt: e,
                          )))
                      .toList(),
                  rows: prods
                      .map((prod) => DataRow(
                              onSelectChanged: (val) {
                                productController.getReParameters(prod);
                                showDialog(
                                    context: context,
                                    barrierColor: Colors.grey[50],
                                    builder: (ctx) => AlertDialog(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 10, horizontal: 24),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          title: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Edit Product"),
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 5),
                                                    child: GestureDetector(
                                                        onTap: () => showDialog(
                                                              context: context,
                                                              builder: (ctx) =>
                                                                  DeleteAlert(
                                                                title:
                                                                    'Delete Product',
                                                                messageContent:
                                                                    'Are you sure to delete this Product',
                                                                agree: () =>
                                                                    productController
                                                                        .deleteProd(
                                                                            prod,
                                                                            ctx),
                                                                notAgree: () =>
                                                                    Navigator.of(
                                                                            ctx)
                                                                        .pop(),
                                                                isLoading:
                                                                    false,
                                                              ),
                                                            ),
                                                        child: CircleAvatar(
                                                            child: Icon(
                                                                Icons.delete))),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () => productController
                                                        .editProd(
                                                            prod.id as String,
                                                            productController
                                                                .rePickedImage,
                                                            ProductModel(
                                                              prodName:
                                                                  productController
                                                                      .reProdName,
                                                              imgUrl:
                                                                  prod.imgUrl,
                                                              season:
                                                                  productController
                                                                      .season,
                                                              color: productController
                                                                  .reSelectedColors,
                                                              size: productController
                                                                  .reSelectedSizes,
                                                              price: productController
                                                                  .reProdPrice,
                                                              createdAt:
                                                                  Timestamp
                                                                      .now(),
                                                              brand: productController
                                                                  .reBrandName,
                                                              condition:
                                                                  productController
                                                                      .reProdCondition,
                                                              sku: productController
                                                                  .reProdSku,
                                                              material:
                                                                  productController
                                                                      .reMaterialType,
                                                              trending:
                                                                  productController
                                                                      .reTrend,
                                                              classification: {
                                                                'cat-id':
                                                                    productController
                                                                        .currentCato!
                                                                        .id,
                                                                'category':
                                                                    productController
                                                                        .reMainSubCat,
                                                                'sub-cat':
                                                                    productController
                                                                        .reSubCat
                                                              },
                                                            ),
                                                            ctx),
                                                    child: CircleAvatar(
                                                      child: Icon(Icons.check),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                          content: Container(
                                            width: Responsive.isDesktop(context)
                                                ? (size.width - 220) * 0.75
                                                : size.width * 0.75,
                                            child: EditProductView(prod: prod),
                                          ),
                                        ));
                              },
                              cells: [
                                DataCell(
                                  Image.network(
                                    prod.imgUrl as String,
                                    height: 50,
                                    width: 50,
                                  ),
                                ),
                                DataCell(
                                  CustomText(txt: prod.prodName as String),
                                ),
                                DataCell(
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                            text: prod
                                                .classification!['category'],
                                            style:
                                                TextStyle(color: Colors.black)),
                                        TextSpan(
                                            text:
                                                ' "${prod.classification!['sub-cat']}"',
                                            style: TextStyle(color: Colors.red))
                                      ],
                                    ),
                                  ),
                                ),
                                DataCell(
                                  CustomText(txt: prod.season as String),
                                ),
                                DataCell(
                                  CustomText(txt: prod.brand as String),
                                ),
                                DataCell(
                                  CustomText(txt: prod.material as String),
                                ),
                                DataCell(
                                  CustomText(txt: prod.sku as String),
                                ),
                                DataCell(
                                  Row(
                                    children: prod.color!
                                        .map((color) => Container(
                                              height: 20,
                                              width: 20,
                                              margin: EdgeInsets.only(right: 2),
                                              decoration: BoxDecoration(
                                                color: HexColor(color),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                            ))
                                        .toList(),
                                  ),
                                ),
                                DataCell(
                                  prod.size!.isNotEmpty
                                      ? Row(
                                          children: prod.size!
                                              .map((size) =>
                                                  CustomText(txt: size + ','))
                                              .toList(),
                                        )
                                      : CustomText(txt: 'Not defined'),
                                ),
                                DataCell(
                                  CustomText(txt: prod.trending.toString()),
                                ),
                              ]))
                      .toList(),
                ),
              ),
            ),
          );
        });
  }
}
