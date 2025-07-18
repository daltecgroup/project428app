import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/sale_controller.dart';

class SaleView extends GetView<SaleController> {
  const SaleView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SaleView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'SaleView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
