import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:project428app/app/models/new_sales_item.dart';

class PendingSales {
  RxList<NewSalesItem> items = <NewSalesItem>[].obs;

  final String trxCode;
  final createdAt = DateTime.now();

  RxInt itemCount = 0.obs;
  RxInt savings = 0.obs;
  RxInt total = 0.obs;

  PendingSales({required this.trxCode});

  void addItem(NewSalesItem item) {
    items.add(item);
  }

  void updateItem(int index, NewSalesItem newItem) {
    items[index] = newItem;
  }

  void updateIndicators() {
    int counts = 0;
    int saves = 0;
    int tots = 0;

    if (items.isEmpty) {
      itemCount.value = counts;
      savings.value = 0;
      total.value = 0;
    } else {
      for (var item in items) {
        counts = counts + item.qty.value;
        saves = saves + (item.product.getSavings() * item.qty.value);
        tots = tots + (item.product.getFinalPrice() * item.qty.value);
      }

      itemCount.value = counts;
      savings.value = saves;
      total.value = tots;
    }
  }

  String getSavingsInRupiah() {
    return "IDR ${NumberFormat("#,##0", "id_ID").format(savings.value)}";
  }

  String getTotalInRupiah() {
    return "IDR ${NumberFormat("#,##0", "id_ID").format(total.value)}";
  }

  String getCreateTime() {
    return "${createdAt.hour}:${createdAt.minute.isLowerThan(10) ? '0${createdAt.minute}' : createdAt.minute} WIB";
  }
}
