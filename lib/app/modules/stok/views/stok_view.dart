import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project428app/app/modules/stok/views/stock_history_page.dart';
import 'package:project428app/app/modules/stok/views/stock_order_page.dart';
import 'package:project428app/app/modules/stok/views/stock_type_page.dart';
import 'package:project428app/app/widgets/text_header.dart';
import '../../../constants.dart';
import '../../../widgets/admin/admin_drawer.dart';
import '../controllers/stok_controller.dart';

class StokView extends GetView<StokController> {
  const StokView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
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
            IconButton(onPressed: () {}, icon: Icon(Icons.refresh)),
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
              controller.currentIndex.value = value;
            },
            tabs: controller.productTabs,
          ),
        ),
        drawer: AdminDrawer(context, kAdminMenuStok),
        body: TabBarView(
          controller: controller.tabC,

          children: <Widget>[
            StockOrderPage(controller: controller),
            StockHistoryPage(controller: controller),
            StockTypePage(controller: controller),
          ],
        ),

        floatingActionButton:
            controller.currentIndex.value == 2
                ? FloatingActionButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  tooltip: "Tambah Stok",
                  onPressed: () {
                    Get.toNamed("/tambah-stok");
                  },
                  child: const Icon(Icons.add),
                )
                : controller.currentIndex.value == 0
                ? FloatingActionButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  tooltip: "Tambah Pesanan",
                  onPressed: () {},
                  child: const Icon(Icons.add),
                )
                : null,
      ),
    );
  }
}
