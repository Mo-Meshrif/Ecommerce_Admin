import 'dart:typed_data';
import '/responsive.dart';
import '/../../../../core/viewModel/categoryViewModel.dart';
import '/../../../../widgets/customText.dart';
import '/../../../../widgets/customTextField.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddEditCategoryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryViewModel>(
      builder: (categoryController) {
        int mainSubCounter = categoryController.mainSubCounter;
        Map<String, List<int>> subCounterMap = categoryController.subCounter;
        List<String> mainSubCategories =
            categoryController.subCategories['s'] as List<String>;
        Color pickedColor = categoryController.pickedColor;
        Color? backgroundColor = pickedColor != Colors.white
            ? pickedColor.computeLuminance() > 0.5
                ? Colors.black
                : Colors.white
            : null;
        bool isEdit = categoryController.oldImage != null ? true : false;
        return categoryController.loading.value
            ? Center(child: CircularProgressIndicator())
            : Form(
                key: categoryController.oldImage == null
                    ? Responsive.isMobile(context)
                        ? categoryController.mobileAddCategoryKey
                        : categoryController.addCategoryKey
                    : Responsive.isMobile(context)
                        ? categoryController.mobileEditCategoryKey
                        : categoryController.editCategoryKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 42,
                              backgroundColor: backgroundColor,
                              child: CircleAvatar(
                                backgroundColor: pickedColor,
                                radius: 40,
                                child: GestureDetector(
                                    onTap: () =>
                                        categoryController.getCatImage(),
                                    child: categoryController.oldImage !=
                                                null &&
                                            categoryController.pickedImage ==
                                                null
                                        ? Image.network(categoryController
                                            .oldImage as String)
                                        : categoryController.pickedImage == null
                                            ? Icon(Icons.upload)
                                            : Image.memory(categoryController
                                                .pickedImage as Uint8List)),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: CircleAvatar(
                                radius: 15,
                                backgroundColor: backgroundColor,
                                child: CircleAvatar(
                                  radius: 13,
                                  backgroundColor: pickedColor,
                                  child: GestureDetector(
                                      onTap: () => showDialog(
                                          context: context,
                                          builder: (ctx) => AlertDialog(
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 15,
                                                        horizontal: 24),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                title: CustomText(
                                                  txt: 'Pick Background Color',
                                                ),
                                                content: SingleChildScrollView(
                                                    child: ColorPicker(
                                                  pickerColor:
                                                      categoryController
                                                          .pickedColor,
                                                  onColorChanged: (color) =>
                                                      categoryController
                                                          .getPickedColor(
                                                              color),
                                                  pickerAreaHeightPercent: 0.8,
                                                )),
                                              )),
                                      child: Icon(
                                        Icons.color_lens,
                                        color: backgroundColor,
                                      )),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      CustomText(
                        txt: 'Title',
                      ),
                      SizedBox(height: 10),
                      CustomTextField(
                        bodyColor: Colors.grey[200] as Color,
                        initVal: categoryController.catogoryTitle,
                        onChanged: (val) =>
                            categoryController.catogoryTitle = val.trim(),
                        valid: (val) {
                          if (val!.isEmpty) {
                            return 'The Feild is empty';
                          }
                          return null;
                        },
                        hintTxt: 'Enter category title',
                      ),
                      SizedBox(height: 15),
                      ExpansionTile(
                        initiallyExpanded: true,
                        tilePadding: EdgeInsets.zero,
                        title: CustomText(
                          txt: 'Main Sub-Categories',
                        ),
                        children: [
                          LimitedBox(
                            maxHeight: mainSubCounter.isEven
                                ? mainSubCounter * 30
                                : mainSubCounter >= 6
                                    ? 180
                                    : (mainSubCounter * 30 + 30).toDouble(),
                            child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisExtent: 50,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                              ),
                              itemCount: mainSubCounter,
                              itemBuilder: (ctx, i) {
                                bool addShown = mainSubCounter - 1 == i &&
                                    (mainSubCategories.isNotEmpty
                                        ? mainSubCategories[i] != ''
                                        : false);
                                return Row(
                                  children: [
                                    Expanded(
                                      child: CustomTextField(
                                          bodyColor: Colors.grey[200] as Color,
                                          initVal: mainSubCategories.isNotEmpty
                                              ? mainSubCategories[i]
                                              : null,
                                          onChanged: (val) => categoryController
                                              .addMainSubCategory(
                                                  isEdit, val, i),
                                          valid: (val) {
                                            if (val!.isEmpty) {
                                              return 'The Feild is empty';
                                            }
                                            return null;
                                          },
                                          hintTxt: 'Enter main sub-category',
                                          suffix: addShown
                                              ? GestureDetector(
                                                  onTap: () =>
                                                      categoryController
                                                          .changeMainCounter(
                                                              isEdit, 'add', i),
                                                  child: Icon(Icons.add),
                                                )
                                              : null),
                                    ),
                                    i == mainSubCounter - 1 && i != 0
                                        ? Container(
                                            color: Colors.grey[200],
                                            height: 48,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 16),
                                              child: GestureDetector(
                                                  onTap: () =>
                                                      categoryController
                                                          .changeMainCounter(
                                                              isEdit, 'sub', i),
                                                  child: Icon(Icons.minimize)),
                                            ),
                                          )
                                        : Padding(padding: EdgeInsets.zero)
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      CustomText(
                        txt: 'Sub-Categories',
                      ),
                      mainSubCategories.isEmpty
                          ? Center(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: CustomText(
                                  txt: 'Enter only one main sub-category !',
                                ),
                              ),
                            )
                          : Column(
                              children: mainSubCategories.map((e) {
                                int x = mainSubCategories.indexOf(e);
                                List<int>? subCounter =
                                    (subCounterMap['s' + x.toString()]);
                                int subCounterLength = subCounter!.length;
                                return Column(
                                  children: [
                                    SizedBox(height: 10),
                                    LimitedBox(
                                      maxHeight: subCounterLength.isEven
                                          ? subCounterLength * 30
                                          : subCounterLength >= 6
                                              ? 180
                                              : (subCounter.length * 30 + 30)
                                                  .toDouble(),
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 40,
                                            child: CustomText(
                                              txt: 'MS' + (x + 1).toString(),
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Expanded(
                                            child: GridView.builder(
                                              controller: ScrollController(),
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2,
                                                mainAxisExtent: 50,
                                                mainAxisSpacing: 10,
                                                crossAxisSpacing: 10,
                                              ),
                                              itemCount: subCounterLength,
                                              itemBuilder: (ctx, i) {
                                                int mainCatoIndex =
                                                    mainSubCategories
                                                        .indexWhere((cato) =>
                                                            cato ==
                                                            mainSubCategories[
                                                                x]);
                                                List<String>? subCats =
                                                    categoryController
                                                            .subCategories[
                                                        's' + x.toString()];
                                                return Row(
                                                  children: [
                                                    Expanded(
                                                      child: CustomTextField(
                                                          bodyColor:
                                                              Colors.grey[200]
                                                                  as Color,
                                                          initVal:
                                                              subCats?[i] != null
                                                                  ? subCats![i]
                                                                  : null,
                                                          onChanged: (val) =>
                                                              categoryController
                                                                  .addSubCategory(
                                                                      isEdit,
                                                                      mainCatoIndex,
                                                                      val,
                                                                      i),
                                                          valid: (val) {
                                                            if (val!.isEmpty) {
                                                              return 'The Feild is empty';
                                                            }
                                                            return null;
                                                          },
                                                          hintTxt:
                                                              'Enter sub-category',
                                                          suffix: i == subCounterLength - 1
                                                              ? GestureDetector(
                                                                  onTap: () =>
                                                                      categoryController.changeSubCounter(
                                                                          isEdit,
                                                                          mainCatoIndex,
                                                                          'add',
                                                                          i),
                                                                  child: Icon(Icons.add))
                                                              : null),
                                                    ),
                                                    i == subCounterLength - 1 &&
                                                            i != 0
                                                        ? Container(
                                                            color: Colors
                                                                .grey[200],
                                                            height: 48,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      bottom:
                                                                          16),
                                                              child: GestureDetector(
                                                                  onTap: () => categoryController
                                                                      .changeSubCounter(
                                                                          isEdit,
                                                                          mainCatoIndex,
                                                                          'sub',
                                                                          i),
                                                                  child: Icon(Icons
                                                                      .minimize)),
                                                            ),
                                                          )
                                                        : Padding(
                                                            padding:
                                                                EdgeInsets.zero)
                                                  ],
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    mainSubCategories.length - 1 > x
                                        ? Divider(
                                            thickness: 0.5,
                                            color: Colors.grey[400],
                                          )
                                        : Padding(padding: EdgeInsets.zero),
                                  ],
                                );
                              }).toList(),
                            )
                    ],
                  ),
                ),
              );
      },
    );
  }
}
