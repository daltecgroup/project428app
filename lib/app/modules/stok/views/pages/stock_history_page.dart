import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project428app/app/constants.dart';
import 'package:project428app/app/modules/stok/controllers/stok_controller.dart';
import 'package:project428app/app/modules/stok/views/widgets/stok_item.dart';
import 'package:project428app/app/widgets/text_header.dart';

import '../widgets/stock_order_item.dart';

class StockHistoryPage extends StatelessWidget {
  const StockHistoryPage({super.key, required this.controller});

  final StokController controller;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 20),
      child: Obx(
        () => Column(
          children: [
            controller.OrderS.orders.isEmpty
                ? SizedBox()
                : Padding(
                  padding: EdgeInsets.only(left: 12, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [TextTitle(text: "Pesanan Aktif")],
                  ),
                ),
            controller.OrderS.orders.isEmpty
                ? SizedBox()
                : controller.OrderS.orders
                    .where(
                      (order) =>
                          order.status == 'accepted' ||
                          order.status == 'failed',
                    )
                    .toList()
                    .isEmpty
                ? Center(child: Text('Kosong'))
                : Column(
                  children: List.generate(
                    controller.OrderS.orders
                        .where(
                          (order) =>
                              order.status == 'accepted' ||
                              order.status == 'failed',
                        )
                        .toList()
                        .length,
                    (index) {
                      return StockOrderItem(
                        controller.OrderS.orders
                            .where(
                              (order) =>
                                  order.status == 'accepted' ||
                                  order.status == 'failed',
                            )
                            .toList()[index],
                        index,
                      );
                    },
                  ),
                ),

            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
