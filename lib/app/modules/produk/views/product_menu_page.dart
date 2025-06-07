import 'package:flutter/material.dart';
import 'package:project428app/app/shared/widgets/text_header.dart';

import '../controllers/produk_controller.dart';
import 'widgets/menu_item_widget.dart';

class ProductMenuPage extends StatelessWidget {
  const ProductMenuPage({super.key, required this.c});

  final ProdukController c;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(top: 20, bottom: 0),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
            c.categories.length,
            (firstIndex) => Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.zero),
              ),
              margin: EdgeInsets.only(bottom: 20),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 15,
                  right: 15,
                  top: 15,
                  bottom: 5,
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextTitle(text: c.categories[firstIndex].name),
                        Text(
                          ' (${c.products.where((e) => e.category?.id == c.categories[firstIndex].id).length} item /',
                        ),
                        SizedBox(width: 5),
                        c.categories[firstIndex].isActive
                            ? Text('Aktif)')
                            : Text('Nonaktif)'),
                      ],
                    ),
                    SizedBox(height: 12),

                    Column(
                      children: List.generate(
                        c.products.length,
                        (secondIndex) =>
                            c.categories[firstIndex].id ==
                                    c.products[secondIndex].category?.id
                                ? MenuItemWidget(
                                  c: c,
                                  product: c.products[secondIndex],
                                )
                                : SizedBox(),
                      ),
                    ),
                    SizedBox(height: 0),
                  ],
                ),
              ),
            ),
          ),
        ),

        Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.zero),
          ),
          margin: EdgeInsets.only(bottom: 20),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Row(
                  children: [
                    TextTitle(text: 'Tanpa Kategori'),
                    Text(
                      ' (${c.products.where((e) => e.category?.id == null).length} item)',
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Column(
                  children: List.generate(
                    c.products.length,
                    (secondIndex) =>
                        c.products[secondIndex].category?.id == null
                            ? MenuItemWidget(
                              c: c,
                              product: c.products[secondIndex],
                            )
                            : SizedBox(),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 50),
        // MenuItemWidget(c: c),
      ],
    );
  }
}
