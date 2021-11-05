import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../model/categoryModel.dart';

class FireStoreCategory {
  final collectionCategory =
      FirebaseFirestore.instance.collection('Categories');
  final storageRef = FirebaseStorage.instance;
  Future<void> addCategoryToFireStore(CategoryModel category) async {
    return await collectionCategory.add(category.toJson());
  }

  Future<String> uploadCatImage(Uint8List pic,String catTitle) async {
    String url;
    Reference reference =
        storageRef.ref().child('categories').child('$catTitle').child('$catTitle.png');
    await reference.putData(pic).then((val) async {
      url = await val.ref.getDownloadURL();
    });
    return url;
  }
}
