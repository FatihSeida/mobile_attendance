import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobile_attendance/features/user_attendance/controller_user_attendance.dart';
import 'package:mobile_attendance/shared/constants/styles.dart';

import '../../routes/app_routes.dart';
import '../../shared/widgets/circular_progress_indicator.dart';

class PageHome extends GetView<ControllerUserAttendance> {
  const PageHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ControllerUserAttendance>(
      didChangeDependencies: (state) => controller.locations(),
      builder: (c) => RefreshIndicator(
        onRefresh: (() => controller.locations()),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Mobile Attendance'),
          ),
          body: controller.loading.value
              ? const DefaultProgressIndicator()
              : controller.userAttendance.isEmpty
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
                            '${controller.userAttendance[index].name}${controller.userAttendance[index].longitudeLocation}'),
                        onDismissed: (direction) {
                          controller.deleteLocation(
                              controller.userAttendance[index].name);
                          controller.userAttendance.removeAt(index);
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
                                        controller.userAttendance[index].name,
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Text(
                                          'Attend to : ${controller.userAttendance[index].nameLocation}'),
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
                      itemCount: controller.userAttendance.length,
                    ),
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              FloatingActionButton.extended(
                heroTag: "ins_loc_btn",
                onPressed: () {
                  Get.toNamed(Routes.INPUT_LOCATION);
                },
                label: Text(
                  'Insert Location',
                  style: TextStyles.textXs.copyWith(fontSize: 12),
                ),
                icon: const Icon(Icons.add_location),
                backgroundColor: Colors.blue,
                elevation: 0,
              ),
              verticalSpace(5.h),
              FloatingActionButton.extended(
                heroTag: "add_att_btn",
                onPressed: () {
                  Get.toNamed(Routes.INPUT_ATTENDANCE);
                },
                label: Text(
                  'Add Attendance',
                  style: TextStyles.textXs.copyWith(fontSize: 12),
                ),
                icon: const Icon(Icons.person_add),
                backgroundColor: Colors.blue,
                elevation: 0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
