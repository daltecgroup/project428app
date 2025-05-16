import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/pengaturan_admin_controller.dart';

class PengaturanAdminView extends GetView<PengaturanAdminController> {
  const PengaturanAdminView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PengaturanAdminView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PengaturanAdminView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
