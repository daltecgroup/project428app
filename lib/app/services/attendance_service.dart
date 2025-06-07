import 'package:get/get.dart';
import 'package:project428app/app/data/providers/attendance_provider.dart';
import 'package:project428app/app/data/models/attendance.dart';

class AttendanceService extends GetxService {
  AttendanceProvider AttendanceP = AttendanceProvider();
  RxList<Attendance> singleAttendances = <Attendance>[].obs;
  RxList<Attendance> attendances = <Attendance>[].obs;

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

  void getSingleAttendance(String id) {
    AttendanceP.getTodayAttendanceByOperator(id).then((res) {
      if (res.statusCode == 200) {
        singleAttendances.clear();
        if (res.body != null) {
          for (var e in res.body) {
            singleAttendances.add(Attendance.fromJson(e));
          }
          singleAttendances.reversed;
          singleAttendances.refresh();
        }
      }
    });
  }

  Attendance? getClockTime(String type) {
    if (singleAttendances.isNotEmpty) {
      for (var attendance in singleAttendances) {
        if (attendance.type == type) {
          return attendance;
        }
      }
    }
    return null;
  }
}
