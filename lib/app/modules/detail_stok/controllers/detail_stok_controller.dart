import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:project428app/app/data/stock_provider.dart';
import 'package:project428app/app/modules/stok/controllers/stok_controller.dart';

import '../../../models/stock.dart';

class DetailStokController extends GetxController {
  Rx<Stock> stock = (Get.arguments as Stock).obs;
  StockProvider StockP = StockProvider();
  StokController StockC = Get.find<StokController>();

  RxList<StockHistory> stockHistory = <StockHistory>[].obs;

  RxString newName = ''.obs;
  RxInt newPrice = 0.obs;
  @override
  void onInit() {
    super.onInit();
    getStockHistory();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getStock() async {
    await StockP.getStockById(stock.value.stockId).then((res) {
      stock.value = Stock.fromJson(res.body);
    });
  }

  Future<void> deactiveStock() async {
    await StockP.deactivateStock(stock.value.stockId).then((res) {
      getStock();
      StockC.getStocks();
    });
  }

  Future<void> reactiveStock() async {
    await StockP.reactivateStock(stock.value.stockId).then((res) {
      getStock();
      StockC.getStocks();
    });
  }

  void updateStock() {
    TextEditingController newNameC = TextEditingController();
    TextEditingController newPriceC = TextEditingController();

    Get.defaultDialog(
      title: "Ubah Data Stok",
      titleStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      radius: 8,
      content: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
              controller: newNameC,
              textCapitalization: TextCapitalization.characters,
              decoration: InputDecoration(
                label: Text('Nama Baru'),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: newPriceC,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp("[0-9]")),
              ],
              decoration: InputDecoration(
                label: Text('Harga Baru'),
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
      confirm: TextButton(
        onPressed: () async {
          if (newNameC.text.isNotEmpty || newPriceC.text.isNotEmpty) {
            await StockP.updateStock(
              stock.value.stockId,
              newNameC.text.isEmpty
                  ? stock.value.name
                  : newNameC.text.trim().capitalize!,
              newPriceC.text.isEmpty
                  ? stock.value.price
                  : int.parse(newPriceC.text),
            ).then((res) {
              getStock();
              getStockHistory();
              StockC.getStocks();
            });
          }
          Get.back();
        },
        child: Text("Simpan"),
      ),
      cancel: TextButton(
        onPressed: () {
          Get.back();
        },
        child: Text("Batal"),
      ),
    );
  }

  void getStockHistory() async {
    stockHistory.clear();
    try {
      await StockP.getStockHistory(stock.value.stockId).then((res) {
        for (var e in res.body) {
          StockHistory historyItem = StockHistory.fromJson(e);
          stockHistory.add(historyItem);
        }
      });
    } catch (e) {
      print(e);
    }
    stockHistory = stockHistory.reversed.toList().obs;
  }
}
