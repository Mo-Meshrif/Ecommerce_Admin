import '/const.dart';
import '/core/service/fireStore_Category.dart';
import '/model/categoryModel.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:typed_data';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryViewModel extends GetxController {
  ValueNotifier isMobileAddEditCategory = ValueNotifier(false);
  GlobalKey<FormState> addCategoryKey = GlobalKey<FormState>();
  GlobalKey<FormState> mobileAddCategoryKey = GlobalKey<FormState>();
  GlobalKey<FormState> editCategoryKey = GlobalKey<FormState>();
  GlobalKey<FormState> mobileEditCategoryKey = GlobalKey<FormState>();
  String? oldImage;
  Uint8List? pickedImage;
  Color pickedColor = Colors.white;
  String? catogoryTitle;
  int mainSubCounter = 1;
  Map<String, List<int>> subCounter = {};
  Map<String, List<String>> subCategories = {'s': []};
  ValueNotifier<bool> loading = ValueNotifier(false);

  getMobileViewStatus(bool val) {
    isMobileAddEditCategory.value = val;
    update();
  }

  getOldCategoryData(CategoryModel oldCategory) {
    oldImage = oldCategory.imgUrl;
    catogoryTitle = oldCategory.txt;
    pickedColor = HexColor(oldCategory.avatarCol as String);
    subCategories = oldCategory.subCat!
        .map((key, value) => MapEntry(key, List.castFrom(value)));
    mainSubCounter = subCategories['s']!.length;
    for (int i = 0; i < subCategories['s']!.length; i++) {
      subCounter['s' + i.toString()] = subCategories['s' + i.toString()]!
          .map((e) => subCategories['s' + i.toString()]!.indexOf(e))
          .toList();
    }
    update();
  }

  getCatImage() async {
    Uint8List bytesFromPicker =
        await ImagePickerWeb.getImageAsBytes() as Uint8List;
    if (bytesFromPicker.isNotEmpty) {
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
      if (subCategories['s']![index] != '') {
        mainSubCounter += 1;
        subCategories['s']!.add('');
        subCounter.putIfAbsent('s' + (index + 1).toString(), () => [1]);
      }
    } else {
      mainSubCounter -= 1;
      if (subCategories['s']!.length > index) {
        subCategories['s']!.removeLast();
      }
    }
    update();
  }

  changeSubCounter(bool isEdit, int mainCatoIndex, String tag, int index) {
    if (tag == 'add') {
      subCounter['s' + mainCatoIndex.toString()]?.add(1);
      subCategories['s' + mainCatoIndex.toString()]?.add('');
    } else {
      subCounter['s' + mainCatoIndex.toString()]?.removeLast();
      if (subCategories.containsKey('s' + mainCatoIndex.toString())) {
        if (subCategories['s' + mainCatoIndex.toString()]!.length > index) {
          subCategories['s' + mainCatoIndex.toString()]?.removeAt(index);
        }
      }
    }
    update();
  }

  addMainSubCategory(bool isEdit, String mainSub, int index) {
    if (mainSub == '') {
      subCategories['s']!.removeAt(index);
      if (mainSubCounter != 1) {
        mainSubCounter -= 1;
        subCounter.update('s' + index.toString(), (value) => []);
      }
    } else {
      if (subCategories['s']!.length - 1 >= index) {
        subCategories['s']!.removeAt(index);
      }
      subCategories['s']!.insert(index, mainSub);
      if (!isEdit) {
        subCounter.putIfAbsent('s' + index.toString(), () => [1]);
      }
    }
    update();
  }

  addSubCategory(bool isEdit, int mainCatoIndex, String sub, int subCatoIndex) {
    List<int> currentCounter =
        subCounter['s' + mainCatoIndex.toString()] as List<int>;
    List<String>? currentCat = subCategories['s' + mainCatoIndex.toString()];
    if (sub == '') {
      currentCat!.removeAt(subCatoIndex);
      if (currentCounter.length > 1) {
        currentCounter.removeLast();
      } else {
        currentCat.add(sub);
      }
    } else {
      if (subCategories.containsKey('s' + mainCatoIndex.toString())) {
        if (currentCat!.length - 1 >= subCatoIndex) {
          currentCat.removeAt(subCatoIndex);
          currentCat.insert(subCatoIndex, sub);
        } else {
          currentCat.add(sub);
        }
      } else {
        currentCat = [sub];
      }
    }
    update();
  }

  addEditCategoryToFireStore(
      bool isAdd, CategoryModel cato, Uint8List? image, BuildContext ctx) {
    loading.value = true;
    update();
    if (isAdd) {
      if (image != null) {
        FireStoreCategory()
            .uploadCatImage(image, cato.txt as String)
            .then((String? imgUrl) {
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
    } else {
      if (image == null) {
        FireStoreCategory().editCategoryfromFireStore(cato).then((_) {
          Navigator.of(ctx).pop();
          restCatParameters();
        });
      } else {
        FireStoreCategory()
            .uploadCatImage(image, cato.txt as String)
            .then((imgUrl) {
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
            restCatParameters();
          });
        });
      }
    }
  }

  deleteCategory(CategoryModel cato, BuildContext ctx) {
    loading.value = true;
    update();
    FireStoreCategory().deleteCategoryfromFireStore(cato).then((_) {
      Navigator.of(ctx).popUntil(ModalRoute.withName(categoriesPageRoute));
      restCatParameters();
    });
  }

  restCatParameters() {
    catogoryTitle = null;
    subCategories = {'s': []};
    mainSubCounter = 1;
    subCounter = {};
    pickedColor = Colors.white;
    pickedImage = null;
    oldImage = null;
    loading.value = false;
    update();
  }
}
