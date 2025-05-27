import 'package:flutter/material.dart';
import 'package:project428app/app/constants.dart';
import 'package:project428app/app/modules/stok/controllers/stok_controller.dart';
import 'package:project428app/app/modules/stok/views/stock_order_item.dart';
import 'package:project428app/app/modules/stok/views/stok_item.dart';
import 'package:project428app/app/widgets/text_header.dart';

class StockOrderPage extends StatelessWidget {
  const StockOrderPage({super.key, required this.controller});

  final StokController controller;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(top: 20),
      children: [
        Padding(
          padding: EdgeInsets.only(left: 12, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextTitle(text: "Pesanan Aktif"),
              kEnv == 'dev'
                  ? TextButton(
                    onPressed: () {
                      controller.getStocks();
                    },
                    child: Text("Refresh"),
                  )
                  : SizedBox(),
            ],
          ),
        ),
        Column(
          children: List.generate(3, (index) {
            return StockOrderItem();
          }),
        ),
        SizedBox(height: 100),
      ],
    );
  }
}
