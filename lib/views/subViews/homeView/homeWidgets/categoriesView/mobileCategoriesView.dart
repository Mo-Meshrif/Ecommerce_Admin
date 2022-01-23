import 'package:hexcolor/hexcolor.dart';
import '/widgets/customText.dart';
import '/model/categoryModel.dart';
import 'package:flutter/material.dart';

class MobileCategoriesView extends StatelessWidget {
  final List<CategoryModel> categories;
  MobileCategoriesView({@required this.categories});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          GestureDetector(
            onTap: () =>print('add'),
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
                for (var i = 0; i < cat.subCat['s'].length; i++) {
                  subCat.addAll(cat.subCat['s' + i.toString()]);
                }
                List<dynamic> subCatWithoutRepeated = subCat.toSet().toList();
                return Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.black,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Theme(
                    data:
                        ThemeData().copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      leading: Image.network(
                        cat.imgUrl,
                        color: HexColor(cat.avatarCol),
                        width: 40,
                        height: 40,
                      ),
                      title: CustomText(
                        txt: cat.txt,
                        txtColor: HexColor(cat.avatarCol),
                      ),
                      subtitle: CustomText(
                        txt: 'Sub-Category : ' +
                            subCatWithoutRepeated.length.toString(),
                      ),
                      trailing: GestureDetector(
                        onTap: () =>print('edit'),
                        child: Icon(
                          Icons.edit,
                          color: Colors.grey[600],
                        ),
                      ),
                      childrenPadding: EdgeInsets.symmetric(horizontal: 15),
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
                                      borderRadius: BorderRadius.circular(10),
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
    );
  }
}
