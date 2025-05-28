import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../constants.dart';
import '../../../widgets/operator/operator_appbar.dart';
import '../../../widgets/operator/operator_drawer.dart';
import '../../../widgets/text_header.dart';
import '../../beranda_operator/views/widgets/transaction_item_widget.dart';
import '../controllers/transaksi_operator_controller.dart';

class TransaksiOperatorView extends GetView<TransaksiOperatorController> {
  const TransaksiOperatorView({super.key});
  @override
  Widget build(BuildContext context) {
    controller.OperatorS.getSalesByOutlet();
    return Scaffold(
      appBar: OperatorAppBar(context, "Transaksi"),
      drawer: OperatorDrawer(context, kOperatorMenuTransaksi),
      body: RefreshIndicator(
        child: ListView(
          children: [
            SizedBox(height: 20),
            controller.OperatorS.allSales.isEmpty
                ? SizedBox()
                : Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 15,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextTitle(text: 'Selesai'),
                      SizedBox(height: 8),

                      controller.OperatorS.allSales.isEmpty
                          ? SizedBox()
                          : Column(
                            children: List.generate(
                              controller.OperatorS.allSales.length,
                              (index) => Column(
                                children: [
                                  TransactionItemWidget(
                                    sale: controller.OperatorS.allSales[index],
                                  ),
                                  index ==
                                          controller.OperatorS.allSales.length -
                                              1
                                      ? SizedBox()
                                      : SizedBox(height: 8),
                                ],
                              ),
                            ),
                          ),
                    ],
                  ),
                ),
            SizedBox(height: 50),
          ],
        ),
        onRefresh: () {
          return controller.OperatorS.getSalesByOutlet();
        },
      ),
    );
  }
}
