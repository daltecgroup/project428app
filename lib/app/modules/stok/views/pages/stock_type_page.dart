import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project428app/app/modules/stok/controllers/stok_controller.dart';
import 'package:project428app/app/widgets/text_header.dart';

import '../widgets/stock_item_widget.dart';

class StockTypePage extends StatelessWidget {
  const StockTypePage({super.key, required this.controller});

  final StokController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () =>
          controller.StockS.isLoading.value
              ? Center(child: CircularProgressIndicator())
              : controller.StockS.stocks.isEmpty
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextTitle(text: 'Stok Kosong'),
                    SizedBox(height: 10),
                    Text(
                      textAlign: TextAlign.center,
                      'Tekan tombol "+" untuk menambahkan\njenis stok',
                    ),
                  ],
                ),
              )
              : ListView(
                padding: EdgeInsets.only(top: 20, left: 15, right: 15),
                children: [
                  if (controller.StockS.getStockList(true).isNotEmpty)
                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextTitle(
                            text:
                                "Stok Aktif (${controller.StockS.activeCount} item)",
                          ),
                        ],
                      ),
                    ),
                  if (controller.StockS.getStockList(true).isNotEmpty)
                    Column(
                      children: List.generate(
                        controller.StockS.getStockList(true).length,
                        (index) {
                          return StockItemWidget(
                            controller.StockS.getStockList(true)[index],
                          );
                        },
                      ),
                    ),
                  if (controller.StockS.getStockList(false).isNotEmpty)
                    Padding(
                      padding: EdgeInsets.only(bottom: 10, top: 10),
                      child: TextTitle(
                        text:
                            "Stok Nonaktif (${controller.StockS.innactiveCount} item)",
                      ),
                    ),
                  if (controller.StockS.getStockList(false).isNotEmpty)
                    Column(
                      children: List.generate(
                        controller.StockS.getStockList(false).length,
                        (index) {
                          return StockItemWidget(
                            controller.StockS.getStockList(false)[index],
                          );
                        },
                      ),
                    ),
                  SizedBox(height: 100),
                ],
              ),
    );
  }
}
