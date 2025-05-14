import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../constants.dart';
import '../../../widgets/admin/admin_appbar.dart';
import '../../../widgets/admin/admin_drawer.dart';
import '../controllers/stok_controller.dart';

class StokView extends GetView<StokController> {
  const StokView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AdminAppBar(context, "Stok"),
      drawer: AdminDrawer(context, kAdminMenuStok),
      body: const Center(
        child: Text('StokView is working', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
