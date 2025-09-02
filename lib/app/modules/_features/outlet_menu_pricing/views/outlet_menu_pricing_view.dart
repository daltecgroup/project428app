import 'package:abg_pos_app/app/shared/custom_appbar_lite.dart';
import 'package:abg_pos_app/app/shared/vertical_sized_box.dart';
import 'package:abg_pos_app/app/utils/constants/padding_constants.dart';
import 'package:abg_pos_app/app/utils/helpers/text_helper.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../shared/pages/failed_page_placeholder.dart';
import '../controllers/outlet_menu_pricing_controller.dart';

class OutletMenuPricingView extends GetView<OutletMenuPricingController> {
  const OutletMenuPricingView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final outlet = controller.outletData.currentOutlet;
      if (outlet == null) FailedPagePlaceholder();
      return Scaffold(
        appBar: customAppBarLite(
          title: 'Harga Jual',
          subtitle: normalizeName(outlet!.name),
        ),
        body: ListView(
          padding: horizontalPadding,
          children: [
            const VerticalSizedBox(height: 2),

            //
          ],
        ),
      );
    });
  }
}
