import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../constants.dart';
import '../../../widgets/admin/admin_appbar.dart';
import '../../../widgets/admin/admin_drawer.dart';
import '../controllers/operator_controller.dart';

class OperatorView extends GetView<OperatorController> {
  const OperatorView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AdminAppBar(context, "Operator"),
      drawer: AdminDrawer(context, kAdminMenuOperator),
      body: const Center(
        child: Text('OperatorView is working', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
