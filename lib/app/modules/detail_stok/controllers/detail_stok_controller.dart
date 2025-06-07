import 'package:get/get.dart';
import 'package:project428app/app/data/providers/stock_provider.dart';
import '../../../data/models/stock_history.dart';
import '../../../services/stock_service.dart';

class DetailStokController extends GetxController {
  StockProvider StockP = StockProvider();
  StockService StockS = Get.find<StockService>();

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

  void getStockHistory() async {
    stockHistory.clear();
    try {
      await StockP.getStockHistory(StockS.selectedStock.value!.stockId).then((
        res,
      ) {
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
