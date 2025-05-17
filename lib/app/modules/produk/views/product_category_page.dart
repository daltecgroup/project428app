import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project428app/app/widgets/text_header.dart';

import '../controllers/produk_controller.dart';
import 'widgets/category_item_widget.dart';

class ProductCategoryPage extends StatelessWidget {
  const ProductCategoryPage({super.key, required this.c});

  final ProdukController c;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView(
        padding: EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 0),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextTitle(text: 'Aktif'),
              TextButton(
                onPressed: () async {
                  await c.getProductCategories();
                },
                child: Text('Refresh'),
              ),
            ],
          ),
          SizedBox(height: 5),
          Column(
            children: List.generate(
              c.categories.length,
              (index) =>
                  c.categories[index].isActive
                      ? CategoryItemWidget(
                        c: c,
                        category: c.categories[index],
                        section: true,
                      )
                      : SizedBox(),
            ),
          ),
          SizedBox(height: 10),
          TextTitle(text: 'Nonaktif'),
          SizedBox(height: 10),
          Column(
            children: List.generate(
              c.categories.length,
              (index) =>
                  !c.categories[index].isActive
                      ? CategoryItemWidget(
                        c: c,
                        category: c.categories[index],
                        section: false,
                      )
                      : SizedBox(),
            ),
          ),
        ],
      ),
    );
  }
}
