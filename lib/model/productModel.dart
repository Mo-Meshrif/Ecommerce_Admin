import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String id,
      vendorId,
      prodName,
      imgUrl,
      price,
      season,
      brand,
      condition,
      sku,
      material;
  bool trending;
  Map<String, dynamic> classification;
  List<dynamic> color, size;
  Timestamp createdAt;
  ProductModel({
    this.id,
    this.vendorId,
    this.prodName,
    this.imgUrl,
    this.season,
    this.color,
    this.size,
    this.price,
    this.createdAt,
    this.brand,
    this.condition,
    this.sku,
    this.material,
    this.classification,
    this.trending,
  });
  ProductModel.fromJson(Map<String, dynamic> map) {
    if (map == null) {
      return;
    }
    id = map['id'];
    vendorId = map['vendorId'];
    prodName = map['prodName'];
    imgUrl = map['imgUrl'];
    season = map['season'];
    color = map['color'];
    size = map['size'];
    price = map['price'];
    createdAt = map['createdAt'];
    brand = map['brand'];
    condition = map['condition'];
    sku = map['sku'];
    material = map['material'];
    classification = map['classification'];
    trending = map['trending'];
  }
   toJson() {
    return {
      'vendorId':vendorId,
      'prodName': prodName,
      'imgUrl': imgUrl,
      'season': season,
      'color': color,
      'size': size,
      'price': price,
      'createdAt':createdAt,
      'brand':brand,
      'condition': condition,
      'sku': sku,
      'material': material,
      'classification': classification,
      'trending': trending,
    };
  }
}
