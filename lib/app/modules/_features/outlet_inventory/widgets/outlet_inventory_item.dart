import 'package:abg_pos_app/app/shared/custom_nav_item.dart';
import 'package:abg_pos_app/app/shared/stock_inventory_status.dart';
import 'package:abg_pos_app/app/utils/helpers/number_helper.dart';
import 'package:abg_pos_app/app/utils/helpers/text_helper.dart';
import 'package:flutter/material.dart';

class OutletInventoryItem extends StatelessWidget {
  const OutletInventoryItem({
    super.key,
    required this.title,
    required this.qty,
  });

  final String title;
  final double qty;

  String _formatQuantity(double quantity) {
    if (quantity >= 1000) {
      return '${inLocalNumber(quantity / 1000)} Kg';
    } else {
      return '${inLocalNumber(quantity)} gram';
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomNavItem(
      leading: Icon(Icons.inventory_2_rounded),
      titleWidget: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(normalizeName(title)),
          StockInventoryStatus(currentQty: qty),
        ],
      ),
      // Simplified subTitle by extracting the logic into a private method
      subTitle: _formatQuantity(qty),
      disableTrailing: true,
      onTap: () {
        // customOutletStockAction();
      },
    );
  }
}
