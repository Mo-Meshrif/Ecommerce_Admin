import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../model/categoryModel.dart';

class FireStoreCategory {
  final collectionCategory =
      FirebaseFirestore.instance.collection('Categories');
  final storageRef = FirebaseStorage.instance;

  Future<List<QueryDocumentSnapshot>> getCategoriesFromFireStore() async {
    var val = await collectionCategory.orderBy('createdAt').get();
    return val.docs;
  }

  Future<void> addCategoryToFireStore(CategoryModel category) async {
    return await collectionCategory.add(category.toJson());
  }

  Future<void> editCategoryfromFireStore(CategoryModel category) async {
    return await collectionCategory.doc(category.id).update(category.toJson());
  }

  Future<void> deleteCategoryfromFireStore(CategoryModel category) async {
    return await collectionCategory.doc(category.id).delete().then((_) => storageRef
        .ref()
        .child('categories')
        .child('${category.txt}')
        .child('${category.txt}.png').delete());
  }

  Future<String> uploadCatImage(Uint8List pic, String catTitle) async {
    String url;
    Reference reference = storageRef
        .ref()
        .child('categories')
        .child('$catTitle')
        .child('$catTitle.png');
    await reference.putData(pic).then((val) async {
      url = await val.ref.getDownloadURL();
    });
    return url;
  }
}
