import 'package:flutter/material.dart';

import 'package:get/get.dart';

class AddMenuPageView extends GetView {
  const AddMenuPageView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AddMenuPageView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AddMenuPageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
