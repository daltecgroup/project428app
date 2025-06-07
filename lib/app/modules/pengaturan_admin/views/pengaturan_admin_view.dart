import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../services/user_service.dart';
import '../../../shared/widgets/admin/admin_appbar.dart';
import '../../../shared/widgets/admin/admin_drawer.dart';
import '../controllers/pengaturan_admin_controller.dart';
import 'package:project428app/app/core/constants/constants.dart';

class PengaturanAdminView extends GetView<PengaturanAdminController> {
  const PengaturanAdminView({super.key});

  @override
  Widget build(BuildContext context) {
    final UserService UserS = Get.find<UserService>();
    return Scaffold(
      appBar: AdminAppBar(context, "Pengaturan", null),
      drawer: AdminDrawer(context, kAdminMenuPengaturan),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              onPressed: () {
                UserS.syncUsersData();
              },
              child: Text('TEST'),
            ),
          ],
        ),
      ),
    );
  }
}
