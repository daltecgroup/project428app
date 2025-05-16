import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:project428app/app/modules/stok/views/stok_item.dart';
import 'package:project428app/app/widgets/text_header.dart';

import '../../../constants.dart';
import '../../../widgets/admin/admin_appbar.dart';
import '../../../widgets/admin/admin_drawer.dart';
import '../controllers/stok_controller.dart';

class StokView extends GetView<StokController> {
  const StokView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AdminAppBar(context, "Stok"),
      drawer: AdminDrawer(context, kAdminMenuStok),
      body: Obx(
        () =>
            controller.stocks.isEmpty
                ? Center(child: Text("Loading..."))
                : ListView(
                  padding: EdgeInsets.only(top: 20),
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 12, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextTitle(
                            text: "Stok Aktif (${controller.activeCount} item)",
                          ),
                          kEnv == 'dev'
                              ? TextButton(
                                onPressed: () {
                                  controller.getStocks();
                                },
                                child: Text("Refresh"),
                              )
                              : SizedBox(),
                        ],
                      ),
                    ),
                    Column(
                      children: List.generate(controller.stocks.length, (
                        index,
                      ) {
                        return controller.stocks[index].isActive
                            ? StokItem(controller.stocks[index])
                            : SizedBox();
                      }),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 12, bottom: 10, top: 20),
                      child: TextTitle(
                        text:
                            "Stok Nonaktif (${controller.innactiveCount} item)",
                      ),
                    ),
                    Column(
                      children: List.generate(controller.stocks.length, (
                        index,
                      ) {
                        return !controller.stocks[index].isActive
                            ? StokItem(controller.stocks[index])
                            : SizedBox();
                      }),
                    ),
                    SizedBox(height: 100),
                  ],
                ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Tambah Stok",
        onPressed: () {
          Get.toNamed("/tambah-stok");
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
