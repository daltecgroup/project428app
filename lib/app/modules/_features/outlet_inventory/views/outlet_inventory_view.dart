import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../routes/app_pages.dart';
import '../../../../shared/pages/empty_list_page.dart';
import '../../../../shared/vertical_sized_box.dart';
import '../../../../utils/constants/padding_constants.dart';
import '../../../../utils/helpers/text_helper.dart';
import '../../../../utils/helpers/time_helper.dart';
import '../../../../utils/theme/custom_text.dart';
import '../widgets/outlet_inventory_item.dart';
import '../controllers/outlet_inventory_controller.dart';

class OutletInventoryView extends GetView<OutletInventoryController> {
  const OutletInventoryView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        final outletInventory = controller.data.selectedOutletInventory.value;

        if (controller.data.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (outletInventory == null) {
          return EmptyListPage(
            refresh: () => controller.data.syncData(refresh: true),
            text: 'Bahan Baku Kosong',
          );
        }

        final ingredients = outletInventory.ingredients;
        if (ingredients.isEmpty) {
          return EmptyListPage(
            refresh: () => controller.data.syncData(refresh: true),
            text: 'Bahan Baku Kosong',
          );
        }
        return RefreshIndicator(
          onRefresh: () => controller.data.syncData(refresh: true),
          child: ListView(
            padding: horizontalPadding,
            children: [
              const VerticalSizedBox(height: 2),
              // stok list
              ...ingredients.map((ingredient) {
                return OutletInventoryItem(
                  title: normalizeName(ingredient.name),
                  qty: ingredient.currentQty,
                );
              }),

              const VerticalSizedBox(),
              if (controller.data.latestSync.value != null)
                customFooterText(
                  textAlign: TextAlign.center,
                  text:
                      'Diperbarui ${contextualLocalDateTimeFormat(controller.data.latestSync.value!)}',
                ),
            ],
          ),
        );
      }),
      floatingActionButton: SafeArea(
        child: FloatingActionButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          tooltip: 'Adjustment',
          heroTag: 'user_filter',
          onPressed: () async {
            Get.toNamed(Routes.OUTLET_INVENTORY_ADJUSTMENT);
          },
          child: const Icon(Icons.edit_note_rounded),
        ),
      ),
    );
  }
}
