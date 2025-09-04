import 'package:abg_pos_app/app/shared/custom_appbar_lite.dart';
import 'package:abg_pos_app/app/shared/vertical_sized_box.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/outlet_menu_pricing_detail_controller.dart';

class OutletMenuPricingDetailView
    extends GetView<OutletMenuPricingDetailController> {
  const OutletMenuPricingDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarLite(title: 'Detail Menu'),
      body: RefreshIndicator(
        onRefresh: () => Future.delayed(Durations.medium1),
        child: ListView(
          children: [
            const VerticalSizedBox(height: 2),
            //
          ],
        ),
      ),
    );
  }
}
