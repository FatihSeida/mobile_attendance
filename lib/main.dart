import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:mobile_attendance/routes/app_pages.dart';
import 'package:mobile_attendance/routes/app_routes.dart';
import 'package:mobile_attendance/shared/binding/binding_attendance.dart';


void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: AppPages.pages,
      initialBinding: ControllerBind(),
      initialRoute: Routes.HOME,
    );
  }
}
