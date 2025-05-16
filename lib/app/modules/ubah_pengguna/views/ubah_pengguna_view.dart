import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/ubah_pengguna_controller.dart';

class UbahPenggunaView extends GetView<UbahPenggunaController> {
  const UbahPenggunaView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ubah Pengguna'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () {
            // Save action
            Get.back();
          },
        ),
      ),
      body: const Center(
        child: Text(
          'UbahPenggunaView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
