import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../shared/custom_appbar.dart';
import '../../../../shared/custom_drawer.dart';
import '../controllers/spvarea_dashboard_controller.dart';

class SpvareaDashboardView extends GetView<SpvareaDashboardController> {
  const SpvareaDashboardView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('SPV Area'),
      drawer: customDrawer(context),
      body: const Center(
        child: Text(
          'Data Transaksi tidak ditemukan',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
