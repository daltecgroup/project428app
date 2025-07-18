import 'package:abg_pos_app/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import '../../../../utils/helpers/number_helper.dart';
import '../controllers/bundle_input_controller.dart';
import '../../../../shared/custom_appbar_lite.dart';
import '../../../../shared/vertical_sized_box.dart';
import '../../../../shared/buttons/bottom_nav_button.dart';
import '../../../../shared/custom_card.dart';
import '../../../../shared/custom_input_with_error.dart';
import '../../../../shared/status_sign.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/constants/string_value.dart';
import '../../../../utils/helpers/text_helper.dart';
import '../../../../utils/theme/custom_text.dart';

class BundleInputView extends GetView<BundleInputController> {
  const BundleInputView({super.key});
  @override
  Widget build(BuildContext context) {
    Future.delayed(Durations.short4, () => controller.setEditData());
    return Scaffold(
      appBar: customAppBarLite(
        title: controller.isEdit ? 'Ubah Paket' : 'Tambah Paket',
        backRoute: controller.isEdit
            ? Routes.BUNDLE_DETAIL
            : Routes.BUNDLE_LIST,
      ),
      body: Stack(
        children: [
          Obx(() {
            final bundle = controller.data.selectedBundle.value;
            return ListView(
              padding: EdgeInsets.symmetric(
                horizontal: AppConstants.DEFAULT_PADDING,
              ),
              children: [
                const VerticalSizedBox(height: 2),

                // menu detail
                if (bundle != null) ...[
                  CustomCard(
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            customLabelText(text: 'Nama Lama'),
                            customCaptionText(text: normalizeName(bundle.name)),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            customLabelText(text: StringValue.STATUS),
                            StatusSign(
                              status: bundle.isActive,
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
                        title: bundle != null
                            ? 'Nama Baru'
                            : StringValue.BUNDLE_NAME,
                        hint: StringValue.INPUT_BUNDLE_NAME,
                        controller: controller.nameC,
                        error: controller.nameError.value,
                        errorText: controller.nameErrorText.value,
                        inputFormatter: <TextInputFormatter>[
                          LengthLimitingTextInputFormatter(50),
                        ],
                        onChanged: (_) => controller.nameError.value = false,
                      ),
                      const VerticalSizedBox(),
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
                        onChanged: (_) => controller.priceError.value = false,
                      ),
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

                // select category panel
                CustomCard(
                  content: Column(
                    children: [
                      Row(
                        mainAxisAlignment: controller.categoryList.isNotEmpty
                            ? MainAxisAlignment.spaceBetween
                            : MainAxisAlignment.center,
                        children: [
                          if (controller.categoryList.isNotEmpty)
                            customLabelText(text: 'Kategori'),
                          TextButton(
                            style: ButtonStyle(
                              visualDensity: VisualDensity.compact,
                            ),
                            onPressed: () async {
                              controller.addCategory();
                            },
                            child: Text(
                              controller.categoryList.isEmpty
                                  ? 'Tambah Kategori'
                                  : 'Ubah Kategori',
                            ),
                          ),
                        ],
                      ),
                      ...List.generate(
                        controller.categoryList.length,
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
                                      controller.categoryData.getCategoryName(
                                        controller
                                            .categoryList[index]
                                            .menuCategoryId,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '${inLocalNumber(controller.categoryList[index].qty)} item',
                                  ),
                                ],
                              ),
                            ),
                            if (controller.categoryList.length - 1 != index)
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
