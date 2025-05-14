import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../constants.dart';
import '../../../widgets/operator/operator_appbar.dart';
import '../../../widgets/operator/operator_drawer.dart';
import '../controllers/absensi_operator_controller.dart';

class AbsensiOperatorView extends GetView<AbsensiOperatorController> {
  const AbsensiOperatorView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OperatorAppBar(context, "Absensi"),
      drawer: OperatorDrawer(context, kOperatorMenuAbsensi),
      body: const Center(
        child: Text('Absensi Kosong', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
