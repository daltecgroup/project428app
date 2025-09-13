import 'package:abg_pos_app/app/controllers/image_picker_controller.dart';
import 'package:abg_pos_app/app/shared/custom_alert.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
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
    imagePicker.clearImage();
    await imagePicker.pickImage(ImageSource.gallery);
    final img = imagePicker.selectedImage.value;
    if (img == null) {
      return;
    }
    if (_selectedUser.value == null)
      return customAlertDialog('Pengguna tidak ditemukan!');
    final mimeType = lookupMimeType(img.path)!;
    final data = FormData({
      'profileImage': MultipartFile(
        img,
        filename: 'img-${_selectedUser.value!.id}.${img.path.split('.').last}',
        contentType: mimeType,
      ),
    });
    await userData.updateUserProfile(data: data);
  }
}
