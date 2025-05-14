import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../constants.dart';
import '../../../widgets/operator/operator_appbar.dart';
import '../../../widgets/operator/operator_drawer.dart';
import '../controllers/transaksi_operator_controller.dart';

class TransaksiOperatorView extends GetView<TransaksiOperatorController> {
  const TransaksiOperatorView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OperatorAppBar(context, "Transaksi"),
      drawer: OperatorDrawer(context, kOperatorMenuTransaksi),
      body: const Center(
        child: Text('Transaksi Kosong', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
