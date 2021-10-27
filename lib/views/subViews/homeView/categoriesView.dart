import '../../../model/categoryModel.dart';
import '../../../widgets/categoryView.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoriesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                categories.add(CategoryModel.fromJson(element.data()));
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
                        : GestureDetector(
                            onTap: () => null,
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
                  },
                );
        });
  }
}
