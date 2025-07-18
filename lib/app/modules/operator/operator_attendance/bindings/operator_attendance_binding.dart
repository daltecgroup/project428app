import 'package:get/get.dart';

import '../controllers/operator_attendance_controller.dart';

class OperatorAttendanceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OperatorAttendanceController>(
      () => OperatorAttendanceController(),
    );
  }
}
