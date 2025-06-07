import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project428app/app/services/auth_service.dart';
import 'package:project428app/app/services/order_service.dart';
import 'package:project428app/app/shared/widgets/order_item_status_widget.dart';
import 'package:project428app/app/shared/widgets/stocks/order_detail_item.dart';

import '../../../style.dart';
import '../../../shared/widgets/text_header.dart';

class StockOrderDetailView extends GetView {
  const StockOrderDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    AuthService AuthS = Get.find<AuthService>();
    OrderService OrderS = Get.find<OrderService>();
    List status = [
      'ordered',
      'processed',
      'ontheway',
      'accepted',
      'returned',
      'failed',
    ];
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: const Text(
            'Detail Pesanan',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back_rounded),
          ),
          actions: [
            IconButton(
              onPressed: () async {
                OrderS.deleteOrder(
                  OrderS.currentOrder.value!.code,
                  OrderS.currentOrder.value!.code,
                );
              },
              icon: Icon(Icons.delete, color: Colors.red[900]),
            ),
            SizedBox(width: 10),
          ],
        ),
        body:
            OrderS.currentOrder.value == null
                ? Center(child: CircularProgressIndicator())
                : Stack(
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
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              margin: EdgeInsets.all(0),
                              child: Padding(
                                padding: const EdgeInsets.all(15),

                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Kode Pesanan',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                  Text(
                                                    OrderS
                                                        .currentOrder
                                                        .value!
                                                        .code,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    'Dibuat pada',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                  Text(
                                                    textAlign: TextAlign.end,
                                                    OrderS.currentOrder.value!
                                                        .getCreateTimeDate(),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'SPV Area',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                  Text(
                                                    'William Harris',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    'Jumlah',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                  Text(
                                                    '${OrderS.currentOrder.value!.items.length} Item',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Tujuan',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                  Text(
                                                    OrderS
                                                        .currentOrder
                                                        .value!
                                                        .outlet
                                                        .name,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    'Total Harga',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                  Text(
                                                    OrderS.currentOrder.value!
                                                        .getTotalInIDR(),
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        AuthS.hasAnyRole(['admin'])
                                            ? Column(
                                              children: [
                                                SizedBox(height: 10),
                                                Row(
                                                  children: [
                                                    Text(
                                                      'Status',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 5),
                                                Material(
                                                  elevation: 2,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  child: DropdownButtonFormField<
                                                    String
                                                  >(
                                                    value:
                                                        OrderS
                                                            .currentOrder
                                                            .value!
                                                            .status,
                                                    decoration:
                                                        TextFieldDecoration1(),
                                                    items: [
                                                      ...List.generate(
                                                        status.length,
                                                        (
                                                          index,
                                                        ) => DropdownMenuItem(
                                                          value: status[index],
                                                          child: Container(
                                                            width: 250,
                                                            child:
                                                                OrderItemStatusWidget(
                                                                  status[index],
                                                                  false,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                    onChanged: (value) {
                                                      OrderS.currentOrder.value!
                                                          .setStatus(value!)
                                                          .then((success) {
                                                            if (success) {
                                                              OrderS.orders
                                                                  .refresh();
                                                              OrderS.getOrders();
                                                            }
                                                          });
                                                    },
                                                  ),
                                                ),
                                              ],
                                            )
                                            : SizedBox(),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            // order list
                            Card(
                              color: Colors.white,
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              margin: EdgeInsets.all(0),
                              child: Padding(
                                padding: EdgeInsets.all(15),
                                child: Container(
                                  width: double.infinity,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          TextTitle(text: 'Daftar Pesanan'),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Column(
                                        children: List.generate(
                                          OrderS
                                              .currentOrder
                                              .value!
                                              .items
                                              .length,
                                          (index) => OrderDetailItemWidget(
                                            order: OrderS.currentOrder.value!,
                                            index: index,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned.fill(
                      bottom: 0,
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        padding: EdgeInsets.only(
                          bottom: 20,
                          left: 15,
                          right: 15,
                        ),
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
                                  Get.back();
                                },
                                child: Text(
                                  'Kembali',
                                  style: TextStyle(fontSize: 16),
                                ),
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
                                  backgroundColor: MaterialStateProperty.all(
                                    Colors.blue,
                                  ),
                                ),
                                onPressed: () {},
                                child: Text(
                                  'Cetak',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
      ),
    );
  }
}
