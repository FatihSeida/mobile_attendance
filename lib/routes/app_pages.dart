import 'package:get/get.dart';
import 'package:mobile_attendance/features/home/binding_home.dart';

import '../features/home/page_home.dart';
import '../features/user_attendance/page_input_user_attendance.dart';
import '../features/attendance_location/page_input_attendance_location.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.HOME,
      page: () => const PageHome(),
    ),
    GetPage(
      name: Routes.INPUT_ATTENDANCE,
      page: () => const PageInputUserAttendance(),
    ),
    GetPage(
      name: Routes.INPUT_LOCATION,
      page: () => const PageInputLocation(),
    )
  ];
}
