import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:project428app/app/controllers/input_number_controller.dart';
import 'package:project428app/app/modules/beranda_operator/views/pages/select_payment_method_view.dart';

import '../../../../services/operator_service.dart';
import '../../../../widgets/text_header.dart';

class PaymentCashView extends GetView {
  const PaymentCashView({super.key});
  @override
  Widget build(BuildContext context) {
    InputNumberController inputC = Get.put(InputNumberController());
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
            inputC.clear();
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
                    Row(
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
                    SizedBox(height: 20),
                    TextTitle(text: 'Input Jumlah Bayar'),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Expanded(
                          child: Card(
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 5,
                                ),
                                child: Obx(
                                  () => Text(
                                    inputC.result.value != '0'
                                        ? NumberFormat(
                                          "#,##0",
                                          "id_ID",
                                        ).format(int.parse(inputC.result.value))
                                        : '0',
                                    style: TextStyle(
                                      letterSpacing: 1,
                                      fontSize: 26,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InputNumberWidget(
                          title: '1',
                          func: () {
                            inputC.numberPress(1);
                          },
                          color: Colors.black,
                        ),
                        InputNumberWidget(
                          title: '2',
                          func: () {
                            inputC.numberPress(2);
                          },
                          color: Colors.black,
                        ),
                        InputNumberWidget(
                          title: '3',
                          func: () {
                            inputC.numberPress(3);
                          },
                          color: Colors.black,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InputNumberWidget(
                          title: '4',
                          func: () {
                            inputC.numberPress(4);
                          },
                          color: Colors.black,
                        ),
                        InputNumberWidget(
                          title: '5',
                          func: () {
                            inputC.numberPress(5);
                          },
                          color: Colors.black,
                        ),
                        InputNumberWidget(
                          title: '6',
                          func: () {
                            inputC.numberPress(6);
                          },
                          color: Colors.black,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InputNumberWidget(
                          title: '7',
                          func: () {
                            inputC.numberPress(7);
                          },
                          color: Colors.black,
                        ),
                        InputNumberWidget(
                          title: '8',
                          func: () {
                            inputC.numberPress(8);
                          },
                          color: Colors.black,
                        ),
                        InputNumberWidget(
                          title: '9',
                          func: () {
                            inputC.numberPress(9);
                          },
                          color: Colors.black,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InputNumberWidget(
                          title: '<',
                          func: () {
                            inputC.delete();
                          },
                          color: Colors.red[600],
                        ),
                        InputNumberWidget(
                          title: '0',
                          func: () {
                            inputC.numberPress(0);
                          },
                          color: Colors.black,
                        ),
                        InputNumberWidget(
                          title: 'C',
                          func: () {
                            inputC.clear();
                          },
                          color: Colors.teal,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
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
                        inputC.clear();
                        Get.back();
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
                        onPressed: () {
                          if (int.parse(inputC.result.value) <
                              OperatorS.pendingSales
                                  .firstWhere(
                                    (sales) =>
                                        sales.trxCode ==
                                        OperatorS.currentPendingTrxCode.value,
                                  )
                                  .total
                                  .value) {
                            Get.defaultDialog(
                              title: 'Peringatan',
                              titleStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                              content: Text(
                                'Nominal bayar masih kurang IDR ${NumberFormat("#,##0", "id_ID").format(OperatorS.pendingSales.firstWhere((sales) => sales.trxCode == OperatorS.currentPendingTrxCode.value).total.value - int.parse(inputC.result.value))}',
                              ),
                              radius: 10,
                            );
                          } else {
                            OperatorS.createSale(
                              int.parse(inputC.result.value),
                              int.parse(inputC.result.value) -
                                  OperatorS.pendingSales
                                      .firstWhere(
                                        (sales) =>
                                            sales.trxCode ==
                                            OperatorS
                                                .currentPendingTrxCode
                                                .value,
                                      )
                                      .total
                                      .value,
                              'cash',
                            );
                            // Get.offNamed('/sales-transaction-detail');
                          }
                        },
                        child: Text(
                          'Konfirmasi',
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
}

class InputNumberWidget extends StatelessWidget {
  const InputNumberWidget({
    super.key,
    required this.title,
    required this.func,
    required this.color,
  });

  final String title;
  final GestureTapCallback func;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(50),
      onTap: func,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Container(
          alignment: Alignment.center,
          height: 50,
          width: 40,
          child: Text(
            title,
            style: TextStyle(
              color: color,
              fontSize: 26,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
