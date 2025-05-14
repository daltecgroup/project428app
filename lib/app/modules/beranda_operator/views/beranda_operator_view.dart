import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:project428app/app/constants.dart';
import 'package:project428app/app/widgets/operator/operator_appbar.dart';
import 'package:project428app/app/widgets/operator/operator_drawer.dart';

import '../controllers/beranda_operator_controller.dart';

class BerandaOperatorView extends GetView<BerandaOperatorController> {
  const BerandaOperatorView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OperatorAppBar(context, "Operator"),
      drawer: OperatorDrawer(context, kOperatorMenuBeranda),
      body: const Center(
        child: Text('Beranda Kosong', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
