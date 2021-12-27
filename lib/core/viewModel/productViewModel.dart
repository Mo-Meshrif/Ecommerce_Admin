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
  onInit() {
    getCategories();
    super.onInit();
  }

  //add product
  HomeViewModel homeViewModel = Get.find();
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
  getProdImage() async {
    Uint8List bytesFromPicker =
        await ImagePickerWeb.getImageAsBytes();
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
          _categories.add(CategoryModel.fromJson(value[i].id, value[i].data()));
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
    update([0]);
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
    isLoading.value = false;
    update();
  }

//edit products
  ValueNotifier reLoading = ValueNotifier(false);
  List<String> headers = [
    'Image',
    'Name',
    'Category',
    'Season',
    'Brand',
    'Mateial',
    'Sku',
    'Color(s)',
    'Size(s)',
    'Trending'
  ];
  Uint8List rePickedImage;
  String reCat,
      reMainSubCat,
      reSubCat,
      reSeason,
      reProdName,
      reBrandName,
      reMaterialType,
      reProdCondition,
      reProdSku,
      reProdPrice;
  bool reTrend;
  List<String> reColors = [];
  List<String> reSelectedColors = [];
  List<String> reSelectedSizes = [];
  int reCatIndex, reMainSubIndex;
  CategoryModel currentCato;

  getReParameters(ProductModel prod) {
    CategoryModel catModel = _categories
        .firstWhere((cat) => cat.id == prod.classification['cat-id']);
    reCat = catModel.txt;
    reMainSubCat = prod.classification['category'];
    reSubCat = prod.classification['sub-cat'];
    reSeason = prod.season;
    reProdName = prod.prodName;
    reBrandName = prod.brand;
    reMaterialType = prod.material;
    reProdCondition = prod.condition;
    reProdSku = prod.sku;
    reProdPrice = prod.price;
    reTrend = prod.trending;
    reColors = reSelectedColors = prod.color.cast<String>();
    reSelectedSizes = prod.size.cast<String>();
    currentCato = catModel;
    reCatIndex = _categories.indexOf(currentCato);
    reMainSubIndex = (currentCato.subCat['s'] as List)
        .indexOf(prod.classification['category']);
    update([3]);
  }

  reGetProdImage() async {
    Uint8List bytesFromPicker =
        await ImagePickerWeb.getImageAsBytes();
    if (bytesFromPicker != null) {
      rePickedImage = bytesFromPicker;
    }
    update([3]);
  }

  getCurrentCato(int index) {
    currentCato = _categories[index];
    update([3]);
  }

  getReSelectedCat(val) {
    reCat = val;
    reMainSubCat = 'Select One';
    reSubCat = 'Select One';
    update([3]);
  }

  getReSelectedMainSubCat(val) {
    reMainSubCat = val;
    reSubCat = 'Select One';
    update([3]);
  }

  getReSelectedSubCat(val) {
    reSubCat = val;
    update([3]);
  }

  getReSelectedSesson(val) {
    reSeason = val;
    update([3]);
  }

  getReTrendState(val) {
    reTrend = val;
    update([3]);
  }

  reAddColor(Color color) {
    String hexColor = '#' + color.value.toRadixString(16);
    int index = reColors.indexWhere((element) => element == hexColor);
    if (index >= 0) {
      reColors.removeAt(index);
    }
    reColors.add(hexColor);
    update([4]);
  }

  reGetSelectedColors(color) {
    int index = reSelectedColors.indexWhere((element) => element == color);
    if (index >= 0) {
      reSelectedColors.removeAt(index);
    } else {
      reSelectedColors.add(color);
    }
    update([4]);
  }

  reGetSelectedSizes(bool selected, String val) {
    if (selected) {
      reSelectedSizes.add(val);
    } else {
      reSelectedSizes.remove(val);
    }
    update([4]);
  }

  editProd(Uint8List image, ProductModel prod, BuildContext ctx) {
    reLoading.value = true;
    update([3]);
    if (image != null) {
      FireStoreProduct()
          .uploadProdImage(image, currentCato.txt, prod)
          .then((imgUrl) {
        if (imgUrl != null) {
          FireStoreProduct()
              .editProductfromFireStore(ProductModel(
            id: prod.id,
            classification: prod.classification,
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
            Navigator.of(ctx).pop();
            restReProdParameters();
          });
        }
      });
    } else {
      FireStoreProduct().editProductfromFireStore(prod).then((_) {
        Navigator.of(ctx).pop();
        restReProdParameters();
      });
    }
  }

  deleteProd(ProductModel prod, BuildContext ctx) {
    FireStoreProduct()
        .deleteProductfromFireStore(currentCato.txt, prod)
        .then((_) => Navigator.of(ctx).popUntil(ModalRoute.withName('/')));
  }

  restReProdParameters() {
    rePickedImage = null;
    reLoading.value = false;
    update([3]);
  }
}
