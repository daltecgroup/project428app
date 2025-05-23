import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/homepage_franchisee_controller.dart';

class HomepageFranchiseeView extends GetView<HomepageFranchiseeController> {
  const HomepageFranchiseeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomepageFranchiseeView'),
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
