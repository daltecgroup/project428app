import 'package:get/get.dart';

import '../data/stock_provider.dart';
import '../models/stock.dart';

class StockService extends GetxService {
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
}
