import 'package:flutter/material.dart';
import 'package:project428app/app/widgets/text_header.dart';

import '../controllers/produk_controller.dart';
import 'widgets/topping_item_widget.dart';

class ProductToppingPage extends StatelessWidget {
  const ProductToppingPage({super.key, required this.c});

  final ProdukController c;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 0),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextTitle(text: 'Topping Aktif'),
            TextButton(onPressed: () {}, child: Text('Refresh')),
          ],
        ),
        SizedBox(height: 5),
        ToppingItemWidget(),
        ToppingItemWidget(),
        ToppingItemWidget(),

        TextTitle(text: 'Topping Nonaktif'),
        SizedBox(height: 10),
        ToppingItemWidget(),
        ToppingItemWidget(),
        ToppingItemWidget(),
      ],
    );
  }
}
