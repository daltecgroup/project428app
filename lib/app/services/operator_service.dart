import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:project428app/app/controllers/product_categoriey_data_controller.dart';
import 'package:project428app/app/controllers/product_data_controller.dart';
import 'package:project428app/app/data/operator_provider.dart';
import 'package:project428app/app/data/sale_data_provider.dart';
import 'package:project428app/app/modules/sales_transaction_detail/views/sales_transaction_detail_view.dart';
import 'package:project428app/app/services/auth_service.dart';

import '../models/product.dart';

class NewSalesItem {
  final Product product;
  RxInt qty = 1.obs;
  String note = '';
  String type = 'regular';
  List topping = [];

  NewSalesItem({required this.product});

  void setNote(String note) {
    note = note;
  }

  void addOne() {
    if (qty >= 0) {
      qty++;
    } else {
      qty.value = 0;
    }
  }

  void removeOne() {
    if (qty > 0) {
      qty--;
    } else {
      qty.value = 0;
    }
  }

  int getTotalPriceAfterDiscount() {
    return (product.price - ((product.discount / 100) * product.price).ceil()) *
        qty.value;
  }

  int getPriceAfterDiscount() {
    return product.price - ((product.discount / 100) * product.price).ceil();
  }

  int getSaving() {
    return ((product.discount / 100) * product.price).ceil();
  }

  int getTotalSaving() {
    return ((product.discount / 100) * product.price).ceil() * qty.value;
  }
}

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
}

class OperatorService extends GetxService {
  OperatorProvider OperatorP = OperatorProvider();
  SaleDataProvider SaleP = SaleDataProvider();
  ProductDataController ProductP = Get.put(ProductDataController());
  ProductCategorieyDataController CategoryP = Get.put(
    ProductCategorieyDataController(),
  );
  AuthService AuthS = Get.find<AuthService>();

  RxString currentOutletCode = ''.obs;
  RxString currentOutletName = ''.obs;
  RxBool isAssignToOutlet = false.obs;

  RxList<PendingSales> pendingSales = <PendingSales>[].obs;
  RxList closedSales = [].obs;

  RxString currentPendingTrxCode = ''.obs;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void addPendingSales() {
    final trxCode = generateTrxCode();
    currentPendingTrxCode.value = trxCode;
    final newSales = PendingSales(trxCode: trxCode);
    pendingSales.add(newSales);
  }

  String generateTrxCode() {
    final now = DateTime.now();
    final day = now.day.toString().padLeft(2, '0');
    final month = now.month.toString().padLeft(2, '0');
    final year = now.year.toString().substring(2);
    // last 4 digits of last item's trxCode in pendingSales
    // or generate a random number if no items exist
    if (pendingSales.isNotEmpty) {
      final lastTrxCode = pendingSales.last.trxCode;
      final lastNum = int.tryParse(lastTrxCode.split('-').last) ?? 0;
      // create a new 4 digit number randomly based on date
      final randomNum = (1000 + (9999 - 1000) * (lastNum % 1)).toInt();
      return 'TRX$day$month$year$randomNum';
    }
    // if no pending sales, generate a random number
    final randomNum =
        (1000 + (9999 - 1000) * (DateTime.now().millisecondsSinceEpoch % 1))
            .toInt();
    return 'TRX$day$month$year$randomNum';
  }

  Future<void> getLatestProducts() async {
    await CategoryP.getProductCategories();
    await ProductP.getProducts();
  }

  Future<void> setCurrentOutlet(String id) async {
    await OperatorP.getOperatorOutletById(id).then((res) {
      if (res.statusCode == 200) {
        isAssignToOutlet.value = true;
        currentOutletCode.value = res.body['code'];
        currentOutletName.value = res.body['name'];
      } else {
        isAssignToOutlet.value = false;
        currentOutletCode.value = '';
        currentOutletName.value = '';
      }
    });
  }

  Future<void> createSale(int paid, int change, String method) async {
    await SaleP.createSale(
      currentPendingTrxCode.value,
      pendingSales
          .firstWhere((sale) => currentPendingTrxCode.value == sale.trxCode)
          .items,
      pendingSales
          .firstWhere((sale) => currentPendingTrxCode.value == sale.trxCode)
          .total
          .value,
      pendingSales
              .firstWhere((sale) => currentPendingTrxCode.value == sale.trxCode)
              .savings
              .value +
          pendingSales
              .firstWhere((sale) => currentPendingTrxCode.value == sale.trxCode)
              .total
              .value,
      pendingSales
          .firstWhere((sale) => currentPendingTrxCode.value == sale.trxCode)
          .savings
          .value,
      paid,
      change,
      currentOutletCode.value,
      AuthS.box.read('userProfile')['id'],
      method,
      0,
    ).then((res) {
      switch (res.statusCode) {
        case 500:
          Get.defaultDialog(
            title: 'Peringatan',
            titleStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            content: Text('Kode Transaksi yang sama sudah terdaftar'),
            radius: 10,
          );
          break;
        case 201:
          var arg = currentPendingTrxCode.value;
          currentPendingTrxCode.value = '';
          pendingSales.removeWhere((sale) => sale.trxCode == arg);
          pendingSales.refresh();
          Get.offAll(() => SalesTransactionDetailView(), arguments: arg);
          break;
        default:
          Get.defaultDialog(
            title: 'Peringatan',
            titleStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            content: Text(res.body['message']),
            radius: 10,
          );
      }
    });
  }
}
