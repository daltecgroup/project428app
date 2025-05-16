import 'package:flutter/material.dart';
import 'package:project428app/app/widgets/text_header.dart';

import '../controllers/produk_controller.dart';
import 'menu_item_widget.dart';

class ProductMenuPage extends StatelessWidget {
  const ProductMenuPage({super.key, required this.c});

  final ProdukController c;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 0),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextTitle(text: 'Non Kategori'),
            TextButton(onPressed: () {}, child: Text('Refresh')),
          ],
        ),
        SizedBox(height: 5),
        MenuItemWidget(c: c),
        MenuItemWidget(c: c),
        MenuItemWidget(c: c),
        SizedBox(height: 10),
        TextTitle(text: 'Kategori 1'),
        SizedBox(height: 10),
        MenuItemWidget(c: c),
        MenuItemWidget(c: c),
        MenuItemWidget(c: c),
      ],
    );
  }
}
