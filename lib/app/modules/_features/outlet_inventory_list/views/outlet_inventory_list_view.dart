import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../shared/custom_appbar_lite.dart';
import '../../../../shared/pages/failed_page_placeholder.dart';
import '../../../../utils/helpers/text_helper.dart';
import '../../outlet_inventory/views/outlet_inventory_view.dart';
import '../controllers/outlet_inventory_list_controller.dart';

class OutletInventoryListView extends GetView<OutletInventoryListController> {
  const OutletInventoryListView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final outlet = controller.outletData.currentOutlet;
      if (outlet == null) FailedPagePlaceholder();
      return Scaffold(
        appBar: customAppBarLite(
          title: 'Stok Gerai',
          subtitle: normalizeName(outlet!.name),
          backRoute: controller.backRoute
        ),
        body: OutletInventoryView(),
      );
    });
  }
}
