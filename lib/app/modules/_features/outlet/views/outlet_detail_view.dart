import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../shared/pages/failed_page_placeholder.dart';
import '../../../../shared/buttons/delete_icon_button.dart';
import '../../../../shared/custom_appbar_lite.dart';
import '../../../../utils/constants/string_value.dart';
import '../../../../utils/helpers/text_helper.dart';
import '../views/tabs/outlet_overview_tab.dart';
import '../views/tabs/outlet_setting_tab.dart';
import '../widgets/outlet_detail_bottom_nav_bar.dart';
import '../controllers/outlet_detail_controller.dart';

class OutletDetailView extends GetView<OutletDetailController> {
  const OutletDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final outlet = controller.data.selectedOutlet.value;
      if (outlet == null) return FailedPagePlaceholder();
      return Scaffold(
        appBar: customAppBarLite(
          context: context,
          title: normalizeName(outlet.name),
          backRoute: controller.backRoute,
          actions: [
            if (controller.selectedTab.value == 1)
              DeleteIconButton(
                onPressed: () {
                  controller.data.deleteConfirmation();
                },
                tooltip: StringValue.DELETE_OUTLET,
              ),
          ],
        ),
        body: [
          OutletOverviewTab(c: controller),
          OutletSettingTab(c: controller),
        ].elementAt(controller.selectedTab.value),
        bottomNavigationBar: OutletDetailBottomNavBar(controller: controller),
      );
    });
  }
}
