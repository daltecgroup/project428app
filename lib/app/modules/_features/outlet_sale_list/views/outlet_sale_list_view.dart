import 'package:abg_pos_app/app/shared/custom_appbar_lite.dart';
import 'package:abg_pos_app/app/shared/pages/failed_page_placeholder.dart';
import 'package:abg_pos_app/app/utils/helpers/text_helper.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/outlet_sale_list_controller.dart';

class OutletSaleListView extends GetView<OutletSaleListController> {
  const OutletSaleListView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final outlet = controller.outletData.currentOutlet;
      if (outlet == null) return FailedPagePlaceholder();
      return Scaffold(
        appBar: customAppBarLite(
          title: 'Penjualan Gerai',
          subtitle: normalizeName(outlet.name),
        ),
        body: const Center(
          child: Text(
            'OutletSaleListView is working',
            style: TextStyle(fontSize: 20),
          ),
        ),
      );
    });
  }
}
