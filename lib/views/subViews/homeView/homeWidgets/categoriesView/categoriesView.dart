import '/core/viewModel/homeViewModel.dart';
import '/views/subViews/homeView/homeWidgets/categoriesView/mobileCategoriesView.dart';
import '/../../../core/viewModel/categoryViewModel.dart';
import '/../../../responsive.dart';
import 'categoryView/addEditCategoryView.dart';
import '/../../../model/categoryModel.dart';
import 'categoryView/categoryView.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoriesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Categories')
            .orderBy('createdAt')
            .snapshots(),
        builder: (context, snapshot) {
          List<CategoryModel> categories = [];
          if (snapshot.hasData) {
            (snapshot.data as QuerySnapshot).docs
              ..forEach((element) {
                var data = element.data() as Map;
                categories.add(CategoryModel(
                  id: element.id,
                  createdAt: data['createdAt'],
                  txt: data['txt'],
                  imgUrl: data['imgUrl'],
                  avatarCol: data['avatarCol'],
                  subCat: data['sub-cat'],
                ));
              });
          }
          return categories.isEmpty
              ? Center(child: CircularProgressIndicator())
              : Responsive.isMobile(context)
                  ? WillPopScope(
                      onWillPop: () async =>
                          Get.find<HomeViewModel>().currentItem != 'dash'
                              ? false
                              : true,
                      child: MobileCategoriesView(categories: categories))
                  : GridView.builder(
                      padding: EdgeInsets.all(15),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: Responsive.isDesktop(context) ? 4 : 3,
                      ),
                      itemCount: categories.length + 1,
                      itemBuilder: (context, i) {
                        return i != 0
                            ? CategoryView(
                                cats: categories,
                                currentIndex: i - 1,
                              )
                            : GetBuilder<CategoryViewModel>(
                                builder: (categoryController) {
                                GlobalKey<FormState> _key =
                                    categoryController.addCategoryKey;
                                return GestureDetector(
                                  onTap: () async {
                                    categoryController.restCatParameters();
                                    await showDialog(
                                            barrierColor: Colors.grey[50],
                                            builder: (ctx) => AlertDialog(
                                                  contentPadding:
                                                      const EdgeInsets
                                                              .symmetric(
                                                          vertical: 15,
                                                          horizontal: 24),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                  title: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text("Add Category"),
                                                      GestureDetector(
                                                        onTap: () {
                                                          _key.currentState!
                                                              .save();
                                                          if (_key.currentState!
                                                              .validate()) {
                                                            categoryController
                                                                .addEditCategoryToFireStore(
                                                              true,
                                                              CategoryModel(
                                                                txt: categoryController
                                                                    .catogoryTitle,
                                                                createdAt:
                                                                    Timestamp
                                                                        .now(),
                                                                avatarCol: '#' +
                                                                    categoryController
                                                                        .pickedColor
                                                                        .value
                                                                        .toRadixString(
                                                                            16),
                                                                subCat: categoryController
                                                                    .subCategories,
                                                              ),
                                                              categoryController
                                                                  .pickedImage,
                                                              context,
                                                            );
                                                          }
                                                        },
                                                        child: CircleAvatar(
                                                          child:
                                                              Icon(Icons.add),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  content: Container(
                                                    width: Responsive.isDesktop(
                                                            context)
                                                        ? (size.width - 220) *
                                                            0.8
                                                        : size.width * 0.8,
                                                    child:
                                                        AddEditCategoryView(),
                                                  ),
                                                ),
                                            context: context)
                                        .then((_) => categoryController
                                            .restCatParameters());
                                  },
                                  child: Card(
                                    color: Colors.grey[200],
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.add,
                                        size: 40,
                                      ),
                                    ),
                                  ),
                                );
                              });
                      },
                    );
        });
  }
}
