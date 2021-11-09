import '/core/service/fireStore_Category.dart';
import '/model/categoryModel.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:typed_data';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryViewModel extends GetxController {
  GlobalKey<FormState> addCategoryKey = GlobalKey<FormState>();
  GlobalKey<FormState> editCategoryKey = GlobalKey<FormState>();
  Uint8List pickedImage;
  Color pickedColor = Colors.white;
  String catogoryTitle;
  int mainSubCounter = 1;
  Map<String, List<int>> subCounter = {};
  Map<String, List<String>> subCategories = {'s': []};
  ValueNotifier<bool> loading = ValueNotifier(false);

  getOldCategoryData(CategoryModel oldCategory) {
    catogoryTitle = oldCategory.txt;
    pickedColor = HexColor(oldCategory.avatarCol);
    subCategories = oldCategory.subCat
        .map((key, value) => MapEntry(key, List.castFrom(value)));
    mainSubCounter = subCategories['s'].length;
    for (int i = 0; i < subCategories['s'].length; i++) {
      subCounter['s' + i.toString()] = subCategories['s' + i.toString()]
          .map((e) => subCategories['s' + i.toString()].indexOf(e))
          .toList();
    }
    update();
  }

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

  changeMainCounter(bool isEdit, String tag, int index) {
    if (tag == 'add') {
      if (subCategories['s'][index] != null) {
        mainSubCounter += 1;
        if (isEdit) subCategories['s'].add('');
      }
    } else {
      mainSubCounter -= 1;
      if (subCategories['s'].length > index) {
        subCategories['s'].removeLast();
      }
    }
    update();
  }

  changeSubCounter(bool isEdit, int mainCatoIndex, String tag, int index) {
    if (tag == 'add') {
      if (subCategories['s' + mainCatoIndex.toString()][index] != null) {
        subCounter['s' + mainCatoIndex.toString()].add(1);
        if (isEdit) subCategories['s' + mainCatoIndex.toString()].add('');
      }
    } else {
      subCounter['s' + mainCatoIndex.toString()].removeLast();
      if (subCategories['s' + mainCatoIndex.toString()].length > index) {
        subCategories['s' + mainCatoIndex.toString()].removeLast();
      }
    }
    update();
  }

  addMainSubCategory(bool isEdit, String mainSub, int index) {
    if (mainSub == '') {
      subCategories['s'].removeAt(index);
      if (isEdit) subCategories['s'].insert(index, mainSub);
    } else {
      if (subCategories['s'].length - 1 >= index) {
        subCategories['s'].removeAt(index);
      }
      subCategories['s'].insert(index, mainSub);
      if (!isEdit) {
        subCategories['s' + index.toString()] = [];
        subCounter['s' + index.toString()] = [1];
      }
    }
    update();
  }

  addSubCategory(bool isEdit, int mainCatoIndex, String sub, int subCatoIndex) {
    if (sub == '') {
      subCategories['s' + mainCatoIndex.toString()].removeAt(subCatoIndex);
      if (isEdit)
        subCategories['s' + mainCatoIndex.toString()].insert(subCatoIndex, sub);
    } else {
      if (subCategories['s' + mainCatoIndex.toString()].length - 1 >=
          subCatoIndex) {
        subCategories['s' + mainCatoIndex.toString()].removeAt(subCatoIndex);
      }
      subCategories['s' + mainCatoIndex.toString()].insert(subCatoIndex, sub);
    }
    update();
  }

  addEditCategoryToFireStore(
      bool isAdd, CategoryModel cato, Uint8List image, BuildContext ctx) {
    loading.value = true;
    update();
    if (isAdd) {
      if (image != null) {
        FireStoreCategory().uploadCatImage(image, cato.txt).then((imgUrl) {
          if (imgUrl != null) {
            FireStoreCategory()
                .addCategoryToFireStore(
              CategoryModel(
                createdAt: cato.createdAt,
                txt: cato.txt,
                imgUrl: imgUrl,
                avatarCol: cato.avatarCol,
                subCat: cato.subCat,
              ),
            )
                .then((_) {
              Navigator.of(ctx).pop();
              restCatParameters(isEditDismiss: false);
            });
          }
        });
      } else {
        Get.snackbar('Error', 'Upload Category image ,please!',
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP,
            duration: Duration(seconds: 5));
      }
    } else {
      if (image == null) {
        FireStoreCategory().editCategoryfromFireStore(cato).then((_) {
          Navigator.of(ctx).pop();
          restCatParameters(isEditDismiss: false);
        });
      } else {
        FireStoreCategory().uploadCatImage(image, cato.txt).then((imgUrl) {
          FireStoreCategory()
              .editCategoryfromFireStore(
            CategoryModel(
              txt: cato.txt,
              createdAt: cato.createdAt,
              imgUrl: imgUrl,
              avatarCol: cato.avatarCol,
              subCat: cato.subCat,
            ),
          )
              .then((_) {
            Navigator.of(ctx).pop();
            restCatParameters(isEditDismiss: false);
          });
        });
      }
    }
  }

  deleteCategory(CategoryModel cato, BuildContext ctx) {
    loading.value = true;
    update();
    FireStoreCategory().deleteCategoryfromFireStore(cato).then((_) {
      Navigator.of(ctx).popUntil(ModalRoute.withName('/'));
      restCatParameters(isEditDismiss: false);
    });
  }

  restCatParameters({@required bool isEditDismiss}) {
    if (isEditDismiss) {
      pickedImage = null;
    } else {
      catogoryTitle = null;
      subCategories = {'s': []};
      mainSubCounter = 1;
      subCounter = {};
      pickedColor = Colors.white;
      pickedImage = null;
      loading.value = false;
    }
    update();
  }
}
