import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/image_picker_controller.dart';
import '../controllers/pengaturan_admin_controller.dart';
import 'package:image_picker/image_picker.dart';

class PengaturanAdminView extends GetView<PengaturanAdminController> {
  const PengaturanAdminView({super.key});

  @override
  Widget build(BuildContext context) {
    final ImagePickerController c = Get.put(ImagePickerController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('PengaturanAdminView'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Obx(() {
              return c.selectedImage.value == null
                  ? Text('No image selected.')
                  : SizedBox(
                    height: 200,
                    width: 200,
                    child: Image.file(c.selectedImage.value!),
                  );
            }),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () => c.pickImage(ImageSource.gallery),
                  child: Text('Pick from Gallery'),
                ),
                ElevatedButton(
                  onPressed: () => c.pickImage(ImageSource.camera),
                  child: Text('Pick from Camera'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Obx(() {
              if (c.isUploading.value) {
                return Column(
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 10),
                    Text(c.uploadMessage.value),
                  ],
                );
              } else {
                return ElevatedButton(
                  onPressed:
                      c.selectedImage.value == null ? null : c.uploadImage,
                  child: Text('Upload Image'),
                );
              }
            }),
            Obx(() => Text(c.uploadMessage.value)),
          ],
        ),
      ),
    );
  }
}
