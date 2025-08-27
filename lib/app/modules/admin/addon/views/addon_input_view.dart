import 'package:abg_pos_app/app/utils/constants/padding_constants.dart';
import 'package:abg_pos_app/app/utils/helpers/number_helper.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import '../../../../routes/app_pages.dart';
import '../../../../data/models/Addon.dart';
import '../../../../shared/status_sign.dart';
import '../../../../shared/custom_card.dart';
import '../../../../utils/theme/custom_text.dart';
import '../../../../shared/custom_appbar_lite.dart';
import '../../../../shared/vertical_sized_box.dart';
import '../../../../utils/helpers/text_helper.dart';
import '../../../../utils/constants/string_value.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../shared/custom_input_with_error.dart';
import '../../../../shared/buttons/bottom_nav_button.dart';
import '../../../../modules/admin/addon/controllers/addon_input_controller.dart';

class AddonInputView extends GetView<AddonInputController> {
  const AddonInputView({super.key});
  @override
  Widget build(BuildContext context) {
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
    return Scaffold(
      appBar: customAppBarLite(
        context: context,
        title: controller.isEdit ? 'Ubah Add-on' : 'Tambah Add-on',
        backRoute: controller.isEdit ? Routes.ADDON_DETAIL : Routes.ADDON_LIST,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            // input field
            Obx(() {
              Addon? addon = controller.data.selectedAddon.value;
              return ListView(
                padding: horizontalPadding,
                children: [
                  VerticalSizedBox(height: 2),

                  // addon detail
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
                                text: normalizeName(addon!.name),
                              ),
                              StatusSign(
                                status: addon.isActive,
                                size: AppConstants.DEFAULT_FONT_SIZE.toInt(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  if (controller.isEdit) VerticalSizedBox(),

                  // data input field
                  CustomCard(
                    content: Column(
                      children: [
                        CustomInputWithError(
                          title: controller.isEdit
                              ? 'Nama Baru'
                              : StringValue.ADDON_NAME,
                          hint: StringValue.INPUT_ADDON_NAME,
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
                          title: StringValue.PRICE,
                          hint: StringValue.INPUT_PRICE,
                          controller: controller.priceC,
                          error: controller.priceError.value,
                          errorText: controller.priceErrorText.value,
                          inputFormatter: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                            LengthLimitingTextInputFormatter(6),
                          ],
                          onChanged: (value) =>
                              controller.priceError.value = false,
                        ),
                      ],
                    ),
                  ),
                  VerticalSizedBox(),
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
                                VerticalSizedBox(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  VerticalSizedBox(height: 10),
                ],
              );
            }),
            // nav button
            BottomNavButton(
              nextBtn: 'Simpan',
              nextCb: () => controller.submit(),
            ),
          ],
        ),
      ),
    );
  }
}
