import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile_attendance/features/attendance_location/controller_attendance_location.dart';
import 'package:mobile_attendance/features/attendance_location/model_attendance_location.dart';
import 'package:mobile_attendance/shared/widgets/circular_progress_indicator.dart';

import '../../shared/constants/styles.dart';

class PageInputLocation extends GetView<ControllerAttendanceLocation> {
  const PageInputLocation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => controller.loading.isTrue
          ? const DefaultProgressIndicator()
          : GoogleMap(
              myLocationButtonEnabled: true,
              mapToolbarEnabled: true,
              mapType: MapType.terrain,
              initialCameraPosition: controller.kGooglePlex.value,
              onMapCreated: (GoogleMapController mapController) {
                if (!controller.mapsController.value.isCompleted) {
                  controller.mapsController.value.complete(mapController);
                } else {}
              },
              markers: Set<Marker>.of(controller.allMarkers),
              onTap: (LatLng latLng) {
                Get.defaultDialog(
                  title: 'Insert Location',
                  titlePadding: EdgeInsets.only(top: Insets.med),
                  titleStyle: TextStyles.h6.copyWith(color: Colors.blue),
                  radius: 15,
                  content: Padding(
                    padding: EdgeInsets.symmetric(horizontal: Insets.xl),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                            controller: controller.locationName,
                            keyboardType: TextInputType.text,
                            maxLines: 1,
                            decoration: InputDecoration(
                                labelText: 'Location Name',
                                hintMaxLines: 1,
                                labelStyle: TextStyles.textXs.copyWith(
                                    fontSize: 12, color: Colors.blue))),
                        const SizedBox(
                          height: 20.0,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            controller.insertAttendanceLocation(
                                location: AttendanceLocation(
                                    nameLocation: controller.locationName.text,
                                    longitude: latLng.longitude,
                                    latitude: latLng.latitude));
                            controller.allMarkers.add(Marker(
                              markerId: MarkerId(controller.locationName.text),
                              infoWindow: InfoWindow(
                                  title: controller.locationName.text),
                              position: latLng,
                            ));
                            controller.locationName.clear();
                            Get.back();
                          },
                          child: const Text(
                            'Confirm',
                            style:
                                TextStyle(color: Colors.white, fontSize: 16.0),
                          ),
                          style: ElevatedButton.styleFrom(primary: Colors.blue),
                        )
                      ],
                    ),
                  ),
                );
              },
            )),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 40),
        child: FloatingActionButton.extended(
          heroTag: "del_loc_btn",
          onPressed: () {
            controller.deleteAttendanceLocation(controller
                .allMarkers[controller.selectedMarkerIndex.value]
                .infoWindow
                .title!);
            controller.getAttendancelocations();
          },
          label: Text(
            'Delete',
            style: TextStyles.textXs.copyWith(fontSize: 12),
          ),
          icon: const Icon(Icons.delete),
          backgroundColor: Colors.red,
          elevation: 0,
        ),
      ),
    );
  }
}
