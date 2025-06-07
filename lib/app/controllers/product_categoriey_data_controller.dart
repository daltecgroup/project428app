import 'package:get/get.dart';
import 'package:project428app/app/data/providers/product_category_provider.dart';

import '../data/models/product_category.dart';

class ProductCategorieyDataController extends GetxController {
  ProductCategoryProvider CategoryP = ProductCategoryProvider();

  RxList<ProductCategory> categories = <ProductCategory>[].obs;
  RxInt activeCatCount = 0.obs;
  RxInt innactiveCatCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    getProductCategories();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getProductCategories() async {
    categories.clear();
    activeCatCount.value = 0;
    innactiveCatCount.value = 0;

    try {
      await CategoryP.getProductCategories().then((res) {
        for (var e in res.body) {
          ProductCategory categoryItem = ProductCategory.fromJson(e);
          if (categoryItem.isActive) {
            activeCatCount++;
          } else {
            innactiveCatCount++;
          }
          categories.add(categoryItem);
        }
      });
    } catch (e) {
      print(e);
    }
  }
}
