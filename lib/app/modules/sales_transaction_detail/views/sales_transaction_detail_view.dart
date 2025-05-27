import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/sales_transaction_detail_controller.dart';

class SalesTransactionDetailView
    extends GetView<SalesTransactionDetailController> {
  const SalesTransactionDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    controller.getInvoice(Get.arguments as String);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail Penjualan',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Get.offNamed('/beranda-operator');
            },
            icon: Icon(Icons.close_rounded),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 15, right: 15),
                  child: Column(
                    children: [
                      Card(
                        color: Colors.white,
                        margin: EdgeInsets.all(0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: Obx(
                          () => Padding(
                            padding: EdgeInsets.all(10),
                            child:
                                controller.invoice.value == null
                                    ? SizedBox()
                                    : Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            customTitleText(
                                              controller.invoice.value!.code,
                                              true,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            customText(
                                              controller.invoice.value!
                                                  .getCreateTimeDate(),
                                              false,
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    customText('ITEM: ', false),
                                                    customText(
                                                      controller.invoice.value!
                                                          .getQty()
                                                          .toString(),
                                                      true,
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    customText(
                                                      'PROMO: ',
                                                      false,
                                                    ),
                                                    customText(
                                                      controller
                                                          .invoice
                                                          .value!
                                                          .promoUsed
                                                          .toString(),
                                                      true,
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    customText(
                                                      'METODE: ',
                                                      false,
                                                    ),
                                                    customText(
                                                      controller
                                                          .invoice
                                                          .value!
                                                          .paymentMethod
                                                          .toUpperCase(),
                                                      true,
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    customText(
                                                      'KASIR: ',
                                                      false,
                                                    ),
                                                    customText(
                                                      controller
                                                          .invoice
                                                          .value!
                                                          .cashier
                                                          .name
                                                          .toUpperCase(),
                                                      true,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    customText(
                                                      'TOTAL: ',
                                                      false,
                                                    ),
                                                    customText(
                                                      controller.invoice.value!
                                                          .getTotalInRupiah(),
                                                      true,
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    customText(
                                                      'SEBELUM: ',
                                                      false,
                                                    ),
                                                    customText(
                                                      'IDR ${controller.invoice.value!.basePrice}',
                                                      true,
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    customText(
                                                      'HEMAT: ',
                                                      false,
                                                    ),
                                                    customText(
                                                      'IDR ${controller.invoice.value!.saving}',
                                                      true,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                customText(
                                                  'NOMINAL BAYAR',
                                                  false,
                                                ),
                                                customText(
                                                  'IDR ${controller.invoice.value!.paid}',
                                                  true,
                                                ),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                customText('KEMBALIAN', false),
                                                customText(
                                                  'IDR ${controller.invoice.value!.change}',
                                                  true,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        customRow(
                                          'ITEM',
                                          'QTY',
                                          'JUMLAH',
                                          true,
                                          false,
                                        ),
                                        SizedBox(height: 2),
                                        ...List.generate(
                                          controller
                                              .invoice
                                              .value!
                                              .items
                                              .length,
                                          (index) => Column(
                                            children: [
                                              customRow(
                                                controller
                                                    .invoice
                                                    .value!
                                                    .items[index]['name']
                                                    .toString()
                                                    .toUpperCase(),
                                                controller
                                                    .invoice
                                                    .value!
                                                    .items[index]['qty']
                                                    .toString()
                                                    .toUpperCase(),
                                                controller
                                                    .invoice
                                                    .value!
                                                    .items[index]['totalFinalPrice']
                                                    .toString()
                                                    .toUpperCase(),
                                                false,
                                                false,
                                              ),
                                              // customRow(
                                              //   '+ ABON AYAM',
                                              //   '1',
                                              //   '5.000',
                                              //   false,
                                              //   true,
                                              // ),
                                              // customRow(
                                              //   'NOTE: LESS SUGAR',
                                              //   null,
                                              //   null,
                                              //   false,
                                              //   true,
                                              // ),
                                              customRow(
                                                'DISKON ${controller.invoice.value!.items[index]['discount']}% (-${controller.invoice.value!.items[index]['totalSaving']})',
                                                null,
                                                null,
                                                false,
                                                true,
                                              ),
                                              SizedBox(height: 2),
                                            ],
                                          ),
                                        ),

                                        SizedBox(height: 30),
                                        // Row(
                                        //   mainAxisAlignment:
                                        //       MainAxisAlignment.center,
                                        //   children: [
                                        //     customText(
                                        //       'NOTE KE-1 DICETAK JOHN WILLIAM',
                                        //       false,
                                        //     ),
                                        //   ],
                                        // ),
                                        // Row(
                                        //   mainAxisAlignment:
                                        //       MainAxisAlignment.center,
                                        //   children: [
                                        //     customText(
                                        //       'PADA 25 MEI 2025 15.09 WIB',
                                        //       false,
                                        //     ),
                                        //   ],
                                        // ),
                                        // SizedBox(height: 30),
                                      ],
                                    ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 100,
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
                        Get.offNamed('/beranda-operator');
                      },
                      child: Text('Kembali', style: TextStyle(fontSize: 16)),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Hero(
                      tag: 'back-button',
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          'Cetak Nota',
                          style: TextStyle(fontSize: 16),
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
    );
  }

  Column customRow(
    String item,
    String? qty,
    String? subtotal,
    bool? bold,
    bool indent,
  ) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 6,
              child: Row(
                children: [
                  indent ? SizedBox(width: 8) : SizedBox(),
                  customText(item, bold ?? false),
                ],
              ),
            ),
            qty != null
                ? Expanded(flex: 1, child: customText(qty, bold ?? false))
                : SizedBox(),
            subtotal != null
                ? Expanded(
                  flex: 2,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: customText(subtotal, bold ?? false),
                  ),
                )
                : SizedBox(),
          ],
        ),
        SizedBox(height: 1),
      ],
    );
  }

  Text customText(String text, bool bold) => Text(
    text,
    style: TextStyle(
      fontWeight: bold ? FontWeight.bold : FontWeight.normal,
      fontSize: 12,
    ),
  );

  Text customTitleText(String text, bool bold) => Text(
    text,
    style: TextStyle(
      fontWeight: bold ? FontWeight.bold : FontWeight.normal,
      fontSize: 16,
    ),
  );
}
