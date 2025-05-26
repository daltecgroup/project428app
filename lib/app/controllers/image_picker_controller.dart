import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:file_picker/file_picker.dart';
import 'package:project428app/app/constants.dart';
import 'package:project428app/app/services/auth_service.dart'; // For desktop file picking

class ImagePickerController extends GetxController {
  AuthService authS = Get.find<AuthService>();
  Rxn<File> selectedImage = Rxn<File>();
  RxBool isUploading = false.obs;
  RxString uploadMessage = ''.obs;

  final ImagePicker _picker = ImagePicker();
  late final String uploadUrl;

  @override
  void onInit() {
    super.onInit();
    uploadUrl = '${authS.mainServerUrl.value}/upload';
    // Consider more robust URL management based on build environment
  }

  Future<void> pickImage(ImageSource source) async {
    if (kIsWeb || defaultTargetPlatform == TargetPlatform.windows) {
      // Use file_picker for web and Windows
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );

      if (result != null && result.files.isNotEmpty) {
        if (kIsWeb) {
          // For web, we might need a different approach to handle the File
          // This example assumes you can convert the picked file to a File object.
          // Depending on your use case, you might directly use the bytes.
          final bytes = result.files.first.bytes;

          final tempDir = await Directory.systemTemp.createTemp();
          // Create a temporary file to store the image
          // This is a workaround since web doesn't allow direct file access
          // and we need to convert the bytes to a file.
          // You might need to adjust this part based on your web implementation
          // and how you want to handle the file.
          final file = File('${tempDir.path}/${result.files.first.name}');
          await file.writeAsBytes(bytes!);
          selectedImage.value = file;
        } else if (defaultTargetPlatform == TargetPlatform.windows) {
          selectedImage.value = File(result.files.first.path!);
        }
      } else {
        // Get.snackbar('No Image Selected', 'Please pick an image.');
      }
    } else {
      // Use image_picker for mobile platforms (Android, iOS)
      final XFile? pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        selectedImage.value = File(pickedFile.path);
      } else {
        Get.snackbar(
          'No Image Selected',
          'Please pick an image from gallery or camera.',
        );
      }
    }
  }

  Future<void> uploadImage() async {
    if (selectedImage.value == null) {
      Get.snackbar('No Image Selected', 'Please select an image to upload.');
      return;
    }

    isUploading.value = true;
    uploadMessage.value = 'Uploading image...';

    try {
      var request = http.MultipartRequest('POST', Uri.parse(uploadUrl));
      request.files.add(
        await http.MultipartFile.fromPath(
          'image',
          selectedImage.value!.path,
          filename: path.basename(selectedImage.value!.path),
        ),
      );

      // Add any necessary headers (e.g., Authorization)
      // request.headers['Authorization'] = 'Bearer your_auth_token';

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        print('Image uploaded successfully!');
        uploadMessage.value = 'Image uploaded successfully!';
        selectedImage.value = null;
        Get.snackbar('Success', 'Image uploaded successfully!');
        print('Response body: ${response.body}');
      } else {
        print(
          'Image upload failed with status ${response.statusCode}: ${response.body}',
        );
        uploadMessage.value =
            'Image upload failed. Status: ${response.statusCode}\n${response.body}';
        Get.snackbar(
          'Error',
          'Image upload failed. Please try again.\n${response.body}',
        );
      }
    } catch (e) {
      print('Error uploading image: $e');
      uploadMessage.value = 'Error uploading image: $e';
      Get.snackbar('Error', 'Failed to upload image. Check your connection.');
    } finally {
      isUploading.value = false;
    }
  }
}
