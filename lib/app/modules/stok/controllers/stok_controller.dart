import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project428app/app/data/stock_provider.dart';
import 'package:project428app/app/models/stock_data.dart';

class StokController extends GetxController {
  StockProvider StockP = StockProvider();
  RxList<Stock> stocks = <Stock>[].obs;

  RxInt activeCount = 0.obs;
  RxInt innactiveCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    getStocks();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getStocks() async {
    stocks.clear();
    activeCount.value = 0;
    innactiveCount.value = 0;

    try {
      await StockP.getStocks().then((res) {
        for (var e in res.body) {
          Stock stockItem = Stock.fromJson(e);
          if (stockItem.isActive) {
            activeCount++;
          } else {
            innactiveCount++;
          }
          stocks.add(stockItem);
        }
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteStock(String stockId, String name) async {
    Get.defaultDialog(
      title: "Konfirmasi",
      content: Text("Yakin menghapus $name?"),
      confirm: TextButton(
        onPressed: () async {
          await StockP.deleteStock(stockId).then((res) {
            getStocks();
            Get.back();
            Get.offNamed('/stok');
          });
        },
        child: Text("Yakin"),
      ),
      cancel: TextButton(
        onPressed: () {
          Get.back();
        },
        child: Text("Batal"),
      ),
    );
  }
}
