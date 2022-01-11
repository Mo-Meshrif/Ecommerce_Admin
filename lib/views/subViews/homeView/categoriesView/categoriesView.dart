import '../../../../core/viewModel/categoryViewModel.dart';
import 'categoryView/addEditCategoryView.dart';
import '../../../../model/categoryModel.dart';
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
            snapshot.data.docs as List<DocumentSnapshot>
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
              : GridView.builder(
                  padding: EdgeInsets.all(15),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                  ),
                  itemCount: categories.length + 1,
                  itemBuilder: (context, i) {
                    return i != categories.length
                        ? CategoryView(
                            cats: categories,
                            currentIndex: i != categories.length ? i : null,
                          )
                        : GetBuilder<CategoryViewModel>(
                            builder: (categoryController) {
                            GlobalKey<FormState> _key =
                                categoryController.addCategoryKey;
                            return GestureDetector(
                              onTap: () async {
                                categoryController.restCatParameters(
                                    isEditDismiss: false);
                                await showDialog(
                                        barrierColor: Colors.grey[50],
                                        builder: (ctx) => AlertDialog(
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 15,
                                                      horizontal: 24),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              title: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text("Add Category"),
                                                  GestureDetector(
                                                    onTap: () {
                                                      _key.currentState.save();
                                                      if (_key.currentState
                                                          .validate()) {
                                                        categoryController
                                                            .addEditCategoryToFireStore(
                                                          true,
                                                          CategoryModel(
                                                            txt: categoryController
                                                                .catogoryTitle,
                                                            createdAt:
                                                                Timestamp.now(),
                                                            avatarCol: '#' +
                                                                categoryController
                                                                    .pickedColor
                                                                    .value
                                                                    .toRadixString(
                                                                        16),
                                                            subCat:
                                                                categoryController
                                                                    .subCategories,
                                                          ),
                                                          categoryController
                                                              .pickedImage,
                                                          context,
                                                        );
                                                      }
                                                    },
                                                    child: CircleAvatar(
                                                      child: Icon(Icons.add),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              content: Container(
                                                width: (size.width - 220) * 0.6,
                                                child: AddEditCategoryView(
                                                    oldCategory: null),
                                              ),
                                            ),
                                        context: context)
                                    .then((_) =>
                                        categoryController.restCatParameters(
                                            isEditDismiss: false));
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
