import 'package:cloud_firestore/cloud_firestore.dart';
class CategoryModel {
  String imgUrl, txt, avatarCol;
  Timestamp createdAt;
  Map<String, dynamic> subCat;

  CategoryModel({
    this.createdAt,
    this.imgUrl,
    this.txt,
    this.avatarCol,
    this.subCat,
  });

  CategoryModel.fromJson(Map<String, dynamic> map) {
    if (map.isEmpty) {
      return;
    }
    imgUrl = map['imgUrl'];
    txt = map['txt'];
    avatarCol = map['avatarCol'];
    createdAt = map['createdAt'];
    subCat = map['sub-cat'];
  }

  toJson() {
    return {
      'imgUrl': imgUrl,
      'txt': txt,
      'avatarCol': avatarCol,
      'createdAt': createdAt,
      'sub-cat': subCat
    };
  }
}
