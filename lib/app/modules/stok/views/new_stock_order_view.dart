import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:project428app/app/models/outlet.dart';
import 'package:project428app/app/services/operator_service.dart';
import 'package:project428app/app/services/outlet_service.dart';
import 'package:project428app/app/services/stock_service.dart';
import 'package:project428app/app/widgets/stocks/ingredients_item.dart';

import '../../../style.dart';
import '../../../widgets/field_error_widget.dart';
import '../../../widgets/text_header.dart';

class NewStockOrderView extends GetView {
  const NewStockOrderView({super.key});
  @override
  Widget build(BuildContext context) {
    OperatorService OperatorS = Get.find<OperatorService>();
    OutletService OutletS = Get.find<OutletService>();
    StockService StockS = Get.find<StockService>();
    StockS.getStocks();

    RxBool isOutletError = false.obs;
    RxBool isItemsError = false.obs;
    Outlet? selectedOutlet;

    int getTotalPrice(RxList list) {
      num result =
          0; // Use num to handle potential doubles during multiplication
      for (var e in list) {
        // Ensure 'qty' and 'price' are treated as numbers.
        // If they could be strings, you'd need to parse them:
        // result = result + (num.parse(e['qty'].toString()) * num.parse(e['price'].toString()));
        result = result + (e['qty'] * e['price']);
      }

      return result.toInt(); // Convert the result to an int
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tambah Pesanan',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            StockS.clearOrderList();
            Get.back();
          },
          icon: Icon(Icons.arrow_back_rounded),
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  // order data
                  Card(
                    color: Colors.white,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    margin: EdgeInsets.all(0),
                    child: Padding(
                      padding: const EdgeInsets.all(15),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(
                            () => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextTitle(text: 'Tujuan Pengiriman'),
                                SizedBox(height: 5),
                                Material(
                                  elevation: 2,
                                  borderRadius: BorderRadius.circular(8),
                                  child:
                                      OutletS.outlets.isEmpty
                                          ? Text('Data Gerai gagal dimuat')
                                          : DropdownButtonFormField<Outlet>(
                                            value: null,
                                            decoration: TextFieldDecoration1(),
                                            items: [
                                              ...List.generate(
                                                OutletS.outlets.length,
                                                (index) => DropdownMenuItem(
                                                  value: OutletS.outlets[index],
                                                  onTap: () {
                                                    isOutletError.value = false;
                                                    selectedOutlet =
                                                        OutletS.outlets[index];
                                                  },
                                                  child: Container(
                                                    width: 250,
                                                    child: Text(
                                                      '${OutletS.outlets[index].code} - ${OutletS.outlets[index].name}',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                            onChanged: (value) {},
                                          ),
                                ),
                                if (isOutletError.value) SizedBox(height: 5),
                                FieldErrorWidget(
                                  isError: isOutletError.value,
                                  text: 'Tujuan harus dipilih',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 30),

                  // Komposisi bahan
                  Card(
                    color: Colors.white,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    margin: EdgeInsets.all(0),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Container(
                        width: double.infinity,
                        child: Obx(
                          () => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextTitle(text: 'Daftar Pesanan'),
                                  TextButton(
                                    onPressed: () {
                                      StockS.addOrders();
                                      isItemsError.value = false;
                                    },
                                    child: Text('Tambah'),
                                  ),
                                ],
                              ),
                              StockS.orderList.isEmpty
                                  ? SizedBox()
                                  : SizedBox(height: 5),
                              StockS.orderList.isEmpty
                                  ? SizedBox()
                                  : Column(
                                    children: List.generate(
                                      StockS.orderList.length,
                                      (index) => StockOrderItemWidget(
                                        stock: StockS.orderList[index]['stock'],
                                        name: StockS.orderList[index]['name'],
                                        qty: StockS.orderList[index]['qty'],
                                        unit: StockS.orderList[index]['unit'],
                                        price: StockS.orderList[index]['price'],
                                        delete: () {
                                          StockS.orderList.removeAt(index);
                                        },
                                      ),
                                    ),
                                  ),
                              StockS.orderList.isEmpty
                                  ? SizedBox()
                                  : SizedBox(height: 10),
                              StockS.orderList.isEmpty
                                  ? SizedBox()
                                  : Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            'Total Harga',
                                            style: TextStyle(fontSize: 10),
                                          ),
                                          Text(
                                            'IDR ${NumberFormat("#,##0", "id_ID").format(getTotalPrice(StockS.orderList))}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                              FieldErrorWidget(
                                isError: isItemsError.value,
                                text: 'Bahan tidak boleh kosong',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 100),
                ],
              ),
            ),
          ),
          Positioned.fill(
            bottom: 0,
            child: Container(
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.only(bottom: 20, left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all(
                          Colors.grey[300],
                        ),
                      ),
                      onPressed: () {
                        StockS.clearOrderList();
                        Get.back();
                      },
                      child: Text('Kembali', style: TextStyle(fontSize: 16)),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                      ),
                      onPressed: () {
                        if (StockS.orderList.isEmpty) {
                          isItemsError.value = true;
                        }

                        if (selectedOutlet == null) {
                          isOutletError.value = true;
                        }

                        if (!isItemsError.value && !isOutletError.value) {
                          StockS.createStockOrder(
                            OperatorS.currentOutletId.value,
                            StockS.orderList
                                .toList()
                                .cast<Map<String, dynamic>>(),
                            getTotalPrice(StockS.orderList),
                          );
                        }
                      },
                      child: Text(
                        'Simpan',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
