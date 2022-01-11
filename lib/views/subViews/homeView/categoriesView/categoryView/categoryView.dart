import '../../../../../widgets/deleteAlert.dart';
import '../../../../../core/viewModel/categoryViewModel.dart';
import '/views/subViews/homeView/categoriesView/categoryView/addEditCategoryView.dart';
import '../../../../../../model/categoryModel.dart';
import '../../../../../widgets/customText.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class CategoryView extends StatelessWidget {
  final int currentIndex;
  final List<CategoryModel> cats;
  CategoryView({@required this.currentIndex, @required this.cats});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    CategoryModel cat = cats[currentIndex];
    List<dynamic> subCat = [];
    for (var i = 0; i < cat.subCat['s'].length; i++) {
      subCat.addAll(cat.subCat['s' + i.toString()]);
    }
    List<dynamic> subCatWithoutRepeated = subCat.toSet().toList();
    return Card(
      color: Colors.grey[200],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  txt: 'Category',
                ),
                GetBuilder<CategoryViewModel>(
                  builder: (categoryController) {
                    GlobalKey<FormState> _key =
                        categoryController.editCategoryKey;
                    return GestureDetector(
                      onTap: () async {
                        categoryController.getOldCategoryData(cat);
                        await showDialog(
                                barrierColor: Colors.grey[50],
                                builder: (ctx) => AlertDialog(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 15, horizontal: 24),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Edit Category"),
                                          Row(
                                            children: [
                                              (currentIndex == 0 ||
                                                      currentIndex == 1 ||
                                                      currentIndex == 2)
                                                  ? Padding(
                                                      padding: EdgeInsets.zero)
                                                  : Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 5),
                                                      child: GestureDetector(
                                                          onTap:
                                                              () => showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (ctx) =>
                                                                            DeleteAlert(
                                                                      title:
                                                                          'Delete Catrgory',
                                                                      messageContent:
                                                                          'Are you sure to delete this category',
                                                                      agree: () =>
                                                                          categoryController.deleteCategory(
                                                                              cat,
                                                                              ctx),
                                                                      notAgree: () =>
                                                                          Navigator.of(ctx)
                                                                              .pop(),
                                                                      isLoading: categoryController
                                                                          .loading
                                                                          .value,
                                                                    ),
                                                                  ),
                                                          child: CircleAvatar(
                                                              child: Icon(Icons
                                                                  .delete))),
                                                    ),
                                              GestureDetector(
                                                onTap: () {
                                                  _key.currentState.save();
                                                  if (_key.currentState
                                                      .validate()) {
                                                    categoryController
                                                        .addEditCategoryToFireStore(
                                                      false,
                                                      CategoryModel(
                                                        id: cat.id,
                                                        txt: categoryController
                                                            .catogoryTitle,
                                                        createdAt:
                                                            cat.createdAt,
                                                        imgUrl: cat.imgUrl,
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
                                                  child: Icon(Icons.check),
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                      content: Container(
                                        width: (size.width - 220) * 0.6,
                                        child: AddEditCategoryView(
                                            oldCategory: cat),
                                      ),
                                    ),
                                context: context)
                            .then((_) => categoryController.restCatParameters(
                                isEditDismiss: true));
                      },
                      child: CircleAvatar(
                        radius: 15,
                        child: Icon(
                          Icons.edit,
                          size: 15,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            Row(
              children: [
                CircleAvatar(
                  radius: 5,
                ),
                SizedBox(width: 5),
                CustomText(
                  txt: cat.txt,
                ),
              ],
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  txt: 'Sub-Category',
                ),
                CustomText(
                    txt: 'Total:' + (subCatWithoutRepeated.length).toString()),
              ],
            ),
            SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisExtent: 50,
                  ),
                  itemCount: subCatWithoutRepeated.length,
                  itemBuilder: (context, x) => Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: CustomText(
                            txt: subCatWithoutRepeated[x],
                          ),
                        ),
                      )),
            )
          ],
        ),
      ),
    );
  }
}
