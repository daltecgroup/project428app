import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project428app/app/modules/produk/controllers/topping_controller.dart';
import 'package:project428app/app/services/topping_service.dart';
import 'package:project428app/app/shared/widgets/text_header.dart';

import '../controllers/produk_controller.dart';
import 'widgets/topping_item_widget.dart';

class ProductToppingPage extends GetView<ToppingController> {
  const ProductToppingPage({super.key, required this.c});

  final ProdukController c;

  @override
  Widget build(BuildContext context) {
    final ToppingService ToppingS = Get.find<ToppingService>();
    return Obx(
      () =>
          ToppingS.isLoading.value
              ? Center(child: CircularProgressIndicator())
              : ToppingS.toppings.isEmpty
              ? Center(child: TextTitle(text: 'Topping Kosong'))
              : ListView(
                padding: EdgeInsets.only(
                  left: 15,
                  right: 15,
                  top: 20,
                  bottom: 0,
                ),
                children: [
                  if (ToppingS.activeTopping.isNotEmpty)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextTitle(text: 'Topping Aktif'),
                        TextButton(
                          onPressed: () {
                            ToppingS.getAllToppings();
                          },
                          child: Text('Refresh'),
                        ),
                      ],
                    ),
                  if (ToppingS.activeTopping.isNotEmpty) SizedBox(height: 5),
                  if (ToppingS.activeTopping.isNotEmpty)
                    Column(
                      children: List.generate(
                        ToppingS.activeTopping.length,
                        (index) => ToppingItemWidget(
                          topping: ToppingS.activeTopping[index],
                        ),
                      ),
                    ),

                  if (ToppingS.deactiveTopping.isNotEmpty) SizedBox(height: 10),
                  if (ToppingS.deactiveTopping.isNotEmpty)
                    TextTitle(text: 'Topping Nonaktif'),
                  if (ToppingS.deactiveTopping.isNotEmpty) SizedBox(height: 10),
                  if (ToppingS.deactiveTopping.isNotEmpty)
                    Column(
                      children: List.generate(
                        ToppingS.deactiveTopping.length,
                        (index) => ToppingItemWidget(
                          topping: ToppingS.deactiveTopping[index],
                        ),
                      ),
                    ),
                ],
              ),
    );
  }
}
