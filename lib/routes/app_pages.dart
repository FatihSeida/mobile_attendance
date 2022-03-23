import 'package:get/get.dart';

import '../pages/page_home.dart';
import '../pages/page_input_attendance.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.HOME,
      page: () => const PageHome(),
    ),
    GetPage(
      name: Routes.INPUT_ATTENDANCE,
      page: () => const PageInputAttendance(),
    ),
  ];
}
