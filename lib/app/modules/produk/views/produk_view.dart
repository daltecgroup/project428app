import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:project428app/app/modules/produk/views/widgets/add_category_page_view.dart';
import 'package:project428app/app/modules/produk/views/widgets/add_menu_page_view.dart';
import 'package:project428app/app/modules/produk/views/widgets/add_topping_page_view.dart';

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
          onTap: (value) {},
          tabs: controller.productTabs,
        ),
      ),
      drawer: AdminDrawer(context, kAdminMenuProduk),
      body: Obx(
        () =>
            controller.isLoading.value
                ? TabBarView(
                  controller: controller.tabC,
                  children: <Widget>[
                    Center(child: CircularProgressIndicator()),
                    Center(child: CircularProgressIndicator()),
                    Center(child: CircularProgressIndicator()),
                  ],
                )
                : TabBarView(
                  controller: controller.tabC,
                  children: <Widget>[
                    ProductMenuPage(c: controller),
                    ProductCategoryPage(c: controller),
                    ProductToppingPage(c: controller),
                  ],
                ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          switch (controller.tabC.index) {
            case 0:
              Get.to(() => AddMenuPageView(), preventDuplicates: false);
              break;
            case 1:
              Get.to(
                () => AddCategoryPageView(c: controller),
                preventDuplicates: false,
              );
              break;
            case 2:
              Get.to(() => AddToppingPageView(), preventDuplicates: false);
              break;
            default:
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
