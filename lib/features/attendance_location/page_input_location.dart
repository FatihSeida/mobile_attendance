import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile_attendance/features/attendance_location/model_location.dart';

import '../user_attendance/controller_user_attendance.dart';

class PageInputLocation extends GetView<ControllerAttendance> {
  const PageInputLocation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => GoogleMap(
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
                  title: 'INSERT LOCATION NAME',
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: controller.locationName,
                        keyboardType: TextInputType.text,
                        maxLines: 1,
                        decoration: const InputDecoration(
                            labelText: 'Location Name',
                            hintMaxLines: 1,
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.green, width: 4.0))),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          controller.insertAttendanceLocation(
                              location: Location(
                                  
                                  nameLocation: controller.locationName.text,
                                  longitude: latLng.longitude,
                                  latitude: latLng.latitude));
                          controller.allMarkers.add(Marker(
                            markerId: MarkerId(controller.locationName.text),
                            infoWindow:
                                InfoWindow(title: controller.locationName.text),
                            position: latLng,
                          ));
                          Get.back();
                        },
                        child: const Text(
                          'Confirm',
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                        ),
                        style: ElevatedButton.styleFrom(primary: Colors.green),
                      )
                    ],
                  ),
                  radius: 10.0);
            },
          )),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: const Text('Go To BHO!'),
        icon: const Icon(Icons.location_city_outlined),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController gMapsController =
        await controller.mapsController.value.future;
    gMapsController
        .animateCamera(CameraUpdate.newCameraPosition(controller.kLake.value));
  }
}
