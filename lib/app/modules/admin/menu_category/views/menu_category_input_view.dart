import 'package:abg_pos_app/app/data/models/MenuCategory.dart';
import 'package:abg_pos_app/app/modules/admin/menu_category/controllers/menu_category_input_controller.dart';
import 'package:abg_pos_app/app/shared/custom_card.dart';
import 'package:abg_pos_app/app/shared/vertical_sized_box.dart';
import 'package:abg_pos_app/app/utils/helpers/text_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';
import '../../../../shared/buttons/bottom_nav_button.dart';
import '../../../../shared/custom_appbar_lite.dart';
import '../../../../shared/custom_input_with_error.dart';
import '../../../../shared/status_sign.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/constants/string_value.dart';
import '../../../../utils/theme/custom_text.dart';

class MenuCategoryInputView extends GetView<MenuCategoryInputController> {
  const MenuCategoryInputView({super.key});
  @override
  Widget build(BuildContext context) {
    if (!controller.isEdit)
      Future.delayed(
        Duration(milliseconds: 200),
        () => controller.clearField(),
      );
    return Scaffold(
      appBar: customAppBarLite(
        context: context,
        title: controller.isEdit
            ? 'Ubah Kategori Menu'
            : 'Tambah Kategori Menu',
        backRoute: controller.isEdit
            ? Routes.MENU_CATEGORY_LIST
            : Routes.MENU_CATEGORY_LIST,
      ),
      body: Stack(
        children: [
          // input field
          Obx(() {
            MenuCategory? category = controller.data.selectedMenuCategory.value;

            return ListView(
              padding: EdgeInsetsGeometry.symmetric(
                horizontal: AppConstants.DEFAULT_PADDING,
              ),
              children: [
                VerticalSizedBox(height: 2),
                if (controller.isEdit)
                  CustomCard(
                    content: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            customLabelText(text: 'Nama Lama'),
                            customLabelText(text: StringValue.STATUS),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            customCaptionText(
                              text: normalizeName(category!.name),
                            ),
                            StatusSign(
                              status: category.isActive,
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
                        title: controller.isEdit
                            ? 'Nama Baru'
                            : StringValue.MENU_CATEGORY_NAME,
                        hint: StringValue.INPUT_MENU_CATEGORY_NAME,
                        controller: controller.nameC,
                        error: controller.nameError.value,
                        errorText: controller.nameErrorText.value,
                        inputFormatter: <TextInputFormatter>[
                          LengthLimitingTextInputFormatter(50),
                        ],
                        onChanged: (value) =>
                            controller.nameError.value = false,
                      ),
                    ],
                  ),
                ),
                VerticalSizedBox(height: 10),
              ],
            );
          }),

          //nav button
          BottomNavButton(nextBtn: 'Simpan', nextCb: () => controller.submit()),
        ],
      ),
    );
  }
}
