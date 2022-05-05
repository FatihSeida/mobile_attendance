import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile_attendance/features/home/binding_home.dart';

import 'package:mobile_attendance/routes/app_pages.dart';
import 'package:mobile_attendance/routes/app_routes.dart';

void main() {
  if (defaultTargetPlatform == TargetPlatform.android) {
    AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
  }
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return ScreenUtilInit(
      builder: (context) => GetMaterialApp(
        title: 'Mobile Attendance',
        smartManagement: SmartManagement.full,
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {},
              child: Stack(children: [
                child!,
              ]),
            ),
          );
        },
        getPages: AppPages.pages,
        initialBinding: HomeBinding(),
        initialRoute: Routes.HOME,
        theme: ThemeData(
          platform: TargetPlatform.android,
          brightness: Brightness.light,
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
