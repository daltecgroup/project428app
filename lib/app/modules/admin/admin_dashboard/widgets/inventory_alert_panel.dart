import 'package:abg_pos_app/app/data/models/DashboardResponse.dart';
import 'package:abg_pos_app/app/shared/custom_card.dart';
import 'package:abg_pos_app/app/shared/vertical_sized_box.dart';
import 'package:abg_pos_app/app/utils/helpers/text_helper.dart';
import 'package:abg_pos_app/app/utils/theme/custom_text.dart';
import 'package:flutter/material.dart';

class InventoryAlertPanel extends StatelessWidget {
  const InventoryAlertPanel({
    super.key,
    required this.inventoryAlerts,
  });

  final List<InventoryAlert> inventoryAlerts;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customListHeaderText(text: 'Peringatan Inventori'),
          const VerticalSizedBox(height: 0.7),
          ...inventoryAlerts.map(
            (alert) => Column(
              children: [
                CustomCard(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(normalizeName(alert.ingredientName)),
                      customLabelText(
                        text: '${alert.currentQty} gram',
                      ),
                    ],
                  ),
                ),
                const VerticalSizedBox(height: 0.7),
              ],
            ),
            
          ).toList()
        ],
      ),
    );
  }
}
