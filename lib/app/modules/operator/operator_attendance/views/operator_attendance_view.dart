import 'package:abg_pos_app/app/shared/custom_appbar.dart';
import 'package:abg_pos_app/app/shared/custom_drawer.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/operator_attendance_controller.dart';

class OperatorAttendanceView extends GetView<OperatorAttendanceController> {
  const OperatorAttendanceView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('Presensi'),
      drawer: customDrawer(),
      body: const Center(
        child: Text('Kehadiran Kosong', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
