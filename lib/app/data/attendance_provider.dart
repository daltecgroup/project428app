import 'dart:io';

import 'package:get/get.dart';
import 'package:project428app/app/services/auth_service.dart';

class AttendanceProvider extends GetConnect {
  AuthService authS = Get.find<AuthService>();

  @override
  void onInit() {}

  Future<Response> createAttendance(File imageFile, String user, String type) {
    // create json string from all that data except image

    final FormData formData = FormData({
      'user': user,
      'type': type,
      'image': MultipartFile(
        imageFile,
        filename: 'img-$user.${imageFile.path.split('.').last}',
      ),
    });

    return post('${authS.mainServerUrl.value}/api/v1/attendances', formData);
  }

  Future<Response> getTodayAttendanceByOperator(String id) {
    return get('${authS.mainServerUrl.value}/api/v1/attendances/$id/today');
  }
}
