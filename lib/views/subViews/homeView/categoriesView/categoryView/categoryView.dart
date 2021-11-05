import '/views/subViews/homeView/categoriesView/categoryView/editCategoryView.dart';
import '../../../../../../model/categoryModel.dart';
import '../../../../../widgets/customText.dart';
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
                GestureDetector(
                  onTap: () => showDialog(
                      builder: (ctx) => AlertDialog(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 24),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Edit Category"),
                                CircleAvatar(
                                  child: Icon(Icons.check),
                                ),
                              ],
                            ),
                            content: Container(
                              width: (size.width - 220) * 0.6,
                              child: EditCategoryView(),
                            ),
                          ),
                      context: context),
                  child: CircleAvatar(
                    radius: 15,
                    child: Icon(
                      Icons.edit,
                      size: 15,
                    ),
                  ),
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
