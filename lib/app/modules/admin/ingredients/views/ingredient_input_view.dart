import 'package:abg_pos_app/app/modules/admin/ingredients/controllers/ingredient_input_controller.dart';
import 'package:abg_pos_app/app/routes/app_pages.dart';
import 'package:abg_pos_app/app/shared/buttons/bottom_nav_button.dart';
import 'package:abg_pos_app/app/shared/custom_appbar_lite.dart';
import 'package:abg_pos_app/app/shared/custom_card.dart';
import 'package:abg_pos_app/app/utils/constants/padding_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import '../../../../data/models/Ingredient.dart';
import '../../../../shared/custom_input_with_error.dart';
import '../../../../shared/status_sign.dart';
import '../../../../shared/vertical_sized_box.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/constants/string_value.dart';
import '../../../../utils/theme/custom_text.dart';

class IngredientInputView extends GetView<IngredientInputController> {
  const IngredientInputView({super.key});
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(milliseconds: 200), () => controller.setEditData());
    return Scaffold(
      appBar: customAppBarLite(
        context: context,
        title: controller.isEdit ? 'Ubah Bahan Baku' : 'Tambah Bahan Baku',
        backRoute: controller.isEdit
            ? Routes.INGREDIENT_DETAIL
            : Routes.INGREDIENT_LIST,
      ),
      body: Stack(
        children: [
          // main content
          Obx(() {
            Ingredient? ingredient = controller.data.selectedIngredient.value;
            return ListView(
              padding: horizontalPadding,
              children: [
                VerticalSizedBox(height: 2),
                if (controller.isEdit)
                  CustomCard(
                    content: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            customLabelText(text: StringValue.INGREDIENT_CODE),
                            customLabelText(text: StringValue.STATUS),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            customCaptionText(text: ingredient!.code),
                            StatusSign(
                              status: ingredient.isActive,
                              size: AppConstants.DEFAULT_FONT_SIZE.toInt(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                if (controller.isEdit) VerticalSizedBox(),
                CustomCard(
                  content: Column(
                    children: [
                      CustomInputWithError(
                        title: StringValue.INGREDIENT_NAME,
                        hint: StringValue.INPUT_INGREDIENT_NAME,
                        controller: controller.nameC,
                        error: controller.nameError.value,
                        errorText: controller.nameErrorText.value,
                        inputFormatter: <TextInputFormatter>[
                          LengthLimitingTextInputFormatter(50),
                        ],
                        onChanged: (value) =>
                            controller.nameError.value = false,
                      ),
                      VerticalSizedBox(),
                      CustomInputWithError(
                        title: 'Harga per gram',
                        hint: 'Masukkan harga per gram',
                        controller: controller.priceC,
                        error: controller.priceError.value,
                        errorText: controller.priceErrorText.value,
                        inputType: TextInputType.number,
                        inputFormatter: <TextInputFormatter>[
                          LengthLimitingTextInputFormatter(9),
                        ],
                        onChanged: (value) =>
                            controller.priceError.value = false,
                      ),
                    ],
                  ),
                ),
                VerticalSizedBox(height: 10),
              ],
            );
          }),
          // navigation
          BottomNavButton(nextBtn: 'Simpan', nextCb: () => controller.submit()),
        ],
      ),
    );
  }
}
