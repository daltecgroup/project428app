import 'package:abg_pos_app/app/modules/admin/promo/controllers/bundle_list_controller.dart';
import 'package:abg_pos_app/app/shared/buttons/floating_add_button.dart';
import 'package:abg_pos_app/app/shared/custom_appbar_lite.dart';
import 'package:abg_pos_app/app/shared/custom_nav_item.dart';
import 'package:abg_pos_app/app/shared/pages/empty_list_page.dart';
import 'package:abg_pos_app/app/shared/status_sign.dart';
import 'package:abg_pos_app/app/shared/vertical_sized_box.dart';
import 'package:abg_pos_app/app/utils/constants/app_constants.dart';
import 'package:abg_pos_app/app/utils/helpers/text_helper.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';
import '../../../../utils/helpers/time_helper.dart';
import '../../../../utils/theme/custom_text.dart';

class BundleListView extends GetView<BundleListController> {
  const BundleListView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarLite(title: 'Paket Menu', backRoute: Routes.PROMO),
      body: RefreshIndicator(
        onRefresh: () => controller.refreshData(),
        child: Obx(() {
          final bundles = controller.data.bundles.map((e) => e).toList();
          if (bundles.isEmpty)
            return EmptyListPage(
              refresh: () => controller.refreshData(),
              text: 'Paket Menu Kosong',
            );
          return ListView(
            padding: EdgeInsets.symmetric(
              horizontal: AppConstants.DEFAULT_PADDING,
            ),
            children: [
              const VerticalSizedBox(height: 2),
              ...bundles.map((bundle) {
                return CustomNavItem(
                  leading: Icon(Icons.local_offer_rounded),
                  title: normalizeName(bundle.name),
                  subTitle: bundle.description,
                  trailing: StatusSign(
                    status: bundle.isActive,
                    size: AppConstants.DEFAULT_FONT_SIZE.round(),
                  ),
                  onTap: () {
                    controller.data.selectedBundle.value = bundle;
                    Get.toNamed(Routes.BUNDLE_DETAIL);
                  },
                );
              }),
              const VerticalSizedBox(),
              if (controller.data.latestSync.value != null)
                customFooterText(
                  textAlign: TextAlign.center,
                  text:
                      'Diperbarui ${contextualLocalDateTimeFormat(controller.data.latestSync.value!)}',
                ),
              const VerticalSizedBox(height: 5),
            ],
          );
        }),
      ),
      floatingActionButton: FloatingAddButton(
        tooltip: 'Tambah Paket',
        onPressed: () {
          controller.data.selectedBundle.value = null;
          controller.data.selectedBundle.refresh();
          Get.toNamed(Routes.BUNDLE_INPUT);
        },
      ),
    );
  }
}
