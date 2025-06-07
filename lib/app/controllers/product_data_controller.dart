import 'package:get/get.dart';
import 'package:project428app/app/data/providers/product_provider.dart';
import 'package:project428app/app/data/models/product.dart';

class ProductDataController extends GetxController {
  ProductProvider ProductP = ProductProvider();
  RxList<Product> products = <Product>[].obs;
  RxInt activeProdCount = 0.obs;
  RxInt innactiveProdCount = 0.obs;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    getProducts();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // product functions
  Future<void> getProducts() async {
    products.clear();
    activeProdCount.value = 0;
    innactiveProdCount.value = 0;
    try {
      await ProductP.getProducts().then((res) {
        for (var e in res.body) {
          Product productItem = Product.fromJson(e);
          if (productItem.isActive) {
            activeProdCount++;
          } else {
            innactiveProdCount++;
          }
          products.add(productItem);
        }
      });
    } catch (e) {
      print(e);
    }
    print(products.length);
  }
}
