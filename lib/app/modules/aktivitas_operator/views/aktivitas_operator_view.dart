import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../constants.dart';
import '../../../widgets/operator/operator_appbar.dart';
import '../../../widgets/operator/operator_drawer.dart';
import '../controllers/aktivitas_operator_controller.dart';

class AktivitasOperatorView extends GetView<AktivitasOperatorController> {
  const AktivitasOperatorView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OperatorAppBar(context, "Aktivitas"),
      drawer: OperatorDrawer(context, kOperatorMenuAktivitas),
      body: const Center(
        child: Text('Aktivitas Kosong', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
