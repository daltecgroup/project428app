import 'package:flutter/material.dart';

import 'package:get/get.dart';

class PaymentTransferView extends GetView {
  const PaymentTransferView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PaymentTransferView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PaymentTransferView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
