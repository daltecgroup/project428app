import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../controllers/menu_category_data_controller.dart';
import '../../../../controllers/menu_data_controller.dart';
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
import '../../../../data/models/Menu.dart';

class MenuDetailInfoPanel extends StatelessWidget {
  const MenuDetailInfoPanel({
    super.key,
    required this.menu,
    required this.controller,
    required this.categoryController,
  });

  final Menu menu;
  final MenuDataController controller;
  final MenuCategoryDataController categoryController;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      flatTop: true,
      content: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              customLabelText(text: StringValue.MENU_CODE),
              customLabelText(text: StringValue.STATUS),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              customCaptionText(text: menu.code),
              StatusSign(
                status: menu.isActive,
                size: AppConstants.DEFAULT_FONT_SIZE.toInt(),
              ),
            ],
          ),
          const VerticalSizedBox(),

          // menu name and discount
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              customLabelText(text: StringValue.MENU_NAME),
              customLabelText(text: StringValue.DISCOUNT),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              customCaptionText(text: normalizeName(menu.name)),
              customCaptionText(
                text: menu.discount == double.parse(0.toString())
                    ? '-'
                    : '${inLocalNumber(menu.discount)}%',
              ),
            ],
          ),
          const VerticalSizedBox(),

          // category and price
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              customLabelText(text: StringValue.CATEGORY),
              customLabelText(text: StringValue.FINAL_PRICE),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              customCaptionText(
                text: normalizeName(
                  categoryController.getCategoryName(menu.menuCategoryId),
                ),
              ),
              customCaptionText(
                text: inRupiah(menu.price - (menu.price * menu.discount / 100)),
              ),
            ],
          ),
          const VerticalSizedBox(),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [customLabelText(text: StringValue.DESCRIPTION)],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: customCaptionText(
                  text: menu.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
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
                    Get.toNamed(Routes.MENU_INPUT);
                  },
                  style: backButtonStyle(),
                  child: Text(StringValue.EDIT_DATA),
                ),
              ),
              HorizontalSizedBox(),
              Expanded(
                child: TextButton(
                  onPressed: () {
                    controller.changeStatus(menu.id, !menu.isActive);
                  },
                  style: menu.isActive ? errorButtonStyle() : nextButtonStyle(),
                  child: Text(
                    menu.isActive
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
