import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/unauthorized_controller.dart';

class UnauthorizedView extends GetView<UnauthorizedController> {
  const UnauthorizedView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UnauthorizedView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'UnauthorizedView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
