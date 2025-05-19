import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:project428app/app/modules/detail_stok/views/riwayat_stok_item.dart';
import 'package:project428app/app/style.dart';
import 'package:project428app/app/widgets/status_sign.dart';

import '../../../widgets/text_header.dart';
import '../controllers/detail_stok_controller.dart';

class DetailStokView extends GetView<DetailStokController> {
  const DetailStokView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(
            '${controller.stock.value.stockId} - ${controller.stock.value.name}',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () {
            // Save action
            Get.offNamed('/stok');
          },
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await controller.StockC.deleteStock(
                controller.stock.value.stockId,
                controller.stock.value.name,
              );
            },
            icon: Icon(Icons.delete, color: Colors.red[900]),
          ),
        ],
      ),
      body: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40),
            Card(
              color: Colors.white,
              margin: EdgeInsets.symmetric(horizontal: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextTitle(text: 'Kode & Nama'),
                        TextTitle(text: 'Diperbaharui'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${controller.stock.value.stockId} - ${controller.stock.value.name}',
                        ),
                        Text(controller.stock.value.getLastUpdateTime()),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextTitle(text: 'Status'),
                        TextTitle(text: 'Harga Terkini'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        StatusSign(
                          status: controller.stock.value.isActive,
                          size: 16,
                        ),
                        Text(controller.stock.value.getPriceWithUnit()),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              controller.updateStock();
                            },
                            style: PrimaryButtonStyle(Colors.blue),
                            child: Text('Ubah Data'),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              if (controller.stock.value.isActive) {
                                // nonaktifkan
                                controller.deactiveStock();
                              } else {
                                // aktifkan
                                controller.reactiveStock();
                              }
                            },
                            style: PrimaryButtonStyle(
                              controller.stock.value.isActive
                                  ? Colors.red[400]!
                                  : Colors.blue,
                            ),
                            child:
                                controller.stock.value.isActive
                                    ? Text('Nonaktifkan')
                                    : Text('Aktifkan'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 15,
                right: 15,
                top: 10,
                bottom: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextTitle(text: "Riwayat Perubahan"),
                  TextButton(
                    onPressed: () {
                      controller.getStockHistory();
                      controller.getStock();
                    },
                    child: Text("Refresh"),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 15),
                child: ListView(
                  children: List.generate(controller.stockHistory.length, (
                    index,
                  ) {
                    return RiwayatStokItem(
                      controller.stockHistory[index],
                      index == controller.stockHistory.length - 1,
                      index == 0,
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
