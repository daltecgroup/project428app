import 'package:abg_pos_app/app/modules/admin/menu/controllers/menu_detail_controller.dart';
import 'package:abg_pos_app/app/modules/admin/menu/widgets/menu_detail_info_panel.dart';
import 'package:abg_pos_app/app/utils/constants/padding_constants.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../data/models/Menu.dart';
import '../../../../shared/buttons/delete_icon_button.dart';
import '../../../../shared/custom_appbar_lite.dart';
import '../../../../shared/pages/failed_page_placeholder.dart';
import '../../../../shared/panels/detail_image_panel.dart';
import '../../../../shared/panels/recipe_list_panel.dart';
import '../../../../shared/vertical_sized_box.dart';
import '../../../../utils/constants/string_value.dart';
import '../../../../utils/helpers/time_helper.dart';
import '../../../../utils/theme/custom_text.dart';

class MenuDetailView extends GetView<MenuDetailController> {
  const MenuDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarLite(
        context: context,
        title: 'Detail Menu',
        backRoute: controller.backRoute,
        actions: [
          DeleteIconButton(
            onPressed: () {
              controller.data.deleteConfirmation();
            },
            tooltip: StringValue.DELETE_MENU,
          ),
        ],
      ),
      body: Obx(() {
        Menu? menu = controller.data.selectedMenu.value;
        Future.delayed(
          Duration(milliseconds: 100),
          () => controller.setRecipe(),
        );

        if (menu == null) return FailedPagePlaceholder();
        return RefreshIndicator(
          onRefresh: () => controller.data.syncData(refresh: true),
          child: SingleChildScrollView(
            padding: horizontalPadding,
            child: Column(
              children: [
                VerticalSizedBox(height: 2),

                // image panel
                DetailImagePanel(),

                // data panel
                MenuDetailInfoPanel(
                  menu: menu,
                  controller: controller.data,
                  categoryController: controller.categoryData,
                ),
                VerticalSizedBox(),

                // recipe list panel
                RecipeListPanel(recipeList: controller.recipeList),

                VerticalSizedBox(height: 2),
                if (controller.data.latestSync.value != null)
                  customFooterText(
                    textAlign: TextAlign.center,
                    text:
                        'Diperbarui ${contextualLocalDateTimeFormat(controller.data.latestSync.value!)}',
                  ),
                VerticalSizedBox(height: 10),
              ],
            ),
          ),
        );
      }),
    );
  }
}
