import 'dart:convert';

import 'package:abg_pos_app/app/controllers/daily_outlet_sale_report_data_controller.dart';
import 'package:abg_pos_app/app/controllers/order_data_controller.dart';
import 'package:abg_pos_app/app/utils/constants/padding_constants.dart';
import 'package:abg_pos_app/app/utils/helpers/sale_report_helper.dart';

import '../../../../controllers/image_picker_controller.dart';
import '../../../../controllers/outlet_data_controller.dart';
import '../../../../controllers/user_data_controller.dart';
import '../../../../shared/custom_alert.dart';
import '../../../../shared/custom_appbar_lite.dart';
import '../../../../shared/custom_nav_item.dart';
import '../../../../shared/vertical_sized_box.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/helpers/text_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';

class OutletDetailController extends GetxController {
  OutletDetailController({
    required this.data,
    required this.userData,
    required this.orderData,
    required this.reportData,
  });
  final OutletDataController data;
  final UserDataController userData;
  final OrderDataController orderData;
  final DailyOutletSaleReportDataController reportData;
  final String backRoute = Get.previousRoute;

  final ImagePickerController imagePicker = Get.put(
    ImagePickerController(),
    tag: 'outlet-detail',
  );

  RxInt selectedTab = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    clearCurrentDailyOutletSaleReport();
    super.onClose();
  }

  Future<void> refreshData() async {
    await data.syncData(refresh: true);
  }

  void deleteUserFromOutlet(String role, String id, String name) {
    final outlet = data.selectedOutlet.value!;
    final roleMap = {
      AppConstants.ROLE_FRANCHISEE: (
        'Franchisee',
        outlet.franchisees,
        'franchisees',
      ),
      AppConstants.ROLE_SPVAREA: ('SPV Area', outlet.spvAreas, 'spvAreas'),
      AppConstants.ROLE_OPERATOR: ('Operator', outlet.operators, 'operators'),
    };

    final (roleText, list, key) = roleMap[role] ?? ('Pengguna', <String>[], '');

    list.remove(id);

    customDeleteAlertDialog(
      'Yakin menghapus pengguna \'${normalizeName(name)}\' dari $roleText?',
      () async {
        Get.back();
        await data.updateOutlet(id: outlet.id, data: json.encode({key: list}));
      },
    );
  }

  void linkUserToOutletRole(String role) {
    final svg = Svg(AppConstants.PROFILE_PLACEHOLDER);
    final selectedOutlet = data.selectedOutlet.value!;

    final (roleText, exclude, updateKey) = switch (role) {
      AppConstants.ROLE_FRANCHISEE => (
        'Franchisee',
        selectedOutlet.franchisees,
        'franchisees',
      ),
      AppConstants.ROLE_SPVAREA => (
        'SPV Area',
        selectedOutlet.spvAreas,
        'spvAreas',
      ),
      AppConstants.ROLE_OPERATOR => (
        'Operator',
        selectedOutlet.operators,
        'operators',
      ),
      _ => ('Pengguna', <String>[], ''),
    };

    final users = userData.getUsersByRoles([role], exclude: exclude);

    if (users.isEmpty) {
      customAlertDialog(
        '${normalizeName(roleText)} aktif lain tidak ditemukan',
      );
      return;
    }

    Get.dialog(
      Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: Get.height * 0.8),
          child: Padding(
            padding: const EdgeInsets.all(AppConstants.DEFAULT_PADDING * 2),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                AppConstants.DEFAULT_BORDER_RADIUS * 2,
              ),
              child: Material(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    customAppBarLite(
                      title: 'Pilih $roleText',
                      enableLeading: false,
                    ),
                    Flexible(
                      child: ListView.builder(
                        shrinkWrap: true,
                        padding: horizontalPadding,
                        itemCount: users.length,
                        itemBuilder: (_, index) {
                          final user = users[index];
                          return CustomNavItem(
                            title: user.name,
                            image: svg,
                            isProfileImage: true,
                            disableTrailing: true,
                            onTap: () async {
                              exclude.add(user.id);
                              Get.back();
                              await data.updateOutlet(
                                id: selectedOutlet.id,
                                data: json.encode({updateKey: exclude}),
                              );
                            },
                          );
                        },
                      ),
                    ),
                    const VerticalSizedBox(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
