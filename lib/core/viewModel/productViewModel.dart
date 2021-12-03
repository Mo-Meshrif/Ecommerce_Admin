import 'dart:typed_data';
import '/core/service/fireStore_Category.dart';
import '/core/service/fireStore_product.dart';
import '/core/viewModel/homeViewModel.dart';
import '/model/categoryModel.dart';
import '/model/productModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker_web/image_picker_web.dart';

class ProductViewModel extends GetxController {
  HomeViewModel homeViewModel=Get.find();
  ValueNotifier isLoading = ValueNotifier(false);
  Uint8List pickedImage;
  List<CategoryModel> _categories = [];
  List<CategoryModel> get categories => _categories;
  String cat = 'Select Category',
      mainSubCat = 'Select Main Sub-Category',
      subCat = 'Select Sub-Category',
      season = 'Select Product Season',
      prodName,
      brandName,
      materialType,
      prodCondition,
      prodSku,
      prodPrice;
  int catIndex, mainSubIndex;
  bool isTrend = false;
  List<String> colors = ['#ffe91e63', '#ff000000'];
  List<String> selectedColors = [];
  Map<String, List<String>> sizes = {
    'Apparel': ['S', 'M', 'L', 'XL'],
    'Shoes': ['4.5', '5', '6.5', '7']
  };
  List<String> selectedSizes = [];

  onInit() {
    getCategories();
    super.onInit();
  }

  getProdImage() async {
    Uint8List bytesFromPicker =
        await ImagePickerWeb.getImage(outputType: ImageType.bytes);
    if (bytesFromPicker != null) {
      pickedImage = bytesFromPicker;
    }
    update();
  }

  getCategories() {
    isLoading.value = true;
    try {
      FireStoreCategory().getCategoriesFromFireStore().then((value) {
        for (int i = 0; i < value.length; i++) {
          _categories.add(CategoryModel.fromJson(value[i].data()));
        }
        isLoading.value = false;
        update();
      });
    } catch (e) {
      print(e);
    }
  }

  getSelectedCat(val) {
    cat = val;
    mainSubCat = 'Select Main Sub-Category';
    subCat = 'Select Sub-Category';
    update();
  }

  getSelectedMainSubCat(val) {
    mainSubCat = val;
    subCat = 'Select Sub-Category';
    update();
  }

  getSelectedSubCat(val) {
    subCat = val;
    update();
  }

  getSelectedSesson(val) {
    season = val;
    update();
  }

  getTrendState(val) {
    isTrend = val;
    update();
  }

  addColor(Color color) {
    String hexColor = '#' + color.value.toRadixString(16);
    int index = colors.indexWhere((element) => element == hexColor);
    if (index >= 0) {
      colors.removeAt(index);
    }
    colors.add(hexColor);
    update([1]);
  }

  getSelectedColors(color) {
    int index = selectedColors.indexWhere((element) => element == color);
    if (index >= 0) {
      selectedColors.removeAt(index);
    } else {
      selectedColors.add(color);
    }
    update([1]);
  }

  getSelectedSizes(bool selected, String val) {
    if (selected) {
      selectedSizes.add(val);
    } else {
      selectedSizes.remove(val);
    }
    update([2]);
  }

  addProduct(ProductModel prod, String cat, Uint8List image) {
    isLoading.value = true;
    update();
    if (image != null) {
      FireStoreProduct().uploadProdImage(image, cat, prod).then((imgUrl) {
        if (imgUrl != null) {
          FireStoreProduct()
              .addProductToFireStore(ProductModel(
                classification: prod.classification,
                vendorId: prod.vendorId,
                prodName: prod.prodName,
                imgUrl: imgUrl,
                season: prod.season,
                color: prod.color,
                size: prod.size,
                price: prod.price,
                createdAt: prod.createdAt,
                brand: prod.brand,
                condition: prod.condition,
                sku: prod.sku,
                material: prod.material,
                trending: prod.trending,
              ))
              .then((_) {
                restProdParameters();
              });
        }
      });
    } else {
      Get.snackbar('Error', 'Upload Category image ,please!',
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 5));
    }
    FireStoreProduct().addProductToFireStore(prod);
  }

  restProdParameters() {
    pickedImage = null;
    cat = 'Select Category';
    mainSubCat = 'Select Main Sub-Category';
    subCat = 'Select Sub-Category';
    season = 'Select Product Season';
    prodName =
        brandName = materialType = prodCondition = prodSku = prodPrice = null;
    catIndex = mainSubIndex = null;
    isTrend = false;
    colors = ['#ffe91e63', '#ff000000'];
    selectedColors = [];
    selectedSizes = [];
    isLoading.value=false;
    update();
  }
}
