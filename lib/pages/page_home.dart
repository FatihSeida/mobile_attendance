import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_attendance/shared/controller/controller_attendance.dart';
import 'dart:io';

import '../routes/app_routes.dart';

class PageHome extends GetView<ControllerAttendance> {
  const PageHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ControllerAttendance>(
      didChangeDependencies: (state) => controller.locations(),
      builder: (controller) => RefreshIndicator(
        onRefresh: (() => controller.locations()),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Mobile Attendance'),
          ),
          body: controller.loading.value
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
                      physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics(),
                      ),
                      shrinkWrap: false,
                      itemBuilder: (context, index) => Dismissible(
                        background: Container(color: Colors.red),
                        direction: DismissDirection.endToStart,
                        key: Key(
                            '${controller.locationAttendance[index].name}${controller.locationAttendance[index].longitudeLocation}'),
                        onDismissed: (direction) {
                          controller.deleteLocation(
                              controller.locationAttendance[index].name);
                        },
                        child: Card(
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
                                    controller.distance[index] < 50
                                        ? const Text(
                                            'Accepted',
                                            style:
                                                TextStyle(color: Colors.green),
                                          )
                                        : const Text('Rejected',
                                            style:
                                                TextStyle(color: Colors.red)),
                                    Text(
                                        '${controller.distance[index].round().toString()}m Distance')
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      itemCount: controller.locationAttendance.length,
                    ),
          floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () {
                Get.toNamed(Routes.INPUT_ATTENDANCE);
              }),
        ),
      ),
    );
  }
}
