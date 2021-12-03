import '/core/viewModel/productViewModel.dart';
import 'package:get/get.dart';
import '/views/subViews/homeView/productsView/productsHeader.dart';
import '../../../../widgets/customText.dart';
import 'package:flutter/material.dart';

class ProductsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<ProductViewModel>(
        init: ProductViewModel(),
        builder: (productController) {
          return productController.isLoading.value
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Row(
                  children: [
                    Container(
                      width: 250,
                      height: size.height,
                      child: ProductsHeader(),
                    ),
                    VerticalDivider(
                      color: Colors.grey,
                      thickness: 0.5,
                    ),
                    Expanded(
                        child: Center(
                      child: CustomText(
                        txt: 'ProductsView',
                      ),
                    ))
                  ],
                );
        });
  }
}