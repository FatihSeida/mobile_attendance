import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_attendance/shared/controller/controller_attendance.dart';

import '../routes/app_routes.dart';

class PageHome extends GetView<ControllerAttendance> {
  const PageHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mobile Attendance'),
      ),
      body: Obx(() => RefreshIndicator(
            onRefresh: (() => controller.locations()),
            child: controller.loading.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : controller.locationAttendance.isEmpty
                    ? const Center(
                        child: Text(
                          'Empty',
                          style: TextStyle(fontSize: 40),
                        ),
                      )
                    : ListView.builder(
                        itemBuilder: (context, index) => Card(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Text(
                                        controller
                                            .locationAttendance[index].name,
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Text(
                                          'Attendance in : ${controller.locationAttendance[index].nameLocation}'),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    TextButton(
                                        onPressed: () {
                                          controller.deleteLocation(controller
                                              .locationAttendance[index].name);
                                        },
                                        child: controller.distance[index] < 50
                                            ? const Text(
                                                'Accepted',
                                                style: TextStyle(
                                                    color: Colors.green),
                                              )
                                            : const Text('Rejected',
                                                style: TextStyle(
                                                    color: Colors.red)))
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        itemCount: controller.locationAttendance.length,
                      ),
          )),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Get.toNamed(Routes.INPUT_ATTENDANCE);
          }),
    );
  }
}
