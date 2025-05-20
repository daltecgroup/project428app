import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:project428app/app/modules/gerai/controllers/outlet_detail_controller.dart';

class OutletDetailView extends GetView {
  const OutletDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    OutletDetailController c = Get.put(OutletDetailController());
    return Scaffold(
      appBar: AppBar(title: Text(Get.arguments.name), centerTitle: true),
      body: Center(
        child: Text(Get.arguments.name, style: const TextStyle(fontSize: 20)),
      ),
    );
  }
}
