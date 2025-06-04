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
    List filter = ['ordered', 'processed', 'delivered', 'returned'];
    return Obx(
      () =>
          controller.OrderS.isLoading.value
              ? Center(child: CircularProgressIndicator())
              : controller.OrderS.getFilteredList(
                controller.OrderS.orders,
                filter,
              ).isEmpty
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextTitle(text: 'Tidak Ada Pesanan Aktif'),
                    SizedBox(height: 10),
                    Text(
                      textAlign: TextAlign.center,
                      'Tekan tombol "+" untuk menambahkan\npesanan baru',
                    ),
                  ],
                ),
              )
              : SingleChildScrollView(
                padding: EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 12, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [TextTitle(text: "Pesanan Aktif")],
                      ),
                    ),
                    Column(
                      children: List.generate(
                        controller.OrderS.getFilteredList(
                          controller.OrderS.orders,
                          filter,
                        ).length,
                        (index) {
                          return StockOrderItem(
                            controller.OrderS.getFilteredList(
                              controller.OrderS.orders,
                              filter,
                            )[index],
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
