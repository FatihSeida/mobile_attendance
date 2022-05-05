import 'package:get/get.dart';

import '../attendance_location/controller_attendance_location.dart';
import '../user_attendance/controller_user_attendance.dart';


class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<ControllerAttendanceLocation>(
      ControllerAttendanceLocation(),
    );
    Get.put<ControllerUserAttendance>(
      ControllerUserAttendance(),
    );
  }
}
