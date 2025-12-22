import 'package:abg_pos_app/app/shared/custom_card.dart';
import 'package:abg_pos_app/app/shared/vertical_sized_box.dart';
import 'package:abg_pos_app/app/utils/constants/padding_constants.dart';
import 'package:abg_pos_app/app/utils/helpers/time_helper.dart';
import 'package:abg_pos_app/app/utils/theme/custom_text.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/notification_detail_controller.dart';

class NotificationDetailView extends GetView<NotificationDetailController> {
  const NotificationDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(title: Text(controller.title.value), centerTitle: true),
        body: ListView(
          padding: horizontalPadding,
          children: [
            Text(
              localDateTimeFormat(DateTime.now()),
              textAlign: TextAlign.center,
            ),
            VerticalSizedBox(height: 2),
            CustomCard(
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            customLabelText(text: 'Pengirim'),
                            Text('Operator 1', overflow: TextOverflow.clip),
                          ],
                        ),
                      ),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            customLabelText(text: 'Status'),
                            Badge(
                              backgroundColor: Colors.red.shade700,
                              label: Text('Baru'),
                              padding: EdgeInsets.symmetric(
                                horizontal: 5,
                                vertical: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  VerticalSizedBox(),
                  customLabelText(text: 'Keterangan'),
                  Text(
                    controller.detail.value,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
