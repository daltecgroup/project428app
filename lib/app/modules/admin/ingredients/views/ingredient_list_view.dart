import '../../../../routes/app_pages.dart';
import '../../../../shared/buttons/floating_add_button.dart';
import '../../../../shared/custom_appbar_lite.dart';
import '../../../../shared/custom_nav_item.dart';
import '../../../../shared/vertical_sized_box.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/helpers/time_helper.dart';
import '../../../../utils/theme/custom_text.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/ingredient_list_controller.dart';

class IngredientsListView extends GetView<IngredientListController> {
  const IngredientsListView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarLite(
        context: context,
        title: 'Bahan Baku',
        backRoute: Routes.PRODUCT,
      ),
      body: RefreshIndicator(
        child: Obx(
          () => ListView(
            padding: EdgeInsets.symmetric(
              horizontal: AppConstants.DEFAULT_PADDING,
            ),
            children: [
              VerticalSizedBox(height: 2),
              ...List.generate(controller.filteredIngredients().length, (
                index,
              ) {
                if (controller.filteredIngredients()[index].isActive) {
                  return CustomNavItem(
                    leading: Icon(Icons.inventory_2),
                    title: controller
                        .filteredIngredients()[index]
                        .name
                        .capitalize!,
                    subTitle:
                        'Rp ${controller.filteredIngredients()[index].priceString}/gr',
                    onTap: () async {
                      controller.data.selectedIngredient.value = controller
                          .filteredIngredients()[index];
                      await controller.data.fetchIngredientHistory();
                      Get.toNamed(Routes.INGREDIENT_DETAIL);
                    },
                  );
                }
                return SizedBox();
              }),
              VerticalSizedBox(),
              if (controller.filteredIngredients(status: false).isNotEmpty)
                customListHeaderText(text: 'Bahan Baku Nonaktif'),
              VerticalSizedBox(),
              if (controller.filteredIngredients(status: false).isNotEmpty)
                ...List.generate(
                  controller.filteredIngredients(status: false).length,
                  (index) {
                    if (!controller
                        .filteredIngredients(status: false)[index]
                        .isActive) {
                      return CustomNavItem(
                        leading: Icon(Icons.inventory_2),
                        disabled: true,
                        title: controller
                            .filteredIngredients(status: false)[index]
                            .name,
                        subTitle:
                            'Rp ${controller.filteredIngredients(status: false)[index].priceString}/gr',
                        onTap: () async {
                          controller.data.selectedIngredient.value = controller
                              .filteredIngredients(status: false)[index];
                          await controller.data.fetchIngredientHistory();
                          Get.toNamed(Routes.INGREDIENT_DETAIL);
                        },
                      );
                    }
                    return SizedBox();
                  },
                ),
              VerticalSizedBox(),

              if (controller.data.latestSync.value != null)
                customFooterText(
                  textAlign: TextAlign.center,
                  text:
                      'Diperbarui ${contextualLocalDateTimeFormat(controller.data.latestSync.value!)}',
                ),
              VerticalSizedBox(height: 5),
            ],
          ),
        ),
        onRefresh: () => controller.refreshIngredients(),
      ),
      floatingActionButton: FloatingAddButton(
        tooltip: 'Tambah Bahan Baku',
        onPressed: () {
          controller.data.selectedIngredient.value = null;
          Get.toNamed(Routes.INGREDIENT_INPUT);
        },
      ),
    );
  }
}
