import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../shared/custom_appbar.dart';
import '../../../../shared/custom_drawer.dart';
import '../controllers/setting_controller.dart';
import '../../../../shared/custom_nav_item.dart';
import '../../../../shared/vertical_sized_box.dart';
import '../../../../utils/constants/app_constants.dart';

class SettingView extends GetView<SettingController> {
  const SettingView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('Pengaturan'),
      drawer: customDrawer(context),
      body: Obx(
        () => ListView(
          padding: EdgeInsets.symmetric(
            horizontal: AppConstants.DEFAULT_PADDING,
          ),
          children: [
            VerticalSizedBox(height: 2),
            CustomNavItem(
              leading: Icon(Icons.sync_alt_rounded),
              title: 'Sinkronisasi Otomatis',
              subTitle: 'Default: ON',
              trailing: SizedBox(
                height: 40,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Switch(
                    value: controller.syncStatus.value,
                    onChanged: (value) {
                      controller.syncStatus.value = value;
                      if (value) {
                        controller.stopProductSync();
                      } else {
                        controller.startProductSync();
                      }
                    },
                  ),
                ),
              ),
            ),
            CustomNavItem(
              leading: Icon(Icons.delete_forever_rounded),
              title: 'Hapus Data Lokal',
              onTap: () => controller.deleteLocalFiles(),
              trailing: SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
