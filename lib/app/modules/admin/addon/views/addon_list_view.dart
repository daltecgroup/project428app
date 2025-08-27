import 'package:abg_pos_app/app/shared/custom_appbar_lite.dart';
import 'package:abg_pos_app/app/shared/custom_nav_item.dart';
import 'package:abg_pos_app/app/shared/vertical_sized_box.dart';
import 'package:abg_pos_app/app/utils/constants/app_constants.dart';
import 'package:abg_pos_app/app/utils/constants/padding_constants.dart';
import 'package:abg_pos_app/app/utils/helpers/number_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

import 'package:get/get.dart';

import '../../../../data/models/Addon.dart';
import '../../../../routes/app_pages.dart';
import '../../../../shared/buttons/floating_add_button.dart';
import '../../../../utils/helpers/time_helper.dart';
import '../../../../utils/theme/custom_text.dart';
import '../controllers/addon_list_controller.dart';

class AddonListView extends GetView<AddonListController> {
  const AddonListView({super.key});
  @override
  Widget build(BuildContext context) {
    var svg = Svg(AppConstants.IMG_PLACEHOLDER);
    return Scaffold(
      appBar: customAppBarLite(
        context: context,
        title: 'Add-on',
        backRoute: controller.backRoute,
      ),
      body: RefreshIndicator(
        child: Obx(() {
          var activeAddons = controller.filteredAddons(status: true);
          var deactiveAddons = controller.filteredAddons(status: false);
          if (controller.data.isLoading.value) {
            Center(child: CircularProgressIndicator());
          }
          if (controller.data.addons.isEmpty) {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  customListTitleText(text: 'Add-on Kosong'),
                  TextButton(
                    onPressed: () {
                      controller.data.syncData(refresh: true);
                    },
                    child: Text('Muat Ulang'),
                  ),
                ],
              ),
            );
          }
          return ListView(
            padding: horizontalPadding,
            children: [
              VerticalSizedBox(height: 2),
              if (activeAddons.isNotEmpty)
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: List.generate(
                    activeAddons.length,
                    (index) => CustomNavItem(
                      image: svg,
                      title: activeAddons[index].name.capitalize!,
                      subTitle: inRupiah(activeAddons[index].price),
                      onTap: () {
                        controller.data.selectedAddon.value =
                            activeAddons[index];
                        Get.toNamed(Routes.ADDON_DETAIL);
                      },
                    ),
                  ),
                ),
              if (deactiveAddons.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    VerticalSizedBox(),
                    customListHeaderText(text: 'Addon Nonaktif'),
                    VerticalSizedBox(),
                    ...List.generate(
                      deactiveAddons.length,
                      (index) => CustomNavItem(
                        image: svg,
                        title: deactiveAddons[index].name.capitalize!,
                        subTitle: inRupiah(deactiveAddons[index].price),
                        onTap: () {
                          controller.data.selectedAddon.value =
                              deactiveAddons[index];
                          Get.toNamed(Routes.ADDON_DETAIL);
                        },
                      ),
                    ),
                  ],
                ),
              VerticalSizedBox(),
              if (controller.data.latestSync.value != null)
                customFooterText(
                  textAlign: TextAlign.center,
                  text:
                      'Diperbarui ${contextualLocalDateTimeFormat(controller.data.latestSync.value!)}',
                ),
              VerticalSizedBox(height: 5),
            ],
          );
        }),
        onRefresh: () => controller.refreshCategories(),
      ),
      floatingActionButton: FloatingAddButton(
        tooltip: 'Tambah Kategori Menu',
        onPressed: () {
          controller.data.selectedAddon.value = null as Addon?;
          Get.toNamed(Routes.ADDON_INPUT);
        },
      ),
    );
  }
}
