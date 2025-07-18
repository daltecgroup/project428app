import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../shared/custom_appbar.dart';
import '../../../../shared/custom_drawer.dart';
import '../controllers/report_controller.dart';

class ReportView extends GetView<ReportController> {
  const ReportView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('Laporan'),
      drawer: customDrawer(context),
      body: const Center(
        child: Text('ReportView is working', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
