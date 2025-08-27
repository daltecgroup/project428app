import 'package:abg_pos_app/app/modules/_features/outlet_inventory/views/outlet_inventory_view.dart';
import 'package:abg_pos_app/app/routes/app_pages.dart';
import 'package:abg_pos_app/app/shared/custom_appbar.dart';
import 'package:abg_pos_app/app/shared/custom_drawer.dart';
import 'package:abg_pos_app/app/utils/helpers/text_helper.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/operator_outlet_inventory_controller.dart';

class OperatorOutletInventoryView
    extends GetView<OperatorOutletInventoryController> {
  const OperatorOutletInventoryView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: customAppBar(
          'Stok Gerai',
          subtitle: normalizeName(controller.currentOutletName),
          actionButton: IconButton(
            onPressed: () {
              Get.toNamed(Routes.OUTLET_INVENTORY_HISTORY);
            },
            icon: Icon(Icons.history),
          ),
        ),
        drawer: customDrawer(),
        body: OutletInventoryView(),
      );
    });
  }
}
