import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project428app/app/data/order_provider.dart';
import 'package:project428app/app/services/order_service.dart';
import 'package:project428app/app/widgets/alert_dialog.dart';

import '../data/stock_provider.dart';
import '../models/stock.dart';
import '../models/stock_history.dart';
import '../style.dart';
import '../widgets/text_header.dart';

class StockService extends GetxService {
  GetStorage box = GetStorage();
  StockProvider StockP = StockProvider();
  OrderProvider OrderP = OrderProvider();
  OrderService OrderS = OrderService();

  late TextEditingController qtyC;

  RxList<Stock> stocks = <Stock>[].obs;
  RxList<StockHistory> stockHistories = <StockHistory>[].obs;
  RxList orderList = [].obs;

  Rx<Stock?> selectedStock = (null as Stock?).obs;

  RxInt innactiveCount = 0.obs;
  RxInt activeCount = 0.obs;
  RxBool isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
    qtyC = TextEditingController();
    Future.delayed(Duration(seconds: 5)).then((_) {
      getStocks();
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    qtyC.dispose();
  }

  void clearOrderList() {
    orderList.clear();
  }

  void getStocks() async {
    isLoading.value = true;
    stocks.clear();
    activeCount.value = 0;
    innactiveCount.value = 0;

    try {
      await StockP.getStocks().then((res) async {
        for (var e in res.body) {
          Stock stockItem = Stock.fromJson(e);
          if (stockItem.isActive) {
            activeCount++;
          } else {
            innactiveCount++;
          }
          stocks.add(stockItem);
        }
        await Future.delayed(Duration(milliseconds: 500)).then((_) {
          isLoading.value = false;
        });
        // isLoading.value = false;
      });
    } catch (e) {
      print(e);
      isLoading.value = false;
    }
  }

  void changeStatus() {
    selectedStock.value!.changeStatus().then((success) {
      if (success) {
        selectedStock.refresh();
        getStocks();
      } else {
        CustomAlertDialog('Peringatan', 'Gagal mengubah status');
      }
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
              box.read('userProfile')['id'],
              selectedStock.value!.id,
              newNameC.text.isEmpty
                  ? selectedStock.value!.name
                  : newNameC.text.trim().capitalize!,
              newPriceC.text.isEmpty
                  ? selectedStock.value!.price
                  : int.parse(newPriceC.text),
            ).then((res) {
              stockHistories.clear();
              getStockHistories();
              stockHistories.refresh();
            });
          }
          Get.back();
          newNameC.dispose();
          newPriceC.dispose();
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

  void deleteStock() {}

  Future<void> getStockHistories() async {
    if (selectedStock.value == null) {
      CustomAlertDialog('Peringatan', 'Stok belum terpilih');
      isLoading.value = false;
    } else {
      try {
        await StockP.getStockHistory(selectedStock.value!.id).then((res) {
          if (res.statusCode == 200) {
            print(res.body);
            if (res.body.length > 0) {
              stockHistories.clear();
              for (var e in res.body) {
                stockHistories.add(StockHistory.fromJson(e));
              }
              // order from earliest to oldest
              stockHistories.sort((a, b) => a.createdAt.compareTo(b.createdAt));
              stockHistories = stockHistories.reversed.toList().obs;
              stockHistories.refresh();
            }
          } else {
            CustomAlertDialog('Peringatan', res.body['message']);
          }
        });
      } catch (e) {
        print(e);
      }
    }
  }

  List<Stock> getStockList(bool status) {
    List<Stock> list = <Stock>[];

    if (stocks.isNotEmpty) {
      for (var stock in stocks) {
        if (stock.isActive == status) {
          list.add(stock);
        }
      }
    }

    return list;
  }

  Future<void> createStockOrder(
    String outlet,
    List<Map<String, dynamic>> items,
    int total,
  ) async {
    try {
      final response = await OrderP.createOrder(outlet, items, total);
      switch (response.statusCode) {
        case 201:
          clearOrderList();
          Get.offNamed('/stok');
          break;
        case 400:
          Get.defaultDialog(
            title: 'Validation Error',
            titleStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
            content: Text(response.body['message'] ?? 'Invalid data provided.'),
            radius: 12,
          );
          break;
        case 401:
        case 403:
          Get.defaultDialog(
            title: 'Authentication Error',
            titleStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
            content: Text(
              response.body['message'] ??
                  'You are not authorized to perform this action.',
            ),
            radius: 12,
          );
          break;
        case 404:
          Get.defaultDialog(
            title: 'Not Found',
            titleStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
            content: Text(
              response.body['message'] ??
                  'The requested resource was not found.',
            ),
            radius: 12,
          );
          break;
        case 500: // Internal Server Error
          Get.defaultDialog(
            title: 'Server Error',
            titleStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
            content: Text(
              response.body['message'] ??
                  'An unexpected error occurred on the server.',
            ),
            radius: 12,
          );
          break;
        default: // Handle other potential HTTP status codes
          Get.defaultDialog(
            title: 'Error',
            titleStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
            content: Text(
              response.body['message'] ??
                  'An unexpected error occurred (Status: ${response.statusCode}).',
            ),
            radius: 12,
          );
          break;
      }
    } on Exception catch (e) {
      // Catch more specific exceptions for network or parsing errors
      // Remove loading indicator if shown
      // if (Get.isDialogOpen!) {
      //   Get.back(); // Close loading dialog
      // }
      print('Error creating stock order: $e'); // Log the error for debugging
      Get.defaultDialog(
        title: 'Connection Error',
        titleStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        content: Text(
          'Failed to connect to the server. Please check your internet connection or try again later. ($e)',
        ),
        radius: 12,
      );
    }
  }

  void addOrders() {
    TextEditingController qtyC = TextEditingController();

    var list =
        stocks.where((e) {
          if (e.isActive == false) {
            return false;
          } else {
            if (orderList.isEmpty) {
              return true;
            } else {
              for (var el in orderList) {
                if (e.id == el['stock']) {
                  return false;
                }
              }
              return true;
            }
          }
        }).toList();
    if (list.isEmpty) {
      Get.defaultDialog(
        title: 'Peringatan',
        titleStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        content: Text('Semua bahan telah ditambahkan'),
        radius: 12,
      );
    } else {
      Rx<Stock> selected = list.first.obs;
      Get.defaultDialog(
        backgroundColor: Colors.white,
        title: "Tambah Pesanan",
        titleStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        radius: 8,
        content: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextTitle(text: 'Bahan'),
              SizedBox(height: 5),
              Material(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: DropdownButtonFormField<String>(
                  value: selected.value.id,
                  decoration: TextFieldDecoration1(),
                  items: [
                    ...List.generate(
                      list.length,
                      (index) => DropdownMenuItem(
                        value: list[index].id,
                        child: Text(list[index].name),
                      ),
                    ),
                  ],
                  onChanged: (value) {
                    selected.value = stocks.firstWhere((e) => e.id == value);
                  },
                ),
              ),
              SizedBox(height: 10),
              Obx(
                () => TextTitle(
                  text:
                      'Komposisi (${stocks.firstWhere((e) => e.id == selected.value.id).unit == 'weight'
                          ? 'Kg'
                          : stocks.firstWhere((e) => e.id == selected.value.id).unit == 'volume'
                          ? 'Liter'
                          : 'pcs'})',
                ),
              ),
              SizedBox(height: 5),
              Material(
                elevation: 2,
                borderRadius: BorderRadius.circular(8),
                child: TextField(
                  controller: qtyC,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                  ],
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      if (int.parse(value) > 9999) {
                        Get.defaultDialog(
                          title: 'Peringatan',
                          titleStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                          content: Text('Kuantitas terlalu besar'),
                          radius: 12,
                        );
                      }
                    }
                  },
                  decoration: TextFieldDecoration1(),
                ),
              ),
            ],
          ),
        ),
        confirm: TextButton(
          onPressed: () async {
            if (qtyC.text.isNotEmpty) {
              orderList.add({
                'stock': selected.value.id,
                'name': selected.value.name,
                'qty': int.parse(qtyC.text),
                'unit': selected.value.unit,
                'price': selected.value.price,
              });
              if (orderList.isNotEmpty) {}
              qtyC.clear();
              Get.back();
            } else {
              Get.back();
              if (orderList.isNotEmpty) {}
            }
          },
          child: Text("Simpan"),
        ),
        cancel: TextButton(
          onPressed: () {
            qtyC.clear();
            Get.back();
          },
          child: Text("Batal"),
        ),
      );
    }
  }
}
