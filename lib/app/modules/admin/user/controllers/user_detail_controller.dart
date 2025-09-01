import 'dart:io';

import 'package:abg_pos_app/app/controllers/image_picker_controller.dart';
import 'package:abg_pos_app/app/utils/helpers/file_helper.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../data/models/User.dart';
import '../../../../shared/alert_snackbar.dart';
import '../../../../controllers/user_data_controller.dart';

class UserDetailController extends GetxController {
  UserDetailController({required this.userData, required this.imagePicker});
  UserDataController userData;
  ImagePickerController imagePicker;
  late Rx<User?> _selectedUser;
  final String backRoute = Get.previousRoute;

  @override
  Future<void> onInit() async {
    super.onInit();
    _selectedUser = userData.selectedUser;
  }

  @override
  void onReady() {
    super.onReady();
    if (selectedUser == null) {
      alertSnackbar('Gagal membuka detail pengguna');
    }
  }

  User? get selectedUser => _selectedUser.value;

  Future<void> selectProfileImage() async {
    await imagePicker.pickImage(ImageSource.gallery);
    if (imagePicker.selectedImage.value != null) {
      print(
        'Size before: ${await fileSize(XFile(imagePicker.selectedImage.value!.path))}',
      );
      final resized = await resizeImage(imagePicker.selectedImage.value!);
      print('Size after: ${await fileSize(resized!)}');
    } else {
      print(0);
    }
  }
}
