import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/constants.dart';
import '../../../shared/widgets/operator/operator_appbar.dart';
import '../../../shared/widgets/operator/operator_drawer.dart';
import '../controllers/absensi_operator_controller.dart';

class AbsensiOperatorView extends GetView<AbsensiOperatorController> {
  const AbsensiOperatorView({super.key});
  @override
  Widget build(BuildContext context) {
    controller.AttendanceS.getSingleAttendance(
      controller.AuthS.box.read('userProfile')['id'],
    );
    return Scaffold(
      appBar: OperatorAppBar(context, "Absensi"),
      drawer: OperatorDrawer(context, kOperatorMenuAbsensi),
      body: Stack(
        children: [
          RefreshIndicator(
            onRefresh:
                () async => controller.AttendanceS.getSingleAttendance(
                  controller.AuthS.box.read('userProfile')['id'],
                ),
            child: ListView(
              padding: EdgeInsets.only(left: 15, right: 15, top: 20),
              children: [
                Material(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 1,
                  child: Column(
                    children: [
                      ListTile(
                        selected: true,
                        selectedTileColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        leading:
                            GetPlatform.isWeb
                                ? CircleAvatar()
                                : ClipRRect(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30),
                                  ),
                                  child:
                                      controller.AuthS.isConnected.value
                                          ? controller.AuthS.box.read(
                                                    'userProfile',
                                                  )['imgUrl'] !=
                                                  null
                                              ? FadeInImage.assetNetwork(
                                                placeholder: kAssetLoading,
                                                image:
                                                    controller.AuthS.box.read(
                                                      'userProfile',
                                                    )['imgUrl'],
                                                // webHtmlElementStrategy: WebHtmlElementStrategy.prefer,
                                              )
                                              : CircleAvatar(
                                                child: SvgPicture.asset(
                                                  kImgPlaceholder,
                                                  fit: BoxFit.cover,
                                                ),
                                              )
                                          : CircleAvatar(
                                            child: SvgPicture.asset(
                                              kImgPlaceholder,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                ),
                        title: Text(
                          controller.AuthS.box.read('userProfile')['name'],
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        subtitle: Text(
                          'ID ${controller.AuthS.box.read('userProfile')['userId']}',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Card(
                  color: Colors.white,
                  elevation: 1,
                  margin: EdgeInsets.all(0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 15,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "${DateTime.now().day} ${DateFormat(DateFormat.MONTH).format(DateTime.now())} ${DateTime.now().year}",
                        ),
                        Text(
                          'Jadwal Kerja 08.00 WIB - 17.00 WIB',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Obx(
                                  () => FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child:
                                        controller
                                                .AttendanceS
                                                .singleAttendances
                                                .isEmpty
                                            ? Text('-')
                                            : Text(
                                              controller.AttendanceS.getClockTime(
                                                        'clock-in',
                                                      ) ==
                                                      null
                                                  ? '-'
                                                  : controller.isClockedIn.value
                                                  ? controller
                                                      .AttendanceS.getClockTime(
                                                    'clock-in',
                                                  )!.getCreateTime()
                                                  : '-',
                                              maxLines: 1,
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                  ),
                                ),
                                Text(
                                  'Jam Masuk',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Obx(
                                  () => FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child:
                                        controller
                                                .AttendanceS
                                                .singleAttendances
                                                .isEmpty
                                            ? Text('-')
                                            : Text(
                                              controller.AttendanceS.getClockTime(
                                                        'clock-out',
                                                      ) ==
                                                      null
                                                  ? '-'
                                                  : controller
                                                      .isClockedOut
                                                      .value
                                                  ? controller
                                                      .AttendanceS.getClockTime(
                                                    'clock-out',
                                                  )!.getCreateTime()
                                                  : '-',
                                              maxLines: 1,
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                  ),
                                ),
                                Text(
                                  'Jam Keluar',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        if (controller.AttendanceS.singleAttendances.isNotEmpty)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 80,
                                width: 80,
                                child:
                                    controller.AttendanceS.getClockTime(
                                              'clock-in',
                                            ) ==
                                            null
                                        ? SvgPicture.asset(kImgPlaceholder)
                                        : Image.network(
                                          '${controller.AuthS.mainServerUrl}/api/v1/${controller.AttendanceS.getClockTime('clock-in')!.imgUrl}',
                                        ),
                              ),
                              Container(
                                height: 80,
                                width: 80,
                                child:
                                    controller.AttendanceS.getClockTime(
                                              'clock-out',
                                            ) ==
                                            null
                                        ? SvgPicture.asset(kImgPlaceholder)
                                        : Image.network(
                                          '${controller.AuthS.mainServerUrl}/api/v1/${controller.AttendanceS.getClockTime('clock-out')!.imgUrl}',
                                        ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 20),
                Obx(
                  () => Container(
                    height: 50,
                    alignment: Alignment.bottomCenter,
                    // padding: EdgeInsets.only(bottom: 20, left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(
                                controller.isClockedIn.value == false
                                    ? null
                                    : Colors.grey[50],
                              ),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ),
                            onPressed: () {
                              if (controller.isClockedIn.value == false) {
                                controller.imagePickerC
                                    .pickImage(ImageSource.camera)
                                    .then((_) {
                                      controller.createAttendance('clock-in');
                                    });
                              }
                            },
                            child: Text(
                              'Masuk',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(
                                controller.isClockedOut.value == false
                                    ? null
                                    : Colors.grey[50],
                              ),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ),
                            onPressed: () {
                              if (controller.isClockedOut.value == false) {
                                controller.imagePickerC
                                    .pickImage(ImageSource.camera)
                                    .then((_) {
                                      controller.createAttendance('clock-out');
                                    });
                              }
                            },
                            child: Text(
                              'Keluar',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
