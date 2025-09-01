import 'package:abg_pos_app/app/utils/constants/padding_constants.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../shared/horizontal_sized_box.dart';
import '../../../../routes/app_pages.dart';
import '../../../../shared/buttons/bottom_nav_button.dart';
import '../../../../shared/custom_appbar_lite.dart';
import '../../../../shared/custom_card.dart';
import '../../../../shared/custom_input_with_error.dart';
import '../../../../shared/status_sign.dart';
import '../../../../shared/vertical_sized_box.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/constants/string_value.dart';
import '../../../../utils/helpers/number_helper.dart';
import '../../../../utils/helpers/text_helper.dart';
import '../../../../utils/theme/custom_text.dart';
import '../controllers/menu_input_controller.dart';
import '../widgets/select_category_input_panel.dart';

class MenuInputView extends GetView<MenuInputController> {
  const MenuInputView({super.key});
  @override
  Widget build(BuildContext context) {
    if (Get.isRegistered<MenuInputController>()) {
      if (!controller.isEdit)
        Future.delayed(
          Duration(milliseconds: 200),
          () => controller.clearField(),
        );
      if (controller.isEdit)
        Future.delayed(
          Duration(milliseconds: 200),
          () => controller.setEditData(),
        );
    }
    return Scaffold(
      appBar: customAppBarLite(
        context: context,
        title: controller.isEdit ? 'Ubah Menu' : 'Tambah Menu',
        backRoute: controller.isEdit ? Routes.MENU_DETAIL : Routes.MENU_LIST,
      ),
      body: Stack(
        children: [
          // input field
          Obx(() {
            final menu = controller.data.selectedMenu.value;
            return ListView(
              padding: horizontalPadding,
              children: [
                const VerticalSizedBox(height: 2),

                // menu detail
                if (controller.isEdit) ...[
                  CustomCard(
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            customLabelText(text: 'Nama Lama'),
                            customCaptionText(text: normalizeName(menu!.name)),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            customLabelText(text: StringValue.STATUS),
                            StatusSign(
                              status: menu.isActive,
                              size: AppConstants.DEFAULT_FONT_SIZE.toInt(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const VerticalSizedBox(),
                ],

                // data input field
                CustomCard(
                  content: Column(
                    children: [
                      CustomInputWithError(
                        title: controller.isEdit
                            ? 'Nama Baru'
                            : StringValue.MENU_NAME,
                        hint: StringValue.INPUT_MENU_NAME,
                        controller: controller.nameC,
                        error: controller.nameError.value,
                        errorText: controller.nameErrorText.value,
                        inputFormatter: <TextInputFormatter>[
                          LengthLimitingTextInputFormatter(50),
                        ],
                        onChanged: (_) => controller.nameError.value = false,
                      ),
                      const VerticalSizedBox(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: CustomInputWithError(
                              title: StringValue.PRICE,
                              hint: StringValue.INPUT_PRICE,
                              maxLines: 1,
                              controller: controller.priceC,
                              error: controller.priceError.value,
                              errorText: controller.priceErrorText.value,
                              inputFormatter: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(
                                  RegExp("[0-9]"),
                                ),
                                LengthLimitingTextInputFormatter(6),
                              ],
                              onChanged: (_) =>
                                  controller.priceError.value = false,
                            ),
                          ),
                          const HorizontalSizedBox(),
                          Expanded(
                            child: CustomInputWithError(
                              title: StringValue.DISCOUNT,
                              hint: StringValue.INPUT_DISCOUNT,
                              maxLines: 1,
                              controller: controller.discountC,
                              error: controller.discountError.value,
                              errorText: controller.discountErrorText.value,
                              inputFormatter: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(
                                  RegExp("[0-9]"),
                                ),
                                LengthLimitingTextInputFormatter(6),
                              ],
                              onChanged: (_) =>
                                  controller.discountError.value = false,
                            ),
                          ),
                        ],
                      ),
                      const VerticalSizedBox(),
                      SelectCategoryInputPanel(controller: controller),
                      const VerticalSizedBox(),
                      CustomInputWithError(
                        title: StringValue.DESCRIPTION,
                        controller: controller.descriptionC,
                        error: controller.descriptionError.value,
                        errorText: controller.descriptionErrorText.value,
                        inputFormatter: <TextInputFormatter>[
                          LengthLimitingTextInputFormatter(280),
                        ],
                        onChanged: (value) =>
                            controller.descriptionError.value = false,
                      ),
                    ],
                  ),
                ),
                const VerticalSizedBox(),
                CustomCard(
                  content: Column(
                    children: [
                      Row(
                        mainAxisAlignment: controller.recipeList.isNotEmpty
                            ? MainAxisAlignment.spaceBetween
                            : MainAxisAlignment.center,
                        children: [
                          if (controller.recipeList.isNotEmpty)
                            customLabelText(text: 'Bahan'),
                          TextButton(
                            style: ButtonStyle(
                              visualDensity: VisualDensity.compact,
                            ),
                            onPressed: () async {
                              controller.addIngredients();
                            },
                            child: Text(
                              controller.recipeList.isEmpty
                                  ? 'Tambah Bahan'
                                  : 'Ubah Komposisi',
                            ),
                          ),
                        ],
                      ),
                      ...List.generate(
                        controller.recipeList.length,
                        (index) => Column(
                          children: [
                            CustomCard(
                              padding: 12,
                              content: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    normalizeName(
                                      controller
                                          .recipeList[index]
                                          .ingredient
                                          .name,
                                    ),
                                  ),
                                  Text(
                                    '${inLocalNumber(controller.recipeList[index].qty)} gram',
                                  ),
                                ],
                              ),
                            ),
                            if (controller.recipeList.length - 1 != index)
                              const VerticalSizedBox(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const VerticalSizedBox(height: 10),
              ],
            );
          }),

          // nav button
          SafeArea(
            child: BottomNavButton(
              nextBtn: 'Simpan',
              nextCb: () => controller.submit(),
            ),
          ),
        ],
      ),
    );
  }
}
