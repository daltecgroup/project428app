import 'package:abg_pos_app/app/utils/helpers/get_storage_helper.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../shared/pages/order_list/views/order_list.dart';
import '../../../../data/models/Order.dart';
import '../../../../routes/app_pages.dart';
import '../../../../shared/buttons/floating_add_button.dart';
import '../../../../shared/custom_appbar.dart';
import '../../../../shared/custom_drawer.dart';
import '../../../../shared/pages/order_list/controllers/order_list_controller.dart';
import '../../../../utils/constants/app_constants.dart';

class OrderListView extends GetView<OrderListController> {
  const OrderListView({super.key});
  @override
  Widget build(BuildContext context) {
    final BoxHelper box = BoxHelper();
    box.removeValue(AppConstants.KEY_CURRENT_OUTLET);
    return Scaffold(
      appBar: customAppBar('Pesanan'),
      drawer: customDrawer(context),
      body: OrderList(controller: controller),
      floatingActionButton: FloatingAddButton(
        onPressed: () {
          controller.data.selectedOrder.value = null as Order?;
          Get.toNamed(Routes.ORDER_INPUT);
        },
      ),
    );
  }
}
