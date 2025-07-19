import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../shared/vertical_sized_box.dart';
import '../../../../utils/constants/app_constants.dart';
import '../widgets/outlet_inventory_item.dart';
import '../controllers/outlet_inventory_controller.dart';

class OutletInventoryView extends GetView<OutletInventoryController> {
  const OutletInventoryView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: AppConstants.DEFAULT_PADDING),
        children: [
          const VerticalSizedBox(height: 2),
          // stok list
          OutletInventoryItem(title: 'bahan baku', qty: 1000),
          OutletInventoryItem(title: 'bahan baku', qty: 600),
          OutletInventoryItem(title: 'bahan baku', qty: 120),
        ],
      ),
    );
  }
}
