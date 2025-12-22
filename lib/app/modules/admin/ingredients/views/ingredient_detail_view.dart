import 'package:abg_pos_app/app/utils/constants/padding_constants.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../routes/app_pages.dart';
import '../../../../shared/custom_card.dart';
import '../../../../shared/status_sign.dart';
import '../../../../data/models/Ingredient.dart';
import '../../../../utils/theme/text_style.dart';
import '../../../../utils/theme/custom_text.dart';
import '../../../../utils/theme/button_style.dart';
import '../../../../shared/custom_appbar_lite.dart';
import '../../../../shared/vertical_sized_box.dart';
import '../../../../utils/helpers/text_helper.dart';
import '../../../../shared/horizontal_sized_box.dart';
import '../../../../utils/constants/string_value.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../data/models/IngredientHistory.dart';
import '../../../../shared/buttons/delete_icon_button.dart';
import '../../../../shared/pages/failed_page_placeholder.dart';
import '../widgets/ingredient_history_item.dart';
import '../controllers/ingredient_detail_controller.dart';

class IngredientDetailView extends GetView<IngredientDetailController> {
  const IngredientDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarLite(
        context: context,
        title: 'Detail Bahan Baku',
        backRoute: controller.backRoute,
        actions: [
          DeleteIconButton(
            onPressed: () {
              controller.data.deleteConfirmation();
            },
            tooltip: StringValue.DELETE_USER,
          ),
        ],
      ),
      body: Obx(() {
        Ingredient? ingredient = controller.data.selectedIngredient.value;
        List<IngredientHistory?> historyList =
            controller.data.selectedIngredientHistory;

        return ingredient == null
            ? FailedPagePlaceholder()
            : RefreshIndicator(
                child: SingleChildScrollView(
                  padding: horizontalPadding,
                  child: Column(
                    children: [
                      VerticalSizedBox(height: 2),
                      CustomCard(
                        content: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                customLabelText(
                                  text: StringValue.INGREDIENT_CODE,
                                ),
                                customLabelText(text: StringValue.STATUS),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                customCaptionText(text: ingredient.code),
                                StatusSign(
                                  status: ingredient.isActive,
                                  size: AppConstants.DEFAULT_FONT_SIZE.toInt(),
                                ),
                              ],
                            ),
                            VerticalSizedBox(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                customLabelText(
                                  text: StringValue.INGREDIENT_NAME,
                                ),
                                customLabelText(
                                  text: StringValue.CURRENT_PRICE,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                customCaptionText(
                                  text: normalizeName(ingredient.name),
                                ),
                                customCaptionText(
                                  text: 'Rp ${ingredient.priceString}/gr',
                                ),
                              ],
                            ),
                            VerticalSizedBox(height: 2,),
                            Row(
                              children: [
                                Expanded(
                                  child: TextButton(
                                    onPressed: () {
                                      Get.toNamed(Routes.INGREDIENT_INPUT);
                                    },
                                    style: backButtonStyle(),
                                    child: Text(StringValue.EDIT_DATA),
                                  ),
                                ),
                                HorizontalSizedBox(),
                                Expanded(
                                  child: TextButton(
                                    onPressed: () {
                                      controller.data.changeStatus();
                                    },
                                    style: ingredient.isActive
                                        ? errorButtonStyle()
                                        : nextButtonStyle(),
                                    child: Text(
                                      ingredient.isActive
                                          ? StringValue.DEACTIVATE
                                          : StringValue.ACTIVATE,
                                      style: AppTextStyle.buttonText,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      VerticalSizedBox(),
                      CustomCard(
                        content: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  customInputTitleText(
                                    text: 'Riwayat Perubahan',
                                  ),
                                  VerticalSizedBox(),
                                  ...List.generate(
                                    controller
                                        .data
                                        .selectedIngredientHistory
                                        .length,
                                    (index) {
                                      var item = historyList[index];
                                      return IngredientHistoryItem(
                                        first: index == 0,
                                        last: false,
                                        createdAt: item!.createdAt,
                                        content: item.content,
                                      );
                                    },
                                  ),
                                  IngredientHistoryItem(
                                    first: historyList.isEmpty ? true : false,
                                    last: true,
                                    createdAt: ingredient.createdAt,
                                    content: "Bahan dibuat.",
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      VerticalSizedBox(height: 5),
                    ],
                  ),
                ),
                onRefresh: () => controller.data.fetchIngredientHistory(),
              );
      }),
    );
  }
}
