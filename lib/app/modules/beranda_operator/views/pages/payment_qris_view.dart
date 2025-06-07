import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../services/operator_service.dart';
import '../../../../shared/widgets/text_header.dart';
import 'select_payment_method_view.dart';

class PaymentQrisView extends GetView {
  const PaymentQrisView({super.key});
  @override
  Widget build(BuildContext context) {
    OperatorService OperatorS = Get.find<OperatorService>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          OperatorS.currentPendingTrxCode.value,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Get.off(() => SelectPaymentMethodView());
          },
          icon: Icon(Icons.arrow_back_outlined),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
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
                                      flex: 2,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Metode',
                                            style: TextStyle(fontSize: 10),
                                          ),
                                          Text(
                                            'QRIS',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
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
                                                    ? salesItem.itemCount.value
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
                                      flex: 2,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
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
                                      flex: 3,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
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
                                      flex: 3,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
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
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextTitle(text: 'BANK KCP KOTA MALANG'),
                  SizedBox(height: 5),
                  TextTitle(text: 'A.N AROMA BISNIS GROUP'),
                  SizedBox(height: 5),
                  Text(
                    '123 4567 8910',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'TOTAL: ',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        'IDR 45.000',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  TextButton(
                    onPressed: () {},
                    child: Text('Input Nominal Bayar'),
                  ),
                  SizedBox(height: 10),
                  TextButton(onPressed: () {}, child: Text('Unggah Bukti')),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: // buttons
                Container(
              height: 100,
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.only(bottom: 20, left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Hero(
                      tag: 'back-button',
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
                        child: Text('Kembali', style: TextStyle(fontSize: 16)),
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
                      ),
                      onPressed: () {},
                      child: Text('Konfirmasi', style: TextStyle(fontSize: 16)),
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
