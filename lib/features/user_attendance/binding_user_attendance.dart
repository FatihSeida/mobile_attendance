import 'package:get/get.dart';
import 'package:mobile_attendance/features/user_attendance/controller_user_attendance.dart';

class ControllerBind implements Bindings {
  @override
  void dependencies() {
    Get.put<ControllerAttendance>(ControllerAttendance());
  }
}
