import 'package:abg_pos_app/app/shared/pages/failed_page_placeholder.dart';
import 'package:abg_pos_app/app/utils/constants/padding_constants.dart';
import 'package:abg_pos_app/app/utils/helpers/outlet_helper.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../shared/custom_appbar.dart';
import '../../../../shared/custom_circle_avatar_image.dart';
import '../../../../shared/custom_drawer.dart';
import '../controllers/operator_dashboard_controller.dart';

class OperatorDashboardView extends GetView<OperatorDashboardController> {
  const OperatorDashboardView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final currentOutlet = controller.outletData.currentOutlet;
      return Scaffold(
        appBar: customAppBar(currentOutletName ?? '-'),
        drawer: customDrawer(),
        body: currentOutlet == null
            ? FailedPagePlaceholder()
            : ListView(
                padding: horizontalPadding,
                children: [
                  if (controller.currentUser != null)
                    Material(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 1,
                      child: ListTile(
                        selected: true,
                        selectedTileColor: Colors.grey[50],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        leading: CustomCircleAvatarImage(),
                        title: Text(
                          controller.currentUser!.name,
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        subtitle: Text(
                          'ID ${controller.currentUser!.userId}',
                          style: TextStyle(fontSize: 14),
                        ),
                        trailing: IconButton(
                          onPressed: () => controller.auth.logout(),
                          icon: Icon(Icons.logout_rounded),
                        ),
                      ),
                    ),
                ],
              ),
      );
    });
  }
}
