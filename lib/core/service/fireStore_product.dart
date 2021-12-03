import '/model/productModel.dart';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FireStoreProduct {
  final collectionProduct = FirebaseFirestore.instance.collection('Products');
  final storageRef = FirebaseStorage.instance;
  Future<void> addProductToFireStore(ProductModel prod) async {
    return await collectionProduct.add(prod.toJson());
  }

  Future<void> editProductfromFireStore(ProductModel prod) async {
    return await collectionProduct
        .doc(prod.id)
        .update(prod.toJson());
  }

  Future<void> deleteProductfromFireStore(ProductModel prod) async {
    return await collectionProduct.doc(prod.id).delete();
  }

  Future<String> uploadProdImage(
      Uint8List pic, String cat, ProductModel prod) async {
    String url;
    Reference reference = storageRef
        .ref()
        .child('products')
        .child('$cat')
        .child('${prod.classification['category']}')
        .child('${prod.classification['sub-cat']}')
        .child('${prod.prodName}.png');
    await reference.putData(pic).then((val) async {
      url = await val.ref.getDownloadURL();
    });
    return url;
  }
}
