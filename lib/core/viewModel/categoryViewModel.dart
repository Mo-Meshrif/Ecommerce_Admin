import '/core/service/fireStore_Category.dart';
import '/model/categoryModel.dart';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryViewModel extends GetxController {
  GlobalKey<FormState> addCategoryKey = GlobalKey<FormState>();
  Uint8List pickedImage;
  Color pickedColor = Colors.white;
  String catogoryTitle;
  int mainSubCounter = 1;
  Map<String, List<int>> subCounter = {};
  Map<String, List<String>> subCategories = {'s': []};
  ValueNotifier<bool> isAddCategory = ValueNotifier(false);
  getCatImage() async {
    Uint8List bytesFromPicker =
        await ImagePickerWeb.getImage(outputType: ImageType.bytes);
    if (bytesFromPicker != null) {
      pickedImage = bytesFromPicker;
    }
    update();
  }

  getPickedColor(Color color) {
    pickedColor = color;
    update();
  }

  changeMainCounter(String tag, int index) {
    if (tag == 'add') {
      if (subCategories['s'][index] != null) {
        mainSubCounter += 1;
      }
    } else {
      mainSubCounter -= 1;
      if (subCategories['s'].length > index) {
        subCategories['s'].removeLast();
      }
    }
    update();
  }

  changeSubCounter(int mainCatoIndex, String tag, int index) {
    if (tag == 'add') {
      if (subCategories['s' + mainCatoIndex.toString()][index] != null) {
        subCounter['s' + mainCatoIndex.toString()].add(1);
      }
    } else {
      subCounter['s' + mainCatoIndex.toString()].removeLast();
      if (subCategories['s' + mainCatoIndex.toString()].length > index) {
        subCategories['s' + mainCatoIndex.toString()].removeLast();
      }
    }
    update();
  }

  addMainSubCategory(String mainSub, int index) {
    if (mainSub == '') {
      subCategories['s'].removeAt(index);
    } else {
      if (subCategories['s'].length - 1 >= index) {
        subCategories['s'].removeAt(index);
      }
      subCategories['s'].insert(index, mainSub);
      subCategories['s' + index.toString()] = [];
      subCounter['s' + index.toString()] = [1];
    }
    update();
  }

  addSubCategory(int mainCatoIndex, String sub, int subCatoIndex) {
    if (sub == '') {
      subCategories['s' + mainCatoIndex.toString()].removeAt(subCatoIndex);
    } else {
      if (subCategories['s' + mainCatoIndex.toString()].length - 1 >=
          subCatoIndex) {
        subCategories['s' + mainCatoIndex.toString()].removeAt(subCatoIndex);
      }
      subCategories['s' + mainCatoIndex.toString()].insert(subCatoIndex, sub);
    }
    update();
  }

  addCategoryToFireStore(
      CategoryModel cato, Uint8List image, BuildContext ctx) {
    if (image != null) {
      isAddCategory.value = true;
      update();
      FireStoreCategory().uploadCatImage(image, cato.txt).then((imgUrl) {
        if (imgUrl != null) {
          FireStoreCategory()
              .addCategoryToFireStore(
            CategoryModel(
              createdAt: Timestamp.now(),
              txt: cato.txt,
              imgUrl: imgUrl,
              avatarCol: cato.avatarCol,
              subCat: cato.subCat,
            ),
          )
              .then((_) {
            Navigator.of(ctx).pop();
            restCatParameters();
          });
        }
      });
    } else {
      Get.snackbar('Error', 'Upload Category image ,please!',
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 5));
    }
  }

  restCatParameters() {
    catogoryTitle = null;
    subCategories = {'s': []};
    mainSubCounter = 1;
    subCounter = {};
    pickedColor = Colors.white;
    pickedImage = null;
    isAddCategory.value = false;
    update();
  }
}
