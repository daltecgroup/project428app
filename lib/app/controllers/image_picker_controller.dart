import 'dart:io';
import 'package:abg_pos_app/app/shared/custom_alert.dart';
import 'package:abg_pos_app/app/utils/helpers/file_helper.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p; // Opsional: untuk join path

class ImagePickerController extends GetxController {
  Rxn<File> selectedImage = Rxn<File>();
  final ImagePicker _picker = ImagePicker();
  void clearImage() {
    selectedImage.value = null;
  }

  Future<File> _saveImageToLocal(File imageFile) async {
    // 1. Dapatkan direktori dokumen aplikasi
    final directory = await getApplicationDocumentsDirectory();
    // 2. Buat nama file unik (gunakan timestamp untuk menghindari konflik)
    final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
    // 3. Gabungkan path direktori dan nama file
    final newPath = p.join(directory.path, fileName);
    // 4. Salin file ke lokasi baru
    final newImage = await imageFile.copy(newPath);

    print(newImage.path); // Untuk verifikasi path

    return newImage;
  }

  Future<String> pickImage(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(source: source);
      if (pickedFile == null) {
        customAlertDialog('Tidak ada gambar yang diambil!');
        return '';
      }

      // 1. Lakukan resize terlebih dahulu
      final resizedFile = await resizeImage(File(pickedFile.path));

      // 2. SIMPAN file yang sudah di-resize ke local storage
      final savedFile = await _saveImageToLocal(resizedFile!);

      selectedImage.value = resizedFile;

      return savedFile.path;
      // save image to local storage
    } catch (e) {
      customAlertDialog('Terjadi kesalahan saat mengambil gambar: $e');
      return '';
    }
  }
}
