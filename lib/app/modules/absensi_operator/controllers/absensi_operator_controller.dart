import 'package:get/get.dart';
import 'package:project428app/app/controllers/image_picker_controller.dart';
import 'package:project428app/app/data/providers/attendance_provider.dart';
import 'package:project428app/app/services/attendance_service.dart';
import 'package:project428app/app/services/auth_service.dart';

class AbsensiOperatorController extends GetxController {
  AuthService AuthS = Get.find<AuthService>();
  AttendanceProvider AttendanceP = AttendanceProvider();
  AttendanceService AttendanceS = Get.find<AttendanceService>();
  ImagePickerController imagePickerC = Get.put(ImagePickerController());

  RxBool isClockedIn = false.obs;
  RxBool isClockedOut = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void createAttendance(String type) {
    if (imagePickerC.selectedImage.value != null) {
      AttendanceP.createAttendance(
        imagePickerC.selectedImage.value!,
        AuthS.box.read('userProfile')['id'],
        type,
      ).then((res) {
        if (type == 'clock-in') {
          isClockedIn.value = true;
        } else {
          isClockedOut.value = true;
        }
        AttendanceS.getSingleAttendance(
          AuthS.box.read('userProfile')['userId'],
        );
      });
    }
  }
}
