import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:project428app/app/modules/stok/controllers/stok_controller.dart';
import 'package:project428app/app/widgets/text_header.dart';

import '../../../../models/order.dart';
import '../widgets/stock_order_item.dart';

class StockHistoryPage extends StatelessWidget {
  const StockHistoryPage({super.key, required this.controller});

  final StokController controller;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: controller.OrderS.groupedOrders().keys.length,
      itemBuilder: (context, index) {
        String dateHeader = controller.OrderS.groupedOrders().keys.elementAt(
          index,
        );
        List<Order> itemsForDate =
            controller.OrderS.groupedOrders()[dateHeader]!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.only(left: 15),
              child: TextTitle(text: dateHeader),
            ),

            SizedBox(height: 5),
            ListView.builder(
              shrinkWrap: true, // Important to prevent unbounded height
              physics:
                  const NeverScrollableScrollPhysics(), // Important for nested list views
              itemCount: itemsForDate.length,
              itemBuilder: (context, itemIndex) {
                final item = itemsForDate[itemIndex];
                return StockOrderItem(item, index);
              },
            ),
          ],
        );
      },
    );
  }
}
