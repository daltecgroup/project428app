import 'dart:io';
import 'package:abg_pos_app/app/shared/custom_alert.dart';
import 'package:abg_pos_app/app/utils/helpers/file_helper.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerController extends GetxController {
  Rxn<File> selectedImage = Rxn<File>();
  final ImagePicker _picker = ImagePicker();
  void clearImage() {
    selectedImage.value = null;
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(source: source);
      if (pickedFile == null) {
        customAlertDialog('Tidak ada gambar yang diambil!');
        return;
      }
      selectedImage.value = await resizeImage(File(pickedFile.path));
    } catch (e) {
      customAlertDialog('Terjadi kesalahan saat mengambil gambar: $e');
    }
  }
}
