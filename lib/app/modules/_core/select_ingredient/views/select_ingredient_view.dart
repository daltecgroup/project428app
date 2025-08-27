import 'package:abg_pos_app/app/utils/constants/padding_constants.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../data/models/Recipe.dart';
import '../../../../shared/custom_appbar_lite.dart';
import '../../../../shared/custom_card.dart';
import '../../../../shared/vertical_sized_box.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/helpers/number_helper.dart';
import '../../../../utils/helpers/text_helper.dart';
import '../../../../utils/theme/app_colors.dart';
import '../../../../utils/theme/custom_text.dart';
import '../../../../utils/theme/text_style.dart';
import '../controllers/select_ingredient_controller.dart';

class SelectIngredientView extends GetView<SelectIngredientController> {
  const SelectIngredientView({super.key});
  @override
  Widget build(BuildContext context) {
    controller.setRecipe(init: true);
    return Scaffold(
      appBar: customAppBarLite(
        context: context,
        title: 'Pilih Bahan Baku',
        result: <Recipe>[],
        actions: [
          IconButton(
            onPressed: () {
              Get.back(result: controller.selectedRecipeList);
            },
            icon: Icon(Icons.check, size: AppConstants.DEFAULT_ICON_SIZE + 4),
          ),
          SizedBox(width: 8),
        ],
      ),
      body: Obx(
        () => Column(
          children: [
            // selected ingredients
            if (controller.selectedRecipe.isNotEmpty)
              Padding(
                padding: horizontalPadding,
                child: CustomCard(
                  content: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          customLabelText(
                            text:
                                'Bahan Baku (${controller.selectedRecipeList.length} item)',
                          ),
                        ],
                      ),
                      Container(
                        constraints: BoxConstraints(maxHeight: 110),
                        child: SingleChildScrollView(
                          child: Column(
                            children: List.generate(
                              controller.selectedRecipe.length,
                              (index) {
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${(index + 1).toString().padLeft(2, ' ')}. ${normalizeName(controller.selectedRecipe[index].ingredient.name)}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      '${inLocalNumber(controller.selectedRecipe[index].qty)} gram',
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      VerticalSizedBox(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              controller.selectedRecipeList.clear();
                              controller.setRecipe(init: false);
                            },
                            child: Text(
                              'Hapus Semua',
                              style: AppTextStyle.linkText,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            if (controller.selectedRecipe.isNotEmpty) VerticalSizedBox(),

            // ingredient listview
            Expanded(
              child: ListView(
                padding: horizontalPadding,
                children: [
                  VerticalSizedBox(),
                  if (controller.recipe.isNotEmpty)
                    ...List.generate(
                      controller.recipe.length,
                      (index) => IngredientItemWithQtySelector(
                        controller: controller,
                        recipe: controller.recipe[index],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class IngredientItemWithQtySelector extends StatelessWidget {
  const IngredientItemWithQtySelector({
    super.key,
    required this.recipe,
    required this.controller,
  });

  final Recipe recipe;
  final SelectIngredientController controller;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: recipe.isNotEmpty ? Colors.blueGrey[50] : AppColors.onPrimary,
      margin: EdgeInsets.only(bottom: AppConstants.DEFAULT_VERTICAL_MARGIN),

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(
          AppConstants.DEFAULT_BORDER_RADIUS,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: AppConstants.DEFAULT_PADDING,
          bottom: 8,
          top: 8,
        ),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(
                normalizeName(recipe.ingredient.name),
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
              ),
            ),
            Expanded(
              flex: 2,
              child: IntrinsicWidth(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (recipe.isNotEmpty)
                      IconButton(
                        visualDensity: VisualDensity.compact,
                        onPressed: () {
                          recipe.subtractQty(0.5);
                          controller.setRecipeList();
                        },
                        icon: Icon(
                          Icons.remove_circle_rounded,
                          color: Colors.red,
                        ),
                      ),
                    if (recipe.isNotEmpty)
                      GestureDetector(
                        onTap: () async {
                          recipe.setQty(
                            await controller.openQtySelector(
                                  currentQty: recipe.qty,
                                ) ??
                                recipe.qty,
                          );
                          controller.setRecipeList();
                        },
                        child: Container(
                          constraints: BoxConstraints(minWidth: 40),
                          child: Text(
                            textAlign: TextAlign.center,
                            inLocalNumber(recipe.qty),
                            style: TextStyle(
                              fontWeight: recipe.isNotEmpty
                                  ? FontWeight.w600
                                  : null,
                              color: recipe.isNotEmpty ? null : Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    IconButton(
                      visualDensity: VisualDensity.compact,
                      onPressed: () async {
                        if (recipe.qty.isEqual(0)) {
                          recipe.setQty(
                            await controller.openQtySelector() ?? 0.5,
                          );
                        } else {
                          recipe.addQty(0.5);
                        }
                        controller.setRecipeList();
                      },
                      icon: Icon(
                        Icons.add_circle_rounded,
                        color: recipe.isNotEmpty
                            ? Colors.lightGreen[700]
                            : Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
