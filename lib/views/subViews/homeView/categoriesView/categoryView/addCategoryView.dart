import '../../../../../core/viewModel/categoryViewModel.dart';
import '../../../../../widgets/customText.dart';
import '../../../../../widgets/customTextField.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddCategoryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryViewModel>(
      builder: (categoryController) {
        int mainSubCounter = categoryController.mainSubCounter;
        Map<String, List<int>> subCounterMap = categoryController.subCounter;
        List<String> mainSubCategories = categoryController.subCategories['s'];
        return categoryController.isAddCategory.value
            ? Center(child: CircularProgressIndicator())
            : Form(
                key: categoryController.addCategoryKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 42,
                            child: CircleAvatar(
                              backgroundColor: categoryController.pickedColor,
                              radius: 40,
                              child: GestureDetector(
                                  onTap: () => categoryController.getCatImage(),
                                  child: categoryController.pickedImage == null
                                      ? Icon(Icons.upload)
                                      : Image.memory(
                                          categoryController.pickedImage)),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: CircleAvatar(
                              radius: 15,
                              child: CircleAvatar(
                                radius: 13,
                                backgroundColor: Colors.white,
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
                                                    categoryController.pickedColor,
                                                onColorChanged: (color) =>
                                                    categoryController
                                                        .getPickedColor(color),
                                                showLabel: true,
                                                pickerAreaHeightPercent: 0.8,
                                              )),
                                            )),
                                    child: Icon(Icons.color_lens)),
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
                      bodyColor: Colors.grey[200],
                      onChanged: (val) =>
                          categoryController.catogoryTitle = val.trim(),
                      valid: (val) {
                        if (val.isEmpty) {
                          return 'The Feild is empty';
                        }
                        return null;
                      },
                      hintTxt: 'Enter category title',
                      icon: null,
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
                            itemBuilder: (ctx, i) => Row(
                              children: [
                                Expanded(
                                  child: CustomTextField(
                                      bodyColor: Colors.grey[200],
                                      onChanged: (val) => categoryController
                                          .addMainSubCategory(val, i),
                                      valid: (val) {
                                        if (val.isEmpty) {
                                          return 'The Feild is empty';
                                        }
                                        return null;
                                      },
                                      hintTxt: 'Enter main sub-category',
                                      icon: null,
                                      suffix: i == mainSubCounter - 1
                                          ? GestureDetector(
                                              onTap: () => categoryController
                                                  .changeMainCounter('add', i),
                                              child: Icon(Icons.add))
                                          : null),
                                ),
                                i == mainSubCounter - 1 && i != 0
                                    ? Container(
                                        color: Colors.grey[200],
                                        height: 48,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 16),
                                          child: GestureDetector(
                                              onTap: () => categoryController
                                                  .changeMainCounter('sub', i),
                                              child: Icon(Icons.minimize)),
                                        ),
                                      )
                                    : Padding(padding: EdgeInsets.zero)
                              ],
                            ),
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
                        : Expanded(
                            child: ListView.separated(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              itemCount: mainSubCategories.length,
                              itemBuilder: (context, x) {
                                List<int> subCounter =
                                    subCounterMap['s' + x.toString()];
                                return LimitedBox(
                                  maxHeight: subCounter.length.isEven
                                      ? subCounter.length * 30
                                      : subCounter.length >= 6
                                          ? 180
                                          : (subCounter.length * 30 + 30)
                                              .toDouble(),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 40,
                                        child: CustomText(
                                          txt: mainSubCategories[x],
                                        ),
                                      ),
                                      Expanded(
                                        child: GridView.builder(
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            mainAxisExtent: 50,
                                            mainAxisSpacing: 10,
                                            crossAxisSpacing: 10,
                                          ),
                                          itemCount: subCounter.length,
                                          itemBuilder: (ctx, i) {
                                            int mainCatoIndex =
                                                mainSubCategories.indexWhere(
                                                    (cato) =>
                                                        cato ==
                                                        mainSubCategories[x]);
                                            return Row(
                                              children: [
                                                Expanded(
                                                  child: CustomTextField(
                                                      bodyColor:
                                                          Colors.grey[200],
                                                      onChanged: (val) =>
                                                          categoryController
                                                              .addSubCategory(
                                                                  mainCatoIndex,
                                                                  val,
                                                                  i),
                                                      valid: (val) {
                                                        if (val.isEmpty) {
                                                          return 'The Feild is empty';
                                                        }
                                                        return null;
                                                      },
                                                      hintTxt:
                                                          'Enter sub-category',
                                                      icon: null,
                                                      suffix: i == subCounter.length - 1
                                                          ? GestureDetector(
                                                              onTap: () =>
                                                                  categoryController
                                                                      .changeSubCounter(
                                                                          mainCatoIndex,
                                                                          'add',
                                                                          i),
                                                              child: Icon(
                                                                  Icons.add))
                                                          : null),
                                                ),
                                                i == subCounter.length - 1 &&
                                                        i != 0
                                                    ? Container(
                                                        color: Colors.grey[200],
                                                        height: 48,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  bottom: 16),
                                                          child: GestureDetector(
                                                              onTap: () =>
                                                                  categoryController
                                                                      .changeSubCounter(
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
                                );
                              },
                              separatorBuilder: (ctx, i) => SizedBox(height: 5),
                            ),
                          )
                  ],
                ),
              );
      },
    );
  }
}
