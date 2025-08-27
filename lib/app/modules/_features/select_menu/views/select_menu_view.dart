import 'package:abg_pos_app/app/utils/constants/padding_constants.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../shared/custom_appbar_lite.dart';
import '../../../../shared/custom_card.dart';
import '../../../../shared/vertical_sized_box.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/helpers/text_helper.dart';
import '../../../../utils/theme/custom_text.dart';
import '../controllers/select_menu_controller.dart';
import '../widgets/select_menu_item.dart';

class SelectMenuView extends GetView<SelectMenuController> {
  const SelectMenuView({super.key});
  @override
  Widget build(BuildContext context) {
    final customWidth = (Get.width - AppConstants.DEFAULT_PADDING * 2) / 4;
    return Scaffold(
      appBar: customAppBarLite(title: 'Pilih Menu', result: null),
      body: Obx(() {
        final groupedMenus = controller.menuData.groupedMenuByCategory;
        return Column(
          children: [
            // online bundle switch
            Padding(
              padding: horizontalPadding,
              child: CustomCard(
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
            ),

            // menu list
            Expanded(
              child: ListView(
                padding: horizontalPadding,
                children: [
                  const VerticalSizedBox(height: 2),

                  // show all grouped menu by category
                  if (controller.getArgumentCategoryId == null)
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

                  // show only selected menu in category
                  if (controller.getArgumentCategoryId != null) ...[
                    customListHeaderText(
                      text: normalizeName(
                        controller.categoryData.getCategoryName(
                          controller.getArgumentCategoryId!,
                        ),
                      ),
                    ),
                    const VerticalSizedBox(),
                    _buildGrid(
                      items: controller
                          .getMenus()
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
                  ],
                ],
              ),
            ),
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
