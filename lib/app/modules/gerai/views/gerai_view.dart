import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../constants.dart';
import '../../../widgets/admin/admin_appbar.dart';
import '../../../widgets/admin/admin_drawer.dart';
import '../controllers/gerai_controller.dart';

class GeraiView extends GetView<GeraiController> {
  const GeraiView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AdminAppBar(context, "Gerai"),
      drawer: AdminDrawer(context, kAdminMenuGerai),
      body: const Center(child: Text('Kosong', style: TextStyle(fontSize: 20))),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}
