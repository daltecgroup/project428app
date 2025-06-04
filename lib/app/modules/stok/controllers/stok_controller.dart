import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project428app/app/data/stock_provider.dart';
import 'package:project428app/app/models/stock.dart';
import 'package:project428app/app/services/order_service.dart';
import '../../../services/stock_service.dart';

class StokController extends GetxController
    with GetSingleTickerProviderStateMixin {
  StockProvider StockP = StockProvider();
  StockService StockS = Get.find<StockService>();
  OrderService OrderS = Get.find<OrderService>();
  RxList<Stock> stocks = <Stock>[].obs;

  RxInt activeCount = 0.obs;
  RxInt innactiveCount = 0.obs;

  late TabController tabC;

  RxInt currentIndex = 0.obs;

  final List<Tab> productTabs = <Tab>[
    Tab(text: 'Pesanan'),
    Tab(text: 'Riwayat'),
    Tab(text: 'Jenis'),
  ];

  @override
  void onInit() {
    super.onInit();
    getStocks();
    tabC = TabController(vsync: this, length: productTabs.length);
  }

  @override
  void onReady() {
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
