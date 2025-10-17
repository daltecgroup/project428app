import 'package:abg_pos_app/app/shared/custom_appbar.dart';
import 'package:abg_pos_app/app/shared/custom_card.dart';
import 'package:abg_pos_app/app/shared/custom_drawer.dart';
import 'package:abg_pos_app/app/shared/horizontal_sized_box.dart';
import 'package:abg_pos_app/app/shared/vertical_sized_box.dart';
import 'package:abg_pos_app/app/utils/constants/padding_constants.dart';
import 'package:abg_pos_app/app/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../shared/custom_circle_avatar_image.dart';
import '../../../../utils/theme/custom_text.dart';
import '../controllers/admin_dashboard_controller.dart';

part '../widgets/user_indicator.dart';

class AdminDashboardView extends GetView<AdminDashboardController> {
  const AdminDashboardView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('Admin'),
      drawer: customDrawer(),
      body: ListView(
        padding: horizontalPadding,
        children: [
          if (controller.currentUser != null)
            UserIndicator(controller: controller),

          // user count
          VerticalSizedBox(),
          Row(
            children: [
              Expanded(
                child: CustomCard(
                  content: Column(
                    children: [
                      customTitleText(maxLines: 1, text: '12'),
                      customSmallLabelText(text: 'Gerai Aktif'),
                    ],
                  ),
                ),
              ),
              HorizontalSizedBox(),
              Expanded(
                child: CustomCard(
                  content: Column(
                    children: [
                      customTitleText(maxLines: 1, text: '12'),
                      customSmallLabelText(text: 'Gerai Aktif'),
                    ],
                  ),
                ),
              ),
            ],
          ),

          VerticalSizedBox(),
          Row(
            children: [
              Expanded(
                child: CustomCard(
                  content: Column(
                    children: [
                      customTitleText(maxLines: 1, text: '12'),
                      customSmallLabelText(text: 'Gerai Aktif'),
                    ],
                  ),
                ),
              ),
              HorizontalSizedBox(),
              Expanded(
                child: CustomCard(
                  content: Column(
                    children: [
                      customTitleText(maxLines: 1, text: '12'),
                      customSmallLabelText(text: 'Gerai Aktif'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
