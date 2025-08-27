import 'package:abg_pos_app/app/utils/constants/padding_constants.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../modules/admin/addon/controllers/addon_detail_controller.dart';
import '../../../../modules/admin/addon/widgets/addon_detail_info_panel.dart';
import '../../../../shared/panels/detail_image_panel.dart';
import '../../../../shared/panels/recipe_list_panel.dart';
import '../../../../data/models/Addon.dart';
import '../../../../shared/vertical_sized_box.dart';
import '../../../../shared/buttons/delete_icon_button.dart';
import '../../../../shared/custom_appbar_lite.dart';
import '../../../../shared/pages/failed_page_placeholder.dart';
import '../../../../utils/constants/string_value.dart';
import '../../../../utils/helpers/time_helper.dart';
import '../../../../utils/theme/custom_text.dart';

class AddonDetailView extends GetView<AddonDetailController> {
  const AddonDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarLite(
        context: context,
        title: 'Detail Add-on',
        backRoute: controller.backRoute,
        actions: [
          DeleteIconButton(
            onPressed: () {
              controller.data.deleteConfirmation();
            },
            tooltip: StringValue.DELETE_ADDON,
          ),
        ],
      ),
      body: Obx(() {
        Addon? addon = controller.data.selectedAddon.value;
        return addon == null
            ? FailedPagePlaceholder()
            : RefreshIndicator(
                child: SingleChildScrollView(
                  padding: horizontalPadding,
                  child: Column(
                    children: [
                      VerticalSizedBox(height: 2),

                      // image panel
                      DetailImagePanel(),

                      // data panel
                      AddonDetailInfoPanel(
                        addon: addon,
                        controller: controller.data,
                      ),
                      VerticalSizedBox(),

                      // recipe list panel
                      RecipeListPanel(
                        recipeList: controller.data.selectedAddon.value!.recipe,
                      ),

                      VerticalSizedBox(),
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
                onRefresh: () => controller.data.syncData(refresh: true),
              );
      }),
    );
  }
}
