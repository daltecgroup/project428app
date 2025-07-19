import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../shared/custom_appbar.dart';
import '../../../../shared/custom_drawer.dart';
import '../controllers/franchisee_dashboard_controller.dart';

class FranchiseeDashboardView extends GetView<FranchiseeDashboardController> {
  const FranchiseeDashboardView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('Franchisee'),
      drawer: customDrawer(),
      body: const Center(
        child: Text('Selamat datang!', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
