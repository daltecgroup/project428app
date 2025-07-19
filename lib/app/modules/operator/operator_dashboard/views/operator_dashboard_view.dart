import 'package:abg_pos_app/app/shared/pages/failed_page_placeholder.dart';
import 'package:abg_pos_app/app/utils/helpers/text_helper.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../shared/custom_appbar.dart';
import '../../../../shared/custom_drawer.dart';
import '../controllers/operator_dashboard_controller.dart';

class OperatorDashboardView extends GetView<OperatorDashboardController> {
  const OperatorDashboardView({super.key});
  @override
  Widget build(BuildContext context) {
    final currentOutlet = controller.outletData.currentOutlet;
    return Obx(() {
      if (currentOutlet == null) FailedPagePlaceholder();
      return Scaffold(
        appBar: customAppBar(normalizeName(currentOutlet!.name)),
        drawer: customDrawer(),
        body: Center(child: Text('Selamat datang!')),
      );
    });
  }
}
