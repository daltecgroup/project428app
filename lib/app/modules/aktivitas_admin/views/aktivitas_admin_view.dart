import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/aktivitas_admin_controller.dart';

class AktivitasAdminView extends GetView<AktivitasAdminController> {
  const AktivitasAdminView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AktivitasAdminView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AktivitasAdminView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
