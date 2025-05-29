import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project428app/app/modules/stok/controllers/stok_controller.dart';
import 'package:project428app/app/modules/stok/views/widgets/stock_order_item.dart';
import 'package:project428app/app/widgets/text_header.dart';

class StockOrderPage extends StatelessWidget {
  const StockOrderPage({super.key, required this.controller});
  final StokController controller;

  @override
  Widget build(BuildContext context) {
    controller.OrderS.getOrders();
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
                : Column(
                  children: List.generate(controller.OrderS.orders.length, (
                    index,
                  ) {
                    return StockOrderItem(
                      controller.OrderS.orders[index],
                      index,
                    );
                  }),
                ),

            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
