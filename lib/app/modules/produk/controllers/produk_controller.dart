import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProdukController extends GetxController
    with GetSingleTickerProviderStateMixin {
  RxInt pageIndex = 0.obs;

  final List<Tab> productTabs = <Tab>[
    Tab(text: 'Menu'),
    Tab(text: 'Kategori'),
    Tab(text: 'Topping'),
  ];

  late TabController tabC;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    tabC = TabController(vsync: this, length: productTabs.length);
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
  }

  void getSomething() {}
}
