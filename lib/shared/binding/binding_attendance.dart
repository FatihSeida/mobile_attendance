import 'package:get/get.dart';
import 'package:mobile_attendance/shared/controller/controller_attendance.dart';

class ControllerBind implements Bindings {
  @override
  void dependencies() {
    Get.put<ControllerAttendance>(ControllerAttendance());
  }
}
