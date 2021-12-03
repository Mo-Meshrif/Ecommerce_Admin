import '/model/productModel.dart';
import '/core/viewModel/productViewModel.dart';
import '/model/categoryModel.dart';
import '/const.dart';
import '/widgets/customElevatedButton.dart';
import '/widgets/customPopupMenu.dart';
import '/widgets/customText.dart';
import '/widgets/customTextField.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/material.dart';

class ProductsHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      GetBuilder<ProductViewModel>(builder: (productController) {
        GlobalKey<FormState> _key = GlobalKey<FormState>();
        List<CategoryModel> categories = productController.categories;
        List<String> catNames = categories.map((e) => e.txt).toList();
        int catIndex = productController.catIndex;
        List<String> mainCatNames = catIndex != null
            ? (categories[catIndex].subCat['s'] as List).cast<String>()
            : [];
        int mainCatIndex = productController.mainSubIndex;
        List<String> subCatNames = (catIndex != null && mainCatIndex != null)
            ? (categories[catIndex].subCat['s' + '$mainCatIndex'] as List)
                .cast<String>()
            : [];
        bool isTrend = productController.isTrend;
        List<String> colors = productController.colors;
        List<String> selectedColors = productController.selectedColors;
        Map<String, List<String>> sizesMap = productController.sizes;
        String cat = productController.cat;
        List<String> sizes = sizesMap.containsKey(cat) ? sizesMap[cat] : [];
        List<String> selectedSizes = productController.selectedSizes;
        return Form(
          key: _key,
          child: SingleChildScrollView(
            controller: ScrollController(),
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CustomText(
                    txt: 'Add New Product',
                    fSize: 18,
                  ),
                ),
                SizedBox(height: 15),
                Center(
                  child: GestureDetector(
                    onTap: () => productController.getProdImage(),
                    child: DottedBorder(
                      padding: EdgeInsets.all(15),
                      borderType: BorderType.Circle,
                      color: Colors.grey[350],
                      strokeWidth: 1,
                      child: productController.pickedImage == null
                          ? Icon(Icons.upload)
                          : Image.memory(productController.pickedImage),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                CustomText(txt: 'Category Name'),
                SizedBox(height: 10),
                CustomPopupMenu(
                  title: productController.cat,
                  items: catNames,
                  onSelect: (val) {
                    productController.catIndex = catNames.indexOf(val);
                    productController.getSelectedCat(val);
                  },
                ),
                SizedBox(height: 15),
                CustomText(
                  txt: 'Main Sub-Category Name',
                ),
                SizedBox(height: 10),
                CustomPopupMenu(
                  title: productController.mainSubCat,
                  items: mainCatNames,
                  onSelect: (val) {
                    productController.mainSubIndex = mainCatNames.indexOf(val);
                    productController.getSelectedMainSubCat(val);
                  },
                ),
                SizedBox(height: 15),
                CustomText(
                  txt: 'Sub-Category Name',
                ),
                SizedBox(height: 10),
                CustomPopupMenu(
                  title: productController.subCat,
                  items: subCatNames,
                  onSelect: (val) => productController.getSelectedSubCat(val),
                ),
                SizedBox(height: 15),
                CustomText(txt: 'Product Season'),
                SizedBox(height: 10),
                CustomPopupMenu(
                  title: productController.season,
                  items: ['Summer', 'Winter'],
                  onSelect: (val) => productController.getSelectedSesson(val),
                ),
                SizedBox(height: 15),
                CustomText(txt: 'Product Name'),
                SizedBox(height: 10),
                CustomTextField(
                    height: 25,
                    shapeIsCircular: true,
                    bodyColor: Colors.grey[350],
                    onChanged: (val) => productController.prodName=val,
                    valid: (val) {
                      if (val.isEmpty) {
                        return 'The Feild is empty';
                      }
                      return null;
                    },
                    hintTxt: 'Enter Product Name',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                    icon: null),
                SizedBox(height: 15),
                CustomText(txt: 'Trending ?!'),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                        onPressed: () => productController.getTrendState(true),
                        child: CustomText(
                          txt: 'Yes',
                          txtColor: isTrend ? priColor : null,
                        )),
                    TextButton(
                        onPressed: () => productController.getTrendState(false),
                        child: CustomText(
                          txt: 'No',
                          txtColor: !isTrend ? priColor : null,
                        ))
                  ],
                ),
                SizedBox(height: 15),
                CustomText(txt: 'Select Color(s)'),
                SizedBox(height: 10),
                GetBuilder<ProductViewModel>(
                  id: 1,
                  builder: (productController) => LimitedBox(
                    maxHeight: colors.length == 2 ? 35 : 80,
                    child: GridView.builder(
                      controller: ScrollController(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisExtent: 40,
                      ),
                      itemCount: colors.length + 1,
                      itemBuilder: (ctx, i) => i != colors.length
                          ? GestureDetector(
                              onTap: () => productController
                                  .getSelectedColors(colors[i]),
                              child: Container(
                                margin: EdgeInsets.all(5),
                                decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: new Border.all(
                                    color:
                                        selectedColors.indexOf(colors[i]) >= 0
                                            ? priColor
                                            : swatchColor,
                                    width: 4.0,
                                  ),
                                ),
                                child: CircleAvatar(
                                    backgroundColor: HexColor(colors[i]),
                                    radius: 6),
                              ),
                            )
                          : GestureDetector(
                              onTap: () => showDialog(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 15, horizontal: 24),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        title: CustomText(
                                          txt: 'Pick Product Color',
                                        ),
                                        content: SingleChildScrollView(
                                            child: ColorPicker(
                                          pickerColor: Colors.white,
                                          onColorChanged: (color) =>
                                              productController.addColor(color),
                                          showLabel: true,
                                          pickerAreaHeightPercent: 0.8,
                                        )),
                                      )),
                              child: Icon(Icons.add),
                            ),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                CustomText(txt: 'Brand Name'),
                SizedBox(height: 10),
                CustomTextField(
                    height: 25,
                    shapeIsCircular: true,
                    bodyColor: Colors.grey[350],
                    onChanged: (val) => productController.brandName=val,
                    valid: (val) {
                      if (val.isEmpty) {
                        return 'The Feild is empty';
                      }
                      return null;
                    },
                    hintTxt: 'Enter Brand Name',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                    icon: null),
                SizedBox(height: 15),
                CustomText(txt: 'Material Type'),
                SizedBox(height: 10),
                CustomTextField(
                    height: 25,
                    shapeIsCircular: true,
                    bodyColor: Colors.grey[350],
                    onChanged: (val) => productController.materialType=val,
                    valid: (val) {
                      if (val.isEmpty) {
                        return 'The Feild is empty';
                      }
                      return null;
                    },
                    hintTxt: 'Enter Material Type',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                    icon: null),
                SizedBox(height: 15),
                CustomText(txt: 'Product Condition'),
                SizedBox(height: 10),
                CustomTextField(
                    height: 25,
                    shapeIsCircular: true,
                    bodyColor: Colors.grey[350],
                    onChanged: (val) => productController.prodCondition=val,
                    valid: (val) {
                      if (val.isEmpty) {
                        return 'The Feild is empty';
                      }
                      return null;
                    },
                    hintTxt: 'Enter Product Condition',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                    icon: null),
                SizedBox(height: 15),
                CustomText(txt: 'Product Sku'),
                SizedBox(height: 10),
                CustomTextField(
                    height: 25,
                    shapeIsCircular: true,
                    bodyColor: Colors.grey[350],
                    onChanged: (val) => productController.prodSku=val,
                    valid: (val) {
                      if (val.isEmpty) {
                        return 'The Feild is empty';
                      }
                      return null;
                    },
                    hintTxt: 'Enter Product Sku',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                    icon: null),
                SizedBox(height: 15),
                CustomText(txt: 'Product Price (\$)'),
                SizedBox(height: 10),
                CustomTextField(
                    height: 25,
                    shapeIsCircular: true,
                    bodyColor: Colors.grey[350],
                    onChanged: (val) => productController.prodPrice=val,
                    valid: (val) {
                      if (val.isEmpty) {
                        return 'The Feild is empty';
                      }
                      return null;
                    },
                    hintTxt: 'Enter Product Price',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                    icon: null),
                sizes.isNotEmpty
                    ? GetBuilder<ProductViewModel>(
                        id: 2,
                        builder: (productController) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 15),
                            CustomText(txt: 'Select size(s)'),
                            SizedBox(height: 10),
                            LimitedBox(
                              maxHeight: 100,
                              child: GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisExtent: 50,
                                  ),
                                  itemCount: sizes.length,
                                  itemBuilder: (ctx, i) {
                                    bool selected =
                                        selectedSizes.indexOf(sizes[i]) >= 0
                                            ? true
                                            : false;
                                    return CheckboxListTile(
                                      controlAffinity:
                                          ListTileControlAffinity.leading,
                                      contentPadding: EdgeInsets.zero,
                                      title: CustomText(
                                        txt: sizes[i],
                                      ),
                                      value: selected,
                                      onChanged: (value) => productController
                                          .getSelectedSizes(value, sizes[i]),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      )
                    : SizedBox(height: 10),
                Divider(
                  color: Colors.grey,
                  thickness: 0.5,
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomElevatedButton(
                      buttonColor: swatchColor,
                      onpress: () => productController.restProdParameters(),
                      title: 'Discard',
                    ),
                    CustomElevatedButton(
                      buttonColor: priColor,
                      onpress: () {
                        _key.currentState.save();
                        if (_key.currentState.validate()) {
                          productController.addProduct(
                              ProductModel(
                                classification: {
                                  'cat-id': categories[catIndex].id,
                                  'category': productController.mainSubCat,
                                  'sub-cat': productController.subCat
                                },
                                vendorId: productController
                                    .homeViewModel.savedUser.id,
                                prodName: productController.prodName,
                                season: productController.season,
                                color: selectedColors,
                                size: selectedSizes,
                                price: productController.prodPrice,
                                createdAt: Timestamp.now(),
                                brand: productController.brandName,
                                condition: productController.prodCondition,
                                sku: productController.prodSku,
                                material: productController.materialType,
                                trending: isTrend,
                              ),
                              cat,
                              productController.pickedImage);
                        }
                      },
                      title: 'Add',
                      titleColor: swatchColor,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      });
}
