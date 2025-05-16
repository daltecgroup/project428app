import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../constants.dart';
import '../../../widgets/admin/admin_drawer.dart';
import '../../../widgets/text_header.dart';
import '../controllers/produk_controller.dart';
import 'product_category_page.dart';
import 'product_menu_page.dart';
import 'product_topping_page.dart';

class ProdukView extends GetView<ProdukController> {
  const ProdukView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextHeader(text: 'Produk'),
        centerTitle: true,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        actions: [
          IconButton(
            icon: Stack(
              children: <Widget>[
                Icon(Icons.notifications),
                // Positioned(top: 0.0, right: 0.0, child: Badge(label: Text("1"))),
              ],
            ),
            onPressed: () {
              Get.toNamed('/notifications');
            },
          ),
        ],
        bottom: TabBar(
          controller: controller.tabC,
          onTap: (value) {
            controller.pageIndex.value = value;
          },
          tabs: controller.productTabs,
        ),
      ),
      drawer: AdminDrawer(context, kAdminMenuProduk),
      body: TabBarView(
        controller: controller.tabC,
        children: <Widget>[
          ProductMenuPage(c: controller),
          ProductCategoryPage(c: controller),
          ProductToppingPage(c: controller),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.getSomething();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
