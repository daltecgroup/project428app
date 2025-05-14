import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../constants.dart';
import '../../../widgets/operator/operator_appbar.dart';
import '../../../widgets/operator/operator_drawer.dart';
import '../controllers/stok_operator_controller.dart';

class StokOperatorView extends GetView<StokOperatorController> {
  const StokOperatorView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OperatorAppBar(context, "Stok"),
      drawer: OperatorDrawer(context, kOperatorMenuStok),
      body: const Center(
        child: Text('Stok Kosong', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
