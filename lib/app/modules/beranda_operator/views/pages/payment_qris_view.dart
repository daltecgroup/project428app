import 'package:flutter/material.dart';

import 'package:get/get.dart';

class PaymentQrisView extends GetView {
  const PaymentQrisView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PaymentQrisView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PaymentQrisView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
