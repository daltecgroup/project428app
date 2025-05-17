import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project428app/app/constants.dart';
import 'package:project428app/app/data/product_category_provider.dart';
import 'package:project428app/app/models/product_category.dart';

class ProdukController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabC;
  late TextEditingController categoryNameC;

  ProductCategoryProvider ProductCategoryP = ProductCategoryProvider();

  // loading indicator
  RxBool isLoading = false.obs;

  // product category list
  RxList<ProductCategory> categories = <ProductCategory>[].obs;
  RxInt activeCatCount = 0.obs;
  RxInt innactiveCatCount = 0.obs;

  // category error
  RxBool isCategoryNameError = false.obs;
  RxString categoryNameErrorText = 'Nama Kategori tidak boleh kosong'.obs;

  final List<Tab> productTabs = <Tab>[
    Tab(text: 'Menu'),
    Tab(text: 'Kategori'),
    Tab(text: 'Topping'),
  ];

  @override
  void onInit() {
    super.onInit();
    tabC = TabController(vsync: this, length: productTabs.length);
    categoryNameC = TextEditingController();
  }

  @override
  void onReady() {
    tabC.addListener(() {
      print(tabC.index);
    });
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    tabC.removeListener(() {
      print('listener removed');
    });
    tabC.dispose();
    categoryNameC.dispose();
  }

  void checkCategoryName() {
    if (categoryNameC.text.isEmpty) {
      isCategoryNameError.value = true;
      categoryNameErrorText.value = 'Nama Kategori tidak boleh kosong';
    }
  }

  void createProductCategory() {
    checkCategoryName();
    if (isCategoryNameError.isFalse) {
      try {
        ProductCategoryP.createProductCategory(
          categoryNameC.text.trim().capitalize!,
        ).then((res) {
          if (res.statusCode == 201) {
            getProductCategories();
            Get.back();
          } else {
            categoryNameErrorText.value = res.body['message'];
            isCategoryNameError.value = true;
          }
        });
      } catch (e) {
        print(e);
      }
    }
  }

  Future<void> getProductCategories() async {
    categories.clear();
    activeCatCount.value = 0;
    activeCatCount.value = 0;
    isLoading.value = true;

    try {
      await ProductCategoryP.getProductCategories().then((res) {
        for (var e in res.body) {
          ProductCategory categoryItem = ProductCategory.fromJson(e);
          if (categoryItem.isActive) {
            activeCatCount++;
          } else {
            innactiveCatCount++;
          }
          categories.add(categoryItem);
        }
        isLoading.value = false;
      });
    } catch (e) {
      print(e);
      isLoading.value = false;
    }
  }

  Future<void> setProductCategoryStatus(
    bool section,
    ProductCategory category,
  ) async {
    isLoading.value = true;
    if (section) {
      try {
        await ProductCategoryP.deactivateProductCategory(category.id).then((
          res,
        ) {
          getProductCategories();
          isLoading.value = false;
        });
      } catch (e) {
        print(e);
      }
    } else {
      try {
        await ProductCategoryP.reactivateProductCategory(category.id).then((
          res,
        ) {
          getProductCategories();
          isLoading.value = false;
        });
      } catch (e) {
        print(e);
      }
    }
  }

  updateProductCategoryName(String id, String name) {
    TextEditingController newCategoryNameC = TextEditingController();
    newCategoryNameC.text = name;
    Get.defaultDialog(
      title: "Ubah Kategori",
      titleStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      radius: 8,
      content: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
              controller: newCategoryNameC,
              textCapitalization: TextCapitalization.characters,
              decoration: InputDecoration(
                label: Text('Nama Baru'),
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
      confirm: TextButton(
        onPressed: () async {
          isLoading.value = true;
          if (newCategoryNameC.text.isNotEmpty) {
            if (newCategoryNameC.text.toLowerCase() == name.toLowerCase()) {
            } else {
              await ProductCategoryP.updateProductCategory(
                id,
                newCategoryNameC.text.trim().toLowerCase().capitalize!,
              ).then((res) {
                if (res.statusCode == 200) {
                  getProductCategories();
                } else {
                  Get.snackbar(kTitleFailed, res.body['message']);
                }
              });
            }
          }
          isLoading.value = false;
          newCategoryNameC.dispose();
          Get.back();
        },
        child: Text("Simpan"),
      ),
      cancel: TextButton(
        onPressed: () {
          newCategoryNameC.dispose();
          Get.back();
        },
        child: Text("Batal"),
      ),
    );
  }

  Future<void> deleteProductCategory(String id, String name) async {
    Get.defaultDialog(
      title: "Konfirmasi",
      content: Text("Yakin menghapus $name?"),
      confirm: TextButton(
        onPressed: () async {
          await ProductCategoryP.deleteProductCategory(id).then((res) {
            getProductCategories();
            Get.back();
          });
        },
        child: Text("Yakin"),
      ),
      cancel: TextButton(
        onPressed: () {
          Get.back();
        },
        child: Text("Batal"),
      ),
    );
  }
}
