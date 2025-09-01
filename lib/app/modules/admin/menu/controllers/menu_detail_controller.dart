import 'dart:io';

import 'package:abg_pos_app/app/controllers/image_picker_controller.dart';
import 'package:abg_pos_app/app/controllers/menu_category_data_controller.dart';
import 'package:abg_pos_app/app/controllers/menu_data_controller.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../controllers/ingredient_data_controller.dart';
import '../../../../data/models/Recipe.dart';
import '../../../../routes/app_pages.dart';
import '../../../../shared/custom_alert.dart';
import '../../../../utils/helpers/file_helper.dart';
import '../../../../utils/helpers/logger_helper.dart';

class MenuDetailController extends GetxController {
  MenuDetailController({
    required this.data,
    required this.ingredientData,
    required this.categoryData,
  });

  final MenuDataController data;
  final IngredientDataController ingredientData;
  final MenuCategoryDataController categoryData;

  final ImagePickerController imagePicker = Get.put(
    ImagePickerController(),
    tag: 'menu-detail',
  );

  final String backRoute = Get.previousRoute;

  RxList<Recipe> recipeList = <Recipe>[].obs;

  @override
  void onInit() {
    super.onInit();
    setRecipe();
    data.selectedMenu.listen((p0) => setRecipe());
  }

  @override
  void onClose() {
    data.selectedMenu.call();
    super.onClose();
  }

  void setRecipe() {
    if (data.selectedMenu.value != null) {
      recipeList.value = ingredientData.getRecipeFromRawRecipe(
        data.selectedMenu.value!.recipe,
      );
    }
  }

  Future<List<Recipe>> selectIngredients() async {
    List<Recipe> result = await Get.toNamed(
      Routes.SELECT_INGREDIENT,
      arguments: recipeList,
    );
    return result;
  }

  Future<void> addIngredients() async {
    recipeList.value = await selectIngredients();
  }

  Future<void> selectImage() async {
    await imagePicker.pickImage(ImageSource.gallery);
    final img = imagePicker.selectedImage.value;
    if (img == null) return customAlertDialog('Tidak ada gambar yang dipilih!');

    LoggerHelper.logInfo('Size before: ${await fileSize(File(img.path))}');
    final resized = await resizeImage(img);

    if (resized == null) return customAlertDialog('Gagal mengompres gambar!');
    LoggerHelper.logInfo('Size after: ${await fileSize(resized)}');

    // if (_selectedUser.value == null)
    //   return customAlertDialog('Pengguna tidak ditemukan!');
    // final mimeType = lookupMimeType(img.path)!;

    // final data = FormData({
    //   'profileImage': MultipartFile(
    //     resized,
    //     filename: 'img-${_selectedUser.value!.id}.${img.path.split('.').last}',
    //     contentType: mimeType,
    //   ),
    // });

    // await userData.updateUserProfile(data: data);
  }
}
