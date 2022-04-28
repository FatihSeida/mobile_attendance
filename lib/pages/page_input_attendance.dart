import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_attendance/models/model_attendance.dart';
import 'package:mobile_attendance/routes/app_routes.dart';
import 'package:mobile_attendance/shared/controller/controller_attendance.dart';

import '../models/model_location.dart';

class PageInputAttendance extends GetView<ControllerAttendance> {
  const PageInputAttendance({Key? key}) : super(key: key);

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
                child: DropdownButton<dynamic>(
                  hint: const Text(
                      'Please choose a location'), // Not necessary for Option 1
                  value: controller.selectedLocation.value,
                  onChanged: (newValue) {
                    controller.selectedLocation(newValue);
                  },
                  items: locations.map((location) {
                    return DropdownMenuItem<int>(
                      child: Text(location.nameLocation),
                      value: location.id,
                    );
                  }).toList(),
                ),
              ),
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
                        latitudeLocation:
                            locations[controller.selectedLocation.value]
                                .latitude,
                        longitudeLocation:
                            locations[controller.selectedLocation.value]
                                .longitude,
                        nameLocation:
                            locations[controller.selectedLocation.value]
                                .nameLocation,
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
