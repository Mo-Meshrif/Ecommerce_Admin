import '/views/subViews/homeView/homeWidgets/categoriesView/categoryView/addEditCategoryView.dart';
import '/core/viewModel/homeViewModel.dart';
import '/core/viewModel/categoryViewModel.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import '/widgets/customText.dart';
import '/model/categoryModel.dart';
import 'package:flutter/material.dart';

class MobileCategoriesView extends StatelessWidget {
  final List<CategoryModel> categories;
  MobileCategoriesView({required this.categories});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryViewModel>(
      builder: (categoryController) => categoryController
              .isMobileAddEditCategory.value
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: AddEditCategoryView(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.find<HomeViewModel>().getCurrentItem('addCategory');
                      categoryController.getMobileViewStatus(true);
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
                  Column(
                    children: categories.map(
                      (cat) {
                        List<dynamic> subCat = [];
                        for (var i = 0; i < cat.subCat!['s'].length; i++) {
                          subCat.addAll(cat.subCat!['s' + i.toString()]);
                        }
                        List<dynamic> subCatWithoutRepeated =
                            subCat.toSet().toList();
                        return Card(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Colors.black,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Theme(
                            data: ThemeData()
                                .copyWith(dividerColor: Colors.transparent),
                            child: ExpansionTile(
                              leading: Image.network(
                                cat.imgUrl as String,
                                color: HexColor(cat.avatarCol as String),
                                width: 40,
                                height: 40,
                              ),
                              title: CustomText(
                                txt: cat.txt as String,
                                txtColor: HexColor(cat.avatarCol as String),
                              ),
                              subtitle: CustomText(
                                txt: 'Sub-Category : ' +
                                    subCatWithoutRepeated.length.toString(),
                              ),
                              trailing: GestureDetector(
                                onTap: () {
                                  Get.find<HomeViewModel>()
                                      .getCurrentItem('editCategory');
                                  categoryController.getMobileViewStatus(true);
                                  categoryController.getOldCategoryData(cat);
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
                                LimitedBox(
                                  maxHeight: subCatWithoutRepeated.length < 3
                                      ? 50
                                      : subCatWithoutRepeated.length / 3 * 50,
                                  child: GridView.builder(
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        mainAxisExtent: 50,
                                      ),
                                      itemCount: subCatWithoutRepeated.length,
                                      itemBuilder: (context, x) => Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Center(
                                              child: CustomText(
                                                txt: subCatWithoutRepeated[x],
                                              ),
                                            ),
                                          )),
                                ),
                                SizedBox(height: 10),
                              ],
                            ),
                          ),
                        );
                      },
                    ).toList(),
                  )
                ],
              ),
            ),
    );
  }
}
