import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:mobile_attendance/features/user_attendance/model_user_attendance.dart';
import 'package:mobile_attendance/features/user_attendance/controller_user_attendance.dart';
import 'package:mobile_attendance/shared/constants/colors.dart';
import 'package:mobile_attendance/shared/constants/styles.dart';
import 'package:mobile_attendance/shared/widgets/circular_progress_indicator.dart';

class PageInputUserAttendance extends GetView<ControllerUserAttendance> {
  const PageInputUserAttendance({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Attendance'),
        ),
        body: Obx(
          () => Padding(
            padding: EdgeInsets.only(
                top: Insets.xl, left: Insets.xl, right: Insets.xl),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: Insets.med),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: AppColor.primary)),
                  child: TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: "Your Name",
                        labelStyle: TextStyles.textXs
                            .copyWith(fontSize: 12, color: Colors.blue)),
                    controller: controller.name,
                  ),
                ),
                verticalSpace(Sizes.sm),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: Insets.med),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: AppColor.primary)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Select Your Attendance Location',
                            textAlign: TextAlign.left,
                            style: TextStyles.textXs
                                .copyWith(fontSize: 10, color: Colors.blue),
                          ),
                          Text(
                            controller.selectedLocation.value,
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                      SizedBox(
                        child: ElevatedButton(
                            child: const Text('Pick Location'),
                            onPressed: () => chooseLocationDialog()),
                      ),
                    ],
                  ),
                ),
                verticalSpace(Sizes.xs),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          controller.getCurrentPosition();
                        },
                        style: ElevatedButton.styleFrom(
                            primary:
                                controller.currentLocationLatitude.value == 0.00
                                    ? Colors.blue
                                    : AppColor.successColor),
                        child: Row(
                          children: [
                            const Icon(Icons.my_location),
                            horizontalSpace(Sizes.xs),
                            const Text('Get Your Location')
                          ],
                        )),
                    ElevatedButton(
                        onPressed: controller.name.text.isEmpty ||
                                controller.currentLocationLatitude.value == 0.00
                            ? () {}
                            : () async {
                                await controller.insertLocation(
                                    location: UserAttendance(
                                  name: controller.name.text,
                                  longitude:
                                      controller.currentLocationLongitude.value,
                                  latitude:
                                      controller.currentLocationLatitude.value,
                                  latitudeLocation: controller
                                      .allMarkers[controller
                                          .selectedIndexLocation.value]
                                      .position
                                      .latitude,
                                  longitudeLocation: controller
                                      .allMarkers[controller
                                          .selectedIndexLocation.value]
                                      .position
                                      .longitude,
                                  nameLocation: controller
                                      .allMarkers[controller
                                          .selectedIndexLocation.value]
                                      .infoWindow
                                      .title!,
                                ));
                                if (controller.loading.value == false) {
                                  controller.clearForm();
                                  Get.back();
                                }
                              },
                        child: controller.loading.value
                            ? const DefaultProgressIndicator()
                            : const Text('Submit'))
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  Future<dynamic> chooseLocationDialog() {
    return Get.defaultDialog(
        title: 'Select your location',
        titlePadding: EdgeInsets.only(top: Insets.med),
        titleStyle: TextStyles.h6.copyWith(color: Colors.blue),
        radius: 15,
        content: Column(
          children: [
            SizedBox(
              height: Get.height * 0.13,
              width: Get.width * 0.6,
              child: controller.allMarkers.isEmpty
                  ? Center(
                      child: Text(
                      'Please insert the location first',
                      style: TextStyles.h6,
                      textAlign: TextAlign.center,
                    ))
                  : ListView.builder(
                      itemBuilder: (context, i) {
                        return InkWell(
                          onTap: () {
                            controller.selectedLocation.value =
                                controller.allMarkers[i].infoWindow.title!;
                            controller.selectedIndexLocation.value = i;
                            Get.back();
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 2.h, horizontal: Insets.xs),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(1),
                                  border: Border.all(color: Colors.blue[100]!)),
                              child: Center(
                                  child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: Insets.xs, vertical: Insets.xs),
                                child: Text(
                                    controller.allMarkers[i].infoWindow.title!,
                                    style: TextStyles.textXs
                                        .copyWith(color: Colors.blue)),
                              )),
                            ),
                          ),
                        );
                      },
                      shrinkWrap: true,
                      itemCount: controller.allMarkers.length,
                    ),
            ),
          ],
        ));
  }
}
