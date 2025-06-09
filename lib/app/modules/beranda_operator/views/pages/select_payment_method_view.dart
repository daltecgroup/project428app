import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:project428app/app/modules/beranda_operator/views/pages/new_sales_view.dart';
import 'package:project428app/app/modules/beranda_operator/views/pages/payment_cash_view.dart';
import 'package:project428app/app/modules/beranda_operator/views/pages/payment_qris_view.dart';
import 'package:project428app/app/modules/beranda_operator/views/pages/payment_transfer_view.dart';
import 'package:project428app/app/shared/widgets/text_header.dart';

import '../../../../services/operator_service.dart';

class SelectPaymentMethodView extends GetView {
  const SelectPaymentMethodView({super.key});
  @override
  Widget build(BuildContext context) {
    OperatorService OperatorS = Get.find<OperatorService>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          OperatorS.currentPendingTrxCode.value,
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Get.to(() => NewSalesView());
          },
          icon: Icon(Icons.arrow_back_outlined),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 15, top: 15, right: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      // new transactions indicator
                      Hero(
                        tag: 'payment-indicator',
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Card(
                                color: Colors.white,
                                elevation: 1,
                                margin: EdgeInsets.symmetric(horizontal: 0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15,
                                    vertical: 5,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Item',
                                              style: TextStyle(fontSize: 10),
                                            ),
                                            Obx(() {
                                              final salesItem = OperatorS
                                                  .pendingSales
                                                  .firstWhereOrNull(
                                                    (sales) =>
                                                        sales.trxCode ==
                                                        OperatorS
                                                            .currentPendingTrxCode
                                                            .value,
                                                  );

                                              // Now, salesItem can be null if no match was found
                                              final textContent =
                                                  salesItem != null
                                                      ? salesItem
                                                          .itemCount
                                                          .value
                                                          .toString() // Access .value only if not null
                                                      : '0'; // Provide a default if no matching sales item is found

                                              return Text(
                                                textContent,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              );
                                            }),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Promo',
                                              style: TextStyle(fontSize: 10),
                                            ),
                                            Text(
                                              '0',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Hemat',
                                              style: TextStyle(fontSize: 10),
                                            ),
                                            Obx(() {
                                              final salesItem = OperatorS
                                                  .pendingSales
                                                  .firstWhereOrNull(
                                                    (sales) =>
                                                        sales.trxCode ==
                                                        OperatorS
                                                            .currentPendingTrxCode
                                                            .value,
                                                  );

                                              final textContent =
                                                  salesItem != null
                                                      ? salesItem
                                                          .getSavingsInRupiah()
                                                      : 'IDR 0';

                                              return Text(
                                                textContent,
                                                style: const TextStyle(
                                                  // Added const for performance if style doesn't change
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              );
                                            }),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Total',
                                              style: TextStyle(fontSize: 10),
                                            ),
                                            Obx(() {
                                              final salesItem = OperatorS
                                                  .pendingSales
                                                  .firstWhereOrNull(
                                                    (sales) =>
                                                        sales.trxCode ==
                                                        OperatorS
                                                            .currentPendingTrxCode
                                                            .value,
                                                  );
                                              final String textContent;
                                              if (salesItem != null) {
                                                textContent =
                                                    salesItem
                                                        .getTotalInRupiah()
                                                        .toString();
                                              } else {
                                                textContent = '0';
                                              }
                                              return Text(
                                                textContent,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              );
                                            }),
                                          ],
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
                      SizedBox(height: 20),
                      TextTitle(text: 'Pilih Metode Pembayaran'),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 50,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  shape: WidgetStatePropertyAll(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  Get.to(() => PaymentCashView());
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [Text('Tunai')],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 50,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  shape: WidgetStatePropertyAll(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  Get.to(() => PaymentQrisView());
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('QRIS'),
                                    
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 50,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  shape: WidgetStatePropertyAll(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  Get.to(() => PaymentTransferView());
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Transfer Bank',
                                      // style: TextStyle(fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
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
                    child: Hero(
                      tag: 'back-button',
                      child: ElevatedButton(
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
                        child: Text('Kembali', style: TextStyle(fontSize: 16)),
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
