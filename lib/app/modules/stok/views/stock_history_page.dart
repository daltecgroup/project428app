import 'package:flutter/material.dart';
import 'package:project428app/app/constants.dart';
import 'package:project428app/app/modules/stok/controllers/stok_controller.dart';
import 'package:project428app/app/modules/stok/views/stok_item.dart';
import 'package:project428app/app/widgets/text_header.dart';

class StockHistoryPage extends StatelessWidget {
  const StockHistoryPage({super.key, required this.controller});

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
              TextTitle(text: "Stok Aktif (${controller.activeCount} item)"),
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
          children: List.generate(controller.stocks.length, (index) {
            return controller.stocks[index].isActive
                ? StokItem(controller.stocks[index])
                : SizedBox();
          }),
        ),
        Padding(
          padding: EdgeInsets.only(left: 12, bottom: 10, top: 20),
          child: TextTitle(
            text: "Stok Nonaktif (${controller.innactiveCount} item)",
          ),
        ),
        Column(
          children: List.generate(controller.stocks.length, (index) {
            return !controller.stocks[index].isActive
                ? StokItem(controller.stocks[index])
                : SizedBox();
          }),
        ),
        SizedBox(height: 100),
      ],
    );
  }
}
