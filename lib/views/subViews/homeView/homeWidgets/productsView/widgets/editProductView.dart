import '/core/viewModel/productViewModel.dart';
import '/model/categoryModel.dart';
import '/model/productModel.dart';
import '/widgets/customPopupMenu.dart';
import '/widgets/customText.dart';
import '/widgets/customTextField.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import '/../../../const.dart';

class EditProductView extends StatelessWidget {
  final ProductModel prod;

  EditProductView({@required this.prod});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductViewModel>(
      id: 3,
      builder: (productController) {
        List<CategoryModel> categories = productController.categories;
        List<String> catNames = categories.map((e) => e.txt).toList();
        int catIndex = productController.reCatIndex;
        List<String> mainCatNames = catIndex != null
            ? (categories[catIndex].subCat['s'] as List).cast<String>()
            : [];
        int mainCatIndex = productController.reMainSubIndex;
        List<String> subCatNames = (catIndex != null && mainCatIndex != null)
            ? (categories[catIndex].subCat['s' + '$mainCatIndex'] as List)
                .cast<String>()
            : [];
        bool isTrend = productController.reTrend;
        List<String> colors = productController.reColors;
        List<String> selectedColors = productController.reSelectedColors;
        Map<String, List<String>> sizesMap = productController.sizes;
        String cat = productController.reCat;
        List<String> sizes = sizesMap.containsKey(cat) ? sizesMap[cat] : [];
        List<String> selectedSizes = productController.reSelectedSizes;
        return productController.reLoading.value
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                controller: ScrollController(),
                padding: const EdgeInsets.fromLTRB(0, 15, 15, 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: GestureDetector(
                        onTap: () => productController.reGetProdImage(),
                        child: DottedBorder(
                          padding: EdgeInsets.all(15),
                          borderType: BorderType.Circle,
                          color: Colors.grey,
                          strokeWidth: 1,
                          child: productController.rePickedImage == null
                              ? Image.network(
                                  prod.imgUrl,
                                  width: 50,
                                  height: 50,
                                )
                              : Image.memory(productController.rePickedImage),
                        ),
                      ),
                    ),
                    CustomText(
                      txt: 'Classification :',
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomPopupMenu(
                          title:'Category : ' +  productController.reCat,
                          items: catNames,
                          onSelect: (val) {
                            productController.reCatIndex =
                                catNames.indexOf(val);
                            productController.getReSelectedCat(val);
                          },
                        ),
                        SizedBox(width: 10),
                        CustomPopupMenu(
                          title: 'Main Sub : ' + productController.reMainSubCat,
                          items: mainCatNames,
                          onSelect: (val) {
                            int index = mainCatNames.indexOf(val);
                            productController.reMainSubIndex = index;
                            productController.getCurrentCato(index);
                            productController.getReSelectedMainSubCat(val);
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomPopupMenu(
                          title: 'Sub-Cat : ' + productController.reSubCat,
                          items: subCatNames,
                          onSelect: (val) =>
                              productController.getReSelectedSubCat(val),
                        ),
                        SizedBox(width: 10),
                        CustomPopupMenu(
                          title:' Season : ' + productController.reSeason,
                          items: ['Summer', 'Winter','Not defined'],
                          onSelect: (val) =>
                              productController.getReSelectedSesson(val),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    CustomText(txt: 'Trending ?!'),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                            onPressed: () =>
                                productController.getReTrendState(true),
                            child: CustomText(
                              txt: 'Yes',
                              txtColor: isTrend ? priColor : null,
                            )),
                        TextButton(
                            onPressed: () =>
                                productController.getReTrendState(false),
                            child: CustomText(
                              txt: 'No',
                              txtColor: !isTrend ? priColor : null,
                            ))
                      ],
                    ),
                    SizedBox(height: 15),
                    CustomText(txt: 'Product Name :'),
                    SizedBox(height: 10),
                    CustomTextField(
                        height: 25,
                        shapeIsCircular: true,
                        bodyColor: Colors.grey[350],
                        initVal: productController.reProdName,
                        onChanged: (val) => productController.reProdName = val,
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
                    CustomText(txt: 'Brand Name : '),
                    SizedBox(height: 10),
                    CustomTextField(
                        height: 25,
                        shapeIsCircular: true,
                        bodyColor: Colors.grey[350],
                        initVal: productController.reBrandName,
                        onChanged: (val) => productController.reBrandName = val,
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
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(txt: 'Color(s) : '),
                              SizedBox(height: 10),
                              GetBuilder<ProductViewModel>(
                                id: 4,
                                builder: (productController) => LimitedBox(
                                  maxHeight: colors.length == 2 ? 35 : 80,
                                  child: GridView.builder(
                                    controller: ScrollController(),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      mainAxisExtent: 40,
                                    ),
                                    itemCount: colors.length + 1,
                                    itemBuilder: (ctx, i) => i != colors.length
                                        ? GestureDetector(
                                            onTap: () => productController
                                                .reGetSelectedColors(colors[i]),
                                            child: Container(
                                              margin: EdgeInsets.all(5),
                                              decoration: new BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: new Border.all(
                                                  color: selectedColors.indexOf(
                                                              colors[i]) >=
                                                          0
                                                      ? priColor
                                                      : swatchColor,
                                                  width: 4.0,
                                                ),
                                              ),
                                              child: CircleAvatar(
                                                  backgroundColor:
                                                      HexColor(colors[i]),
                                                  radius: 6),
                                            ),
                                          )
                                        : GestureDetector(
                                            onTap: () => showDialog(
                                                context: context,
                                                builder: (ctx) => AlertDialog(
                                                      contentPadding:
                                                          const EdgeInsets
                                                                  .symmetric(
                                                              vertical: 15,
                                                              horizontal: 24),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                      ),
                                                      title: CustomText(
                                                        txt:
                                                            'Pick Product Color',
                                                      ),
                                                      content:
                                                          SingleChildScrollView(
                                                              child:
                                                                  ColorPicker(
                                                        pickerColor:
                                                            Colors.white,
                                                        onColorChanged:
                                                            (color) =>
                                                                productController
                                                                    .reAddColor(
                                                                        color),
                                                        showLabel: true,
                                                        pickerAreaHeightPercent:
                                                            0.8,
                                                      )),
                                                    )),
                                            child: Icon(Icons.add),
                                          ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10),
                        sizes.isNotEmpty
                            ? Expanded(
                                child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(txt: 'Size(s) : '),
                                  SizedBox(height: 5),
                                  LimitedBox(
                                    maxHeight: 100,
                                    child: GridView.builder(
                                        padding: EdgeInsets.only(left: 35),
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisExtent: 40,
                                        ),
                                        itemCount: sizes.length,
                                        itemBuilder: (ctx, i) {
                                          bool selected =
                                              selectedSizes.indexOf(sizes[i]) >=
                                                      0
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
                                            onChanged: (value) =>
                                                productController
                                                    .reGetSelectedSizes(
                                                        value, sizes[i]),
                                          );
                                        }),
                                  ),
                                ],
                              ))
                            : Padding(
                                padding: EdgeInsets.zero,
                              )
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(txt: 'Material Type :'),
                              SizedBox(height: 10),
                              CustomTextField(
                                  height: 25,
                                  shapeIsCircular: true,
                                  bodyColor: Colors.grey[350],
                                  initVal: productController.reMaterialType,
                                  onChanged: (val) =>
                                      productController.reMaterialType = val,
                                  valid: (val) {
                                    if (val.isEmpty) {
                                      return 'The Feild is empty';
                                    }
                                    return null;
                                  },
                                  hintTxt: 'Enter Material Type',
                                  hintStyle: TextStyle(
                                      color: Colors.grey, fontSize: 15),
                                  icon: null),
                            ],
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(txt: 'Product Condition :'),
                              SizedBox(height: 10),
                              CustomTextField(
                                  height: 25,
                                  shapeIsCircular: true,
                                  bodyColor: Colors.grey[350],
                                  initVal: productController.reProdCondition,
                                  onChanged: (val) =>
                                      productController.reProdCondition = val,
                                  valid: (val) {
                                    if (val.isEmpty) {
                                      return 'The Feild is empty';
                                    }
                                    return null;
                                  },
                                  hintTxt: 'Enter Product Condition',
                                  hintStyle: TextStyle(
                                      color: Colors.grey, fontSize: 15),
                                  icon: null),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(txt: 'Product Sku :'),
                              SizedBox(height: 10),
                              CustomTextField(
                                  height: 25,
                                  shapeIsCircular: true,
                                  bodyColor: Colors.grey[350],
                                  initVal: productController.reProdSku,
                                  onChanged: (val) =>
                                      productController.reProdSku = val,
                                  valid: (val) {
                                    if (val.isEmpty) {
                                      return 'The Feild is empty';
                                    }
                                    return null;
                                  },
                                  hintTxt: 'Enter Product Sku',
                                  hintStyle: TextStyle(
                                      color: Colors.grey, fontSize: 15),
                                  icon: null),
                            ],
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(txt: 'Product Price (\$) :'),
                              SizedBox(height: 10),
                              CustomTextField(
                                  height: 25,
                                  shapeIsCircular: true,
                                  bodyColor: Colors.grey[350],
                                  initVal: productController.reProdPrice,
                                  onChanged: (val) =>
                                      productController.reProdPrice = val,
                                  valid: (val) {
                                    if (val.isEmpty) {
                                      return 'The Feild is empty';
                                    }
                                    return null;
                                  },
                                  hintTxt: 'Enter Product Price',
                                  hintStyle: TextStyle(
                                      color: Colors.grey, fontSize: 15),
                                  icon: null),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 10)
                  ],
                ),
              );
      },
    );
  }
}
