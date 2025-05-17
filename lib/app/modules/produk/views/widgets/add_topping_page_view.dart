import 'package:flutter/material.dart';

import 'package:get/get.dart';

class AddToppingPageView extends GetView {
  const AddToppingPageView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AddToppingPageView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AddToppingPageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
