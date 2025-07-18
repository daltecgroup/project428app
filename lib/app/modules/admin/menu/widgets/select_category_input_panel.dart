import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../controllers/menu_input_controller.dart';
import '../../../../utils/theme/custom_text.dart';
import '../../../../utils/helpers/text_helper.dart';
import '../../../../utils/constants/app_constants.dart';

class SelectCategoryInputPanel extends StatelessWidget {
  const SelectCategoryInputPanel({super.key, required this.controller});

  final MenuInputController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        customInputTitleText(text: 'Kategori'),
        SizedBox(height: 5),
        Material(
          elevation: 1,
          borderRadius: BorderRadius.circular(
            AppConstants.DEFAULT_BORDER_RADIUS,
          ),
          child: DropdownButtonFormField<String>(
            value: controller.selectedCategory.value,
            decoration: InputDecoration(
              isDense: true,
              filled: true,
              fillColor: Colors.grey[50],
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(
                  AppConstants.DEFAULT_BORDER_RADIUS,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  AppConstants.DEFAULT_BORDER_RADIUS,
                ),
                borderSide: BorderSide(
                  style: BorderStyle.solid,
                  color: Colors.transparent,
                ),
              ),
            ),
            items: [
              ...List.generate(
                controller.categoryData.categories.length,
                (index) => DropdownMenuItem(
                  value: controller.categoryData.categories[index].id,
                  onTap: () => controller.selectedCategory.value =
                      controller.categoryData.categories[index].id,
                  child: SizedBox(
                    width: Get.width - (AppConstants.DEFAULT_PADDING * 7),

                    child: Text(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      '${normalizeName(controller.categoryData.categories[index].name)} ${!controller.categoryData.categories[index].isActive ? '(Non Aktif)' : ''}',
                    ),
                  ),
                ),
              ),
            ],
            onChanged: (value) {},
          ),
        ),
      ],
    );
  }
}
