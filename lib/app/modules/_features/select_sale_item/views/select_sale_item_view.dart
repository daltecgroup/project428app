import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../widgets/select_menu_bundle_item.dart';
import '../widgets/select_menu_item.dart';
import '../../../../shared/custom_appbar_lite.dart';
import '../../../../shared/custom_card.dart';
import '../../../../shared/vertical_sized_box.dart';
import '../../../../utils/helpers/text_helper.dart';
import '../../../../utils/theme/custom_text.dart';
import '../../../../utils/constants/app_constants.dart';
import '../controllers/select_sale_item_controller.dart';

class SelectSaleItemView extends GetView<SelectSaleItemController> {
  const SelectSaleItemView({super.key});

  @override
  Widget build(BuildContext context) {
    final customWidth = (Get.width - AppConstants.DEFAULT_PADDING * 2) / 4;

    return Scaffold(
      appBar: customAppBarLite(
        title: 'Pilih Produk',
        actions: [
          IconButton(
            onPressed: controller.createPendingSale,
            icon: Icon(Icons.check, size: AppConstants.DEFAULT_ICON_SIZE + 4),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Obx(() {
        final bundles = controller.bundleData.bundles;
        final groupedMenus = controller.menuData.groupedMenuByCategory;

        return ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.DEFAULT_PADDING,
          ),
          children: [
            CustomCard(
              padding: 8,
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: AppConstants.DEFAULT_PADDING / 2,
                    ),
                    child: customLabelText(text: 'Menu Online'),
                  ),
                  SizedBox(
                    height: 40,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Switch(
                        value: controller.showOnline.value,
                        onChanged: (value) =>
                            controller.showOnline.value = value,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const VerticalSizedBox(height: 2),

            // Bundle menu
            if (bundles.isNotEmpty) ...[
              customListHeaderText(text: 'Paket'),
              const VerticalSizedBox(),
              _buildGrid(
                items: bundles
                    .map(
                      (bundle) => SelectMenuBundleItem(
                        controller: controller,
                        customWidth: customWidth,
                        bundle: bundle,
                      ),
                    )
                    .toList(),
                customWidth: customWidth,
              ),
              const VerticalSizedBox(height: 2),
            ],

            // Single menu
            ...groupedMenus.entries
                .where((entry) {
                  final name = controller.categoryData.getCategoryName(
                    entry.key,
                  );
                  return controller.showOnline.value
                      ? name.contains('online')
                      : !name.contains('online');
                })
                .map((entry) {
                  final name = normalizeName(
                    controller.categoryData.getCategoryName(entry.key),
                  );
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customListHeaderText(text: name),
                      const VerticalSizedBox(),
                      _buildGrid(
                        items: entry.value
                            .map(
                              (menu) => SelectMenuItem(
                                controller: controller,
                                customWidth: customWidth,
                                menu: menu,
                              ),
                            )
                            .toList(),
                        customWidth: customWidth,
                      ),
                      const VerticalSizedBox(height: 2),
                    ],
                  );
                }),
            const VerticalSizedBox(height: 10),
          ],
        );
      }),
    );
  }

  Widget _buildGrid({
    required List<Widget> items,
    required double customWidth,
  }) {
    return GridView(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: customWidth,
        mainAxisExtent: customWidth + AppConstants.DEFAULT_PADDING * 2,
        mainAxisSpacing: AppConstants.DEFAULT_PADDING,
        crossAxisSpacing: AppConstants.DEFAULT_PADDING,
      ),
      children: items,
    );
  }
}
