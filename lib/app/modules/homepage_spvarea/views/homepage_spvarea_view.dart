import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/homepage_spvarea_controller.dart';

class HomepageSpvareaView extends GetView<HomepageSpvareaController> {
  const HomepageSpvareaView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomepageSpvareaView'),
        centerTitle: true,
      ),
      body: Center(
        child: TextButton(
          onPressed: () {
            controller.AuthS.logout();
          },
          child: const Text('Logout'),
        ),
      ),
    );
  }
}
