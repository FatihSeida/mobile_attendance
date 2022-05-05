import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile_attendance/features/user_attendance/model_attendance.dart';
import 'package:mobile_attendance/features/user_attendance/controller_user_attendance.dart';

import '../attendance_location/model_location.dart';

class PageInputUserAttendance extends GetView<ControllerAttendance> {
  const PageInputUserAttendance({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Attendance'),
        ),
        body: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: controller.name,
                  enableInteractiveSelection: true,
                  cursorColor: Theme.of(context).primaryColor,
                  textCapitalization: TextCapitalization.sentences,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(controller.currentLocationLatitude.isNaN
                          ? ''
                          : '${controller.currentLocationLatitude} ${controller.currentLocationLongitude}'),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          controller.getCurrentPosition();
                        },
                        child: const Text('Fill Your Location')),
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        child: ElevatedButton(
                            child: const Text('Choose your location'),
                            onPressed: () => Get.defaultDialog(
                                title: 'Select your location',
                                content: SizedBox(
                                  height: Get.height * 0.2,
                                  width: Get.width * 0.3,
                                  child: ListView.builder(
                                    itemBuilder: (context, i) {
                                      return InkWell(
                                        onTap: () {
                                          controller.selectedLocation.value =
                                              controller.allMarkers[i]
                                                  .infoWindow.title!;
                                          controller
                                              .selectedIndexLocation.value = i;
                                          Get.back();
                                        },
                                        child: ListTile(
                                          title: Text(controller
                                              .allMarkers[i].infoWindow.title!),
                                        ),
                                      );
                                    },
                                    shrinkWrap: true,
                                    itemCount: controller.allMarkers.length,
                                  ),
                                ))),
                      ),
                      Expanded(
                        child: Text(
                          controller.selectedLocation.value,
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ElevatedButton(
                    onPressed: () async {
                      await controller.insertLocation(
                          location: Attendance(
                        name: controller.name.text,
                        longitude: controller.currentLocationLongitude.value,
                        latitude: controller.currentLocationLatitude.value,
                        // id: 1,
                        latitudeLocation: controller
                            .allMarkers[controller.selectedIndexLocation.value]
                            .position
                            .latitude,
                        longitudeLocation: controller
                            .allMarkers[controller.selectedIndexLocation.value]
                            .position
                            .longitude,
                        nameLocation: controller
                            .allMarkers[controller.selectedIndexLocation.value]
                            .infoWindow
                            .title!,
                      ));
                      if (!controller.loading.value) {
                        Get.back();
                      }
                    },
                    child: controller.loading.value
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : const Text('Submit')),
              )
            ],
          ),
        ));
  }
}
