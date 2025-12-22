import 'package:abg_pos_app/app/shared/custom_appbar.dart';
import 'package:abg_pos_app/app/shared/custom_drawer.dart';
import 'package:abg_pos_app/app/shared/pages/order_list/views/order_list.dart';
import 'package:abg_pos_app/app/utils/helpers/outlet_helper.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';
import '../../../../shared/buttons/floating_add_button.dart';
import '../controllers/operator_order_list_controller.dart';

class OperatorOrderListView extends GetView<OperatorOrderListController> {
  const OperatorOrderListView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('Pesanan', subtitle: currentOutletName),
      drawer: customDrawer(),
      body: OrderList(controller: controller.listController),
      floatingActionButton: FloatingAddButton(
        onPressed: () {
          Get.toNamed(Routes.ORDER_INPUT);
        },
      ),
    );
  }
}
