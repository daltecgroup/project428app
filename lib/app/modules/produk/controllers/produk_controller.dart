import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:project428app/app/core/constants/constants.dart';
import 'package:project428app/app/controllers/image_picker_controller.dart';
import 'package:project428app/app/data/providers/product_category_provider.dart';
import 'package:project428app/app/data/providers/product_provider.dart';
import 'package:project428app/app/data/models/product.dart';
import 'package:project428app/app/data/models/product_category.dart';

import '../../../data/providers/stock_provider.dart';
import '../../../data/models/stock.dart';
import '../../../style.dart';
import '../../../shared/widgets/text_header.dart';

class ProdukController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabC;

  ProductCategoryProvider ProductCategoryP = ProductCategoryProvider();
  ProductProvider ProductP = ProductProvider();
  ImagePickerController imagePickerC = Get.put(ImagePickerController());

  StockProvider StockP = StockProvider();
  RxList<Stock> stocks = <Stock>[].obs;

  // add category text editing controller
  late TextEditingController categoryNameC;

  // add menu text editing controller
  late TextEditingController productCode;
  late TextEditingController productName;
  late TextEditingController productPrice;
  late TextEditingController productDiscount;
  late TextEditingController productDescription;

  // add menu after discount price
  RxDouble afterDiscountPrice = 0.0.obs;

  RxBool addMenuStatus = true.obs;
  RxString addMenuCategoriId = ''.obs;
  RxList addMenuIngredients = [].obs;

  // loading indicator
  RxBool isLoading = false.obs;

  // add category error
  RxBool isCategoryNameError = false.obs;
  RxString categoryNameErrorText = 'Nama Kategori tidak boleh kosong'.obs;

  // add menu error
  RxBool isAddMenuCodeError = false.obs;
  RxBool isAddMenuNameError = false.obs;
  RxBool isAddMenuPriceError = false.obs;
  RxBool isAddMenuDiscountError = false.obs;
  RxBool isAddMenuIngredientsError = false.obs;
  RxBool isAddMenuImageError = false.obs;
  RxString addMenuCodeErrorText = 'Kode harus diisi'.obs;

  // product category list
  RxList<ProductCategory> categories = <ProductCategory>[].obs;
  RxInt activeCatCount = 0.obs;
  RxInt innactiveCatCount = 0.obs;

  // product list
  RxList<Product> products = <Product>[].obs;
  RxInt activeProdCount = 0.obs;
  RxInt innactiveProdCount = 0.obs;

  final List<Tab> productTabs = <Tab>[
    Tab(text: 'Menu'),
    Tab(text: 'Kategori'),
    Tab(text: 'Topping'),
  ];

  @override
  void onInit() async {
    super.onInit();
    tabC = TabController(vsync: this, length: productTabs.length);
    productCode = TextEditingController();
    productName = TextEditingController();
    productPrice = TextEditingController();
    productDiscount = TextEditingController();
    productDescription = TextEditingController();
    categoryNameC = TextEditingController();
    getStocks();
    await getProductCategories();
    await getProducts();
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
    productName.dispose();
    productPrice.dispose();
    productDiscount.dispose();
    productDescription.dispose();
    categoryNameC.dispose();
    imagePickerC.dispose();
  }

  void getStocks() async {
    stocks.clear();

    try {
      await StockP.getStocks().then((res) {
        for (var e in res.body) {
          Stock stockItem = Stock.fromJson(e);
          stocks.add(stockItem);
        }
      });
    } catch (e) {
      print(e);
    }
  }

  // product functions
  Future<void> getProducts() async {
    products.clear();
    activeProdCount.value = 0;
    innactiveProdCount.value = 0;
    isLoading.value = true;

    try {
      await ProductP.getProducts().then((res) {
        print(res.body[0]);
        for (var e in res.body) {
          Product productItem = Product.fromJson(e);
          if (productItem.isActive) {
            activeProdCount++;
          } else {
            innactiveProdCount++;
          }
          products.add(productItem);
        }
        isLoading.value = false;
      });
    } catch (e) {
      print(e);
      isLoading.value = false;
    }
    print(products.length);
  }

  void setAfterDiscountPrice() {
    if (productPrice.text.isNotEmpty && productDiscount.text.isNotEmpty) {
      double price = double.parse(productPrice.text);
      double discount = double.parse(productDiscount.text);
      afterDiscountPrice.value = price - (price * (discount / 100));
    } else {
      afterDiscountPrice.value = 0.0;
    }
  }

  void resetAddMenuField() {
    isAddMenuCodeError = false.obs;
    isAddMenuNameError = false.obs;
    isAddMenuPriceError = false.obs;
    isAddMenuImageError = false.obs;
    isAddMenuDiscountError = false.obs;
    isAddMenuIngredientsError = false.obs;
    addMenuCodeErrorText = 'Kode harus diisi'.obs;

    productCode.clear();
    productName.clear();
    productPrice.clear();
    productDiscount.clear();
    productDescription.clear();

    addMenuStatus.value = true;
    // addMenuCategoriId.value = '';
    addMenuIngredients.clear();

    afterDiscountPrice.value = 0;

    imagePickerC.selectedImage.value = null;
  }

  void checkAddMenuError() {
    if (productCode.text.isEmpty) {
      isAddMenuCodeError.value = true;
      addMenuCodeErrorText.value = 'Kode harus diisi';
    }

    if (productName.text.isEmpty) {
      isAddMenuNameError.value = true;
    }

    if (productPrice.text.isEmpty) {
      isAddMenuPriceError.value = true;
    }

    if (addMenuIngredients.isEmpty) {
      isAddMenuIngredientsError.value = true;
    }

    if (imagePickerC.selectedImage.value == null) {
      isAddMenuImageError.value = true;
    }
  }

  void addIngredients() {
    TextEditingController qtyC = TextEditingController();
    var list =
        stocks.where((e) {
          if (e.isActive == false) {
            return false;
          } else {
            if (addMenuIngredients.isEmpty) {
              return true;
            } else {
              for (var el in addMenuIngredients) {
                if (e.id == el['stock']) {
                  return false;
                }
              }
              return true;
            }
          }
        }).toList();
    if (list.isEmpty) {
      Get.defaultDialog(
        title: 'Peringatan',
        titleStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        content: Text('Semua bahan telah ditambahkan'),
        radius: 12,
      );
    } else {
      Rx<Stock> selected = list.first.obs;
      Get.defaultDialog(
        backgroundColor: Colors.white,
        title: "Tambah Bahan",
        titleStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        radius: 8,
        content: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextTitle(text: 'Bahan'),
              SizedBox(height: 5),
              Material(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: DropdownButtonFormField<String>(
                  value: selected.value.id,
                  decoration: TextFieldDecoration1(),
                  items: [
                    ...List.generate(
                      list.length,
                      (index) => DropdownMenuItem(
                        value: list[index].id,
                        child: Text(list[index].name),
                      ),
                    ),
                  ],
                  onChanged: (value) {
                    selected.value = stocks.firstWhere((e) => e.id == value);
                  },
                ),
              ),
              SizedBox(height: 10),
              Obx(
                () => TextTitle(
                  text:
                      'Komposisi (${stocks.firstWhere((e) => e.id == selected.value.id).unit == 'weight'
                          ? 'gram'
                          : stocks.firstWhere((e) => e.id == selected.value.id).unit == 'volume'
                          ? 'mililiter'
                          : 'pcs'})',
                ),
              ),
              SizedBox(height: 5),
              Material(
                elevation: 2,
                borderRadius: BorderRadius.circular(8),
                child: TextField(
                  controller: qtyC,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                  ],
                  onChanged: (value) {
                    if (int.parse(value) > 9999) {
                      Get.defaultDialog(
                        title: 'Peringatan',
                        titleStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                        content: Text('Kuantitas terlalu besar'),
                        radius: 12,
                      );
                    }
                  },
                  decoration: TextFieldDecoration1(),
                ),
              ),
            ],
          ),
        ),
        confirm: TextButton(
          onPressed: () async {
            if (qtyC.text.isNotEmpty) {
              addMenuIngredients.add({
                'stock': selected.value.id,
                'name': selected.value.name,
                'qty': int.parse(qtyC.text),
                'unit': selected.value.unit,
              });
              if (addMenuIngredients.isNotEmpty) {
                isAddMenuIngredientsError.value = false;
              }
              qtyC.dispose();
              Get.back();
            } else {
              Get.back();
              if (addMenuIngredients.isNotEmpty) {
                isAddMenuIngredientsError.value = false;
              }
            }
          },
          child: Text("Simpan"),
        ),
        cancel: TextButton(
          onPressed: () {
            qtyC.dispose();
            Get.back();
          },
          child: Text("Batal"),
        ),
      );
    }
  }

  Future<void> createProduct() async {
    checkAddMenuError();
    if (isAddMenuCodeError.isFalse &&
        isAddMenuNameError.isFalse &&
        isAddMenuPriceError.isFalse &&
        isAddMenuDiscountError.isFalse &&
        addMenuIngredients.isNotEmpty &&
        // addMenuCategoriId.isNotEmpty &&
        imagePickerC.selectedImage.value != null) {
      Get.defaultDialog(
        title: 'Sedang menyimpan...',
        titleStyle: TextStyle(fontSize: 16),
        content: LinearProgressIndicator(),
        radius: 12,
      );

      print(addMenuCategoriId.value);

      await ProductP.createProduct(
        imagePickerC.selectedImage.value!,
        productCode.text.trim().toUpperCase(),
        true,
        productName.text.trim().capitalize!,
        int.parse(productPrice.text.trim()),
        productDiscount.text.isEmpty ? 0 : int.parse(productDiscount.text),
        addMenuCategoriId.value,
        productDescription.text.isNotEmpty
            ? productDescription.text.trim()
            : '',
        // cast addMenuIngredients to List json
        addMenuIngredients.map((e) {
          return {'stock': e['stock'], 'qty': e['qty']};
        }).toList(),
      ).then((res) {
        switch (res.statusCode) {
          case 201:
            getProducts().then((res) => Get.back());
            resetAddMenuField();
            Get.back();
            break;
          case 400:
            Get.back();
            Get.defaultDialog(
              title: 'Penyimpanan Gagal',
              titleStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              content: Text(res.body['message']),
              radius: 12,
            );
            break;
          default:
            Get.back();
            Get.defaultDialog(
              title: 'Penyimpanan Gagal',
              titleStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              content: Text(res.body['message']),
              radius: 12,
            );
        }
      });
    } else {
      Get.defaultDialog(
        title: 'Penyimpanan Gagal',
        titleStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        content: Text('Harap isi semua kolom yang diperlukan'),
        radius: 12,
      );
    }
  }

  // product category functions
  void checkCategoryName() {
    if (categoryNameC.text.isEmpty) {
      isCategoryNameError.value = true;
      categoryNameErrorText.value = 'Nama Kategori tidak boleh kosong';
    }
  }

  Future<void> getProductCategories() async {
    categories.clear();
    activeCatCount.value = 0;
    innactiveCatCount.value = 0;
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

  Future<void> deleteProduct(String code, String name) async {
    Get.defaultDialog(
      title: "Konfirmasi",
      content: Text("Yakin menghapus $name?"),
      confirm: TextButton(
        onPressed: () async {
          await ProductP.deleteProduct(code).then((res) {
            getProducts();
            Get.back();
            Get.toNamed('/produk');
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

  void updateProductCategoryName(String id, String name) {
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
