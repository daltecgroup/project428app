import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../shared/buttons/custom_small_text_button.dart';
import '../../../../shared/custom_appbar_lite.dart';
import '../../../../shared/custom_nav_item.dart';
import '../../../../shared/horizontal_sized_box.dart';
import '../../../../shared/vertical_sized_box.dart';
import '../../../../shared/pages/empty_list_page.dart';
import '../../../../utils/helpers/outlet_helper.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/constants/padding_constants.dart';
import '../../../../utils/helpers/number_helper.dart';
import '../../../../utils/helpers/text_helper.dart';
import '../controllers/outlet_inventory_adjustment_controller.dart';

class OutletInventoryAdjustmentView
    extends GetView<OutletInventoryAdjustmentController> {
  const OutletInventoryAdjustmentView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarLite(
        title: 'Penyesuaian Stok',
        subtitle: currentOutletName,
        backRoute: controller.backRoute,
        actions: [
          IconButton(
            onPressed: () {
              controller.submitAdjustment();
            },
            icon: Icon(Icons.check, size: AppConstants.DEFAULT_ICON_SIZE + 4),
          ),
          SizedBox(width: 8),
        ],
      ),
      body: Obx(() {
        final outletInventory = controller.data.selectedOutletInventory.value;
        if (outletInventory == null)
          return EmptyListPage(
            refresh: () => controller.data.syncData(refresh: true),
            text: 'Bahan Baku Kosong',
          );

        final ingredients = outletInventory.ingredients;

        if (ingredients.isEmpty)
          return EmptyListPage(
            refresh: () => controller.data.syncData(refresh: true),
            text: 'Bahan Baku Kosong',
          );

        return ListView(
          padding: horizontalPadding,
          children: [
            const VerticalSizedBox(height: 2),
            ...ingredients.map((ingredient) {
              String formatQuantity(double quantity) {
                if (quantity >= 1000) {
                  return '${inLocalNumber(quantity / 1000)} Kg';
                } else {
                  return '${inLocalNumber(quantity)} gram';
                }
              }

              final adjQty = controller.getAdjQty(ingredient.ingredientId);
              final notes = controller.getNotes(ingredient.ingredientId);

              return CustomNavItem(
                leading: Icon(Icons.inventory_2_rounded),
                title: normalizeName(ingredient.name),
                subTitleWidget: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Jumlah Awal: ${formatQuantity(ingredient.currentQty)}',
                    ),
                    if (adjQty != null)
                      Text(
                        'Jumlah Terkini: ${formatQuantity(adjQty)}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),

                    if (notes != null) VerticalSizedBox(),
                    if (notes != null)
                      Row(
                        children: [
                          Text(
                            'Catatan: "$notes"',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    if (adjQty != null)
                      Row(
                        children: [
                          CustomSmallTextButton(
                            title: notes == null ? '+ Catatan' : 'Ubah Catatan',
                            onPressed: () {
                              controller.addAdjustmentNotes(
                                ingredient.ingredientId,
                                currentNotes: notes,
                              );
                            },
                          ),
                          const HorizontalSizedBox(),
                          if (notes != null)
                            CustomSmallTextButton(
                              title: 'Hapus Catatan',
                              onPressed: () {
                                controller.clearNotes(ingredient.ingredientId);
                              },
                            ),
                        ],
                      ),
                  ],
                ),
                trailing: IconButton(
                  onPressed: () {
                    controller.addAdjustmentQty(ingredient.ingredientId);
                  },
                  icon: Icon(Icons.edit),
                ),
              );
            }),
          ],
        );
      }),
    );
  }
}
