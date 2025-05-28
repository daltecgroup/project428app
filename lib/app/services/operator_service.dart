import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:project428app/app/controllers/product_categoriey_data_controller.dart';
import 'package:project428app/app/controllers/product_data_controller.dart';
import 'package:project428app/app/data/operator_provider.dart';
import 'package:project428app/app/data/sale_data_provider.dart';
import 'package:project428app/app/models/pending_sales.dart';
import 'package:project428app/app/models/sale.dart';
import 'package:project428app/app/services/auth_service.dart';

class OperatorService extends GetxService {
  OperatorProvider OperatorP = OperatorProvider();
  SaleDataProvider SaleP = SaleDataProvider();
  ProductDataController ProductP = Get.put(ProductDataController());
  ProductCategorieyDataController CategoryP = Get.put(
    ProductCategorieyDataController(),
  );
  AuthService AuthS = Get.find<AuthService>();

  RxString currentOutletId = ''.obs;
  RxString currentOutletCode = ''.obs;
  RxString currentOutletName = ''.obs;
  RxBool isAssignToOutlet = false.obs;

  RxInt orderDone = 0.obs;
  RxInt pendingOrder = 0.obs;
  RxInt itemSold = 0.obs;

  RxList<PendingSales> pendingSales = <PendingSales>[].obs;
  RxList<Sale> closedSales = <Sale>[].obs;
  RxList<Sale> allSales = <Sale>[].obs;

  RxString currentPendingTrxCode = ''.obs;

  final count = 0.obs;
  @override
  Future<void> onInit() async {
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    Future.delayed(Duration(seconds: 5)).then((_) async {
      await getSalesByOutlet();
      await getTodaySalesByOutlet();
    });
  }

  @override
  void onClose() {
    super.onClose();
  }

  void refreshSalesIndicator() {
    if (closedSales.isNotEmpty) {
      orderDone.value = closedSales.length;

      int qty = 0;
      for (var sale in closedSales) {
        for (var item in sale.items) {
          qty = qty + item['qty'] as int;
        }
      }

      itemSold.value = qty;
    } else {
      orderDone.value = 0;
    }

    if (pendingSales.isNotEmpty) {
      pendingOrder.value = pendingSales.length;
    } else {
      pendingOrder.value = 0;
    }
  }

  void addPendingSales() {
    final trxCode = generateTrxCode();
    currentPendingTrxCode.value = trxCode;
    final newSales = PendingSales(trxCode: trxCode);
    pendingSales.add(newSales);
  }

  String generateTrxCode() {
    if (currentPendingTrxCode.value.isNotEmpty) {
      return currentPendingTrxCode.value;
    }
    final now = DateTime.now();
    final formattedDate = DateFormat('yyMMdd').format(now);
    final randomDigits =
        (10000 + (DateTime.now().millisecondsSinceEpoch % 90000)).toString();
    return 'TRX$formattedDate$randomDigits';
  }

  Future<void> getLatestProducts() async {
    await CategoryP.getProductCategories();
    await ProductP.getProducts();
  }

  Future<void> setCurrentOutlet(String id) async {
    await OperatorP.getOperatorOutletById(id).then((res) {
      if (res.statusCode == 200) {
        isAssignToOutlet.value = true;
        currentOutletId.value = res.body['_id'];
        currentOutletCode.value = res.body['code'];
        currentOutletName.value = res.body['name'];
      } else {
        isAssignToOutlet.value = false;
        currentOutletId.value = '';
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
      currentOutletId.value,
      AuthS.box.read('userProfile')['id'],
      method,
      0,
    ).then((res) async {
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
          await getTodaySalesByOutlet().then(
            (_) => Get.offNamed(
              '/sales-transaction-detail',
              arguments: {'trxCode': arg, 'from': 'transaction'},
            ),
          );

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

  Future<void> getSalesByOutlet() async {
    SaleP.getSalesByOutlet(currentOutletId.value).then((res) {
      if (res.statusCode == 200) {
        allSales.clear();
        if (res.body != null) {
          for (var e in res.body) {
            Sale saleItem = Sale.fromJson(e);
            allSales.add(saleItem);
          }
        }
        allSales.refresh();
        refreshSalesIndicator();
      } else {
        Get.snackbar(
          'Peringatan',
          'Gagal memuat data penjualan terbaru',
          duration: Duration(seconds: 1),
        );
      }
      // reorder list to show the latest sales first
      allSales.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      allSales.refresh();
      if (pendingSales.isNotEmpty) {
        deleteEmptyPendingSales();
      }
    });
  }

  Future<void> getTodaySalesByOutlet() async {
    SaleP.getTodaySalesByOutlet(currentOutletId.value).then((res) {
      if (res.statusCode == 200) {
        closedSales.clear();
        if (res.body != null) {
          for (var e in res.body) {
            Sale saleItem = Sale.fromJson(e);
            closedSales.add(saleItem);
          }
        }
        closedSales.refresh();
        refreshSalesIndicator();
      } else {
        Get.snackbar(
          'Peringatan',
          'Gagal memuat data penjualan terbaru',
          duration: Duration(seconds: 1),
        );
      }
      // reorder list to show the latest sales first
      closedSales.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      closedSales.refresh();
      if (pendingSales.isNotEmpty) {
        deleteEmptyPendingSales();
      }
    });
  }

  void deleteEmptyPendingSales() {
    // delete all the pending sales where the items is empty or the all the items is zero
    pendingSales.removeWhere(
      (sale) => sale.items.isEmpty || sale.total.value == 0,
    );
    pendingSales.refresh();
  }
}
