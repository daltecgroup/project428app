import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../controllers/addon_data_controller.dart';
import '../../../../data/models/Addon.dart';
import '../../../../routes/app_pages.dart';
import '../../../../shared/custom_card.dart';
import '../../../../shared/horizontal_sized_box.dart';
import '../../../../shared/status_sign.dart';
import '../../../../shared/vertical_sized_box.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/constants/string_value.dart';
import '../../../../utils/helpers/number_helper.dart';
import '../../../../utils/helpers/text_helper.dart';
import '../../../../utils/theme/button_style.dart';
import '../../../../utils/theme/custom_text.dart';
import '../../../../utils/theme/text_style.dart';

class AddonDetailInfoPanel extends StatelessWidget {
  const AddonDetailInfoPanel({
    super.key,
    required this.addon,
    required this.controller,
  });

  final Addon addon;
  final AddonDataController controller;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      flatTop: false,
      content: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              customLabelText(text: StringValue.ADDON_CODE),
              customLabelText(text: StringValue.STATUS),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              customCaptionText(text: addon.code),
              StatusSign(
                status: addon.isActive,
                size: AppConstants.DEFAULT_FONT_SIZE.toInt(),
              ),
            ],
          ),
          VerticalSizedBox(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              customLabelText(text: StringValue.ADDON_NAME),
              customLabelText(text: StringValue.PRICE),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              customCaptionText(text: normalizeName(addon.name)),
              customCaptionText(text: inRupiah(addon.price)),
            ],
          ),
          VerticalSizedBox(),
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () {
                    Get.toNamed(Routes.ADDON_INPUT);
                  },
                  style: backButtonStyle(),
                  child: Text(StringValue.EDIT_DATA),
                ),
              ),
              HorizontalSizedBox(),
              Expanded(
                child: TextButton(
                  onPressed: () {
                    controller.changeStatus(addon.id, !addon.isActive);
                  },
                  style: addon.isActive
                      ? errorButtonStyle()
                      : nextButtonStyle(),
                  child: Text(
                    addon.isActive
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
    );
  }
}
