import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project428app/app/services/user_service.dart';
import '../../../controllers/image_picker_controller.dart';
import '../controllers/pengaturan_admin_controller.dart';
import 'package:image_picker/image_picker.dart';

class PengaturanAdminView extends GetView<PengaturanAdminController> {
  const PengaturanAdminView({super.key});

  @override
  Widget build(BuildContext context) {
    final ImagePickerController c = Get.put(ImagePickerController());
    final UserService UserS = Get.find<UserService>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('PengaturanAdminView'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              onPressed: () {
                UserS.getAllUsersData();
              },
              child: Text('TEST'),
            ),
          ],
        ),
      ),
    );
  }
}
