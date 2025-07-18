import 'package:abg_pos_app/app/controllers/outlet_data_controller.dart';
import 'package:abg_pos_app/app/routes/app_pages.dart';
import 'package:abg_pos_app/app/shared/custom_card.dart';
import 'package:abg_pos_app/app/shared/horizontal_sized_box.dart';
import 'package:abg_pos_app/app/shared/status_sign.dart';
import 'package:abg_pos_app/app/shared/vertical_sized_box.dart';
import 'package:abg_pos_app/app/utils/constants/app_constants.dart';
import 'package:abg_pos_app/app/utils/constants/string_value.dart';
import 'package:abg_pos_app/app/utils/helpers/text_helper.dart';
import 'package:abg_pos_app/app/utils/helpers/time_helper.dart';
import 'package:abg_pos_app/app/utils/theme/button_style.dart';
import 'package:abg_pos_app/app/utils/theme/custom_text.dart';
import 'package:abg_pos_app/app/utils/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/models/Outlet.dart';

class OutletDetailInfoPanel extends StatelessWidget {
  const OutletDetailInfoPanel({
    super.key,
    required this.outlet,
    required this.controller,
  });

  final Outlet outlet;
  final OutletDataController controller;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      flatTop: true,
      content: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              customLabelText(text: StringValue.OUTLET_CODE),
              customLabelText(text: StringValue.STATUS),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              customCaptionText(text: outlet.code),
              StatusSign(
                status: outlet.isActive,
                size: AppConstants.DEFAULT_FONT_SIZE.toInt(),
              ),
            ],
          ),
          const VerticalSizedBox(),

          // menu name and created at
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              customLabelText(text: StringValue.OUTLET_NAME),
              customLabelText(text: StringValue.CREATED_AT),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              customCaptionText(text: normalizeName(outlet.name)),
              customCaptionText(
                text: normalizeName(localDateFormat(outlet.createdAt)),
              ),
            ],
          ),
          const VerticalSizedBox(),

          // address
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [customLabelText(text: StringValue.ADDRESS)],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: customCaptionText(
                  maxLines: 2,
                  text:
                      '${normalizeName(outlet.address.street)}, ${normalizeName(outlet.address.village)}, ${normalizeName(outlet.address.district)}, ${normalizeName(outlet.address.regency.toLowerCase())}, ${normalizeName(outlet.address.province.toLowerCase())}',
                ),
              ),
            ],
          ),
          const VerticalSizedBox(),

          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () {
                    Get.toNamed(Routes.OUTLET_INPUT);
                  },
                  style: backButtonStyle(),
                  child: Text(StringValue.EDIT_DATA),
                ),
              ),
              HorizontalSizedBox(),
              Expanded(
                child: TextButton(
                  onPressed: () {
                    controller.changeStatus(outlet.id, !outlet.isActive);
                  },
                  style: outlet.isActive
                      ? errorButtonStyle()
                      : nextButtonStyle(),
                  child: Text(
                    outlet.isActive
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
