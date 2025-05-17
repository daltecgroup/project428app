import 'package:flutter/material.dart';
import 'package:project428app/app/models/product_category_data.dart';
import 'package:project428app/app/modules/produk/controllers/produk_controller.dart';

class CategoryItemWidget extends StatelessWidget {
  const CategoryItemWidget({
    super.key,
    required this.c,
    required this.category,
    required this.section,
  });

  final ProdukController c;
  final ProductCategory category;
  final bool section;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: section ? Colors.white : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      margin: EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(category.name, style: TextStyle(fontWeight: FontWeight.w500)),
            PopupMenuButton(
              color: Colors.white,
              icon: Icon(Icons.more_horiz),
              itemBuilder:
                  (context) => <PopupMenuEntry>[
                    PopupMenuItem(
                      onTap:
                          () => c.updateProductCategoryName(
                            category.id,
                            category.name,
                          ),
                      child: Text('Ubah'),
                    ),
                    PopupMenuItem(
                      onTap:
                          () => c.setProductCategoryStatus(section, category),
                      child: Text(section ? 'Nonaktifkan' : 'Aktifkan'),
                    ),
                    PopupMenuDivider(height: 1),
                    PopupMenuItem(
                      onTap:
                          () => c.deleteProductCategory(
                            category.id,
                            category.name,
                          ),
                      child: Text('Hapus', style: TextStyle(color: Colors.red)),
                    ),
                  ],
            ),
          ],
        ),
      ),
    );
  }
}
