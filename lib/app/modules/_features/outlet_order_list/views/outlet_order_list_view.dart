import 'package:abg_pos_app/app/modules/_features/outlet_order_list/controllers/outlet_order_list_controller.dart';
import 'package:abg_pos_app/app/shared/custom_appbar_lite.dart';
import 'package:abg_pos_app/app/shared/pages/failed_page_placeholder.dart';
import 'package:abg_pos_app/app/utils/helpers/text_helper.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../data/models/Order.dart';
import '../../../../routes/app_pages.dart';
import '../../../../shared/buttons/floating_add_button.dart';
import '../../../../shared/pages/order_list/views/order_list.dart';

class OutletOrderListView extends GetView<OutletOrderListController> {
  const OutletOrderListView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final outlet = controller.outletData.currentOutlet;
      if (outlet == null) FailedPagePlaceholder();
      return Scaffold(
        appBar: customAppBarLite(
          title: 'Pesanan Gerai',
          subtitle: normalizeName(outlet!.name),
          backRoute: controller.backRoute,
        ),
        body: OrderList(controller: controller.listController),
        floatingActionButton: FloatingAddButton(
          onPressed: () {
            controller.data.selectedOrder.value = null as Order?;
            Get.toNamed(Routes.ORDER_INPUT);
          },
        ),
      );
    });
  }
}
