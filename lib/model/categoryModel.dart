import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String id, imgUrl, txt, avatarCol;
  Timestamp createdAt;
  Map<String, dynamic> shop;
  Map<String, dynamic> subCat;
  CategoryModel({
    this.id,
    this.imgUrl,
    this.txt,
    this.avatarCol,
    this.shop,
    this.subCat,
  });
  CategoryModel.fromJson(Map<String, dynamic> map) {
    if (map.isEmpty) {
      return;
    }
    id = map['id'];
    imgUrl = map['imgUrl'];
    txt = map['txt'];
    avatarCol = map['avatarCol'];
    createdAt = map['createdAt'];
    shop = map['shop'];
    subCat = map['sub-cat'];
  }

  toJson() {
    return {
      'id': id,
      'imgUrl': imgUrl,
      'txt': txt,
      'avatarCol': avatarCol,
      'createdAt': createdAt,
      'shop': shop,
      'sub-cat': subCat
    };
  }
}