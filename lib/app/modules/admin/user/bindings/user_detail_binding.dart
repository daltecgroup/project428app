import 'package:abg_pos_app/app/controllers/image_picker_controller.dart';
import 'package:get/get.dart';
import '../controllers/user_detail_controller.dart';
import '../../../../data/providers/user_provider.dart';
import '../../../../controllers/user_data_controller.dart';
import '../../../../data/repositories/user_repository.dart';

class UserDetailBinding extends Bindings {
  @override
  void dependencies() {
    // user data
    Get.lazyPut<UserProvider>(() => UserProvider());
    Get.lazyPut<UserRepository>(
      () => UserRepository(userProvider: Get.find<UserProvider>()),
    );
    Get.lazyPut<UserDataController>(
      () => UserDataController(userRepository: Get.find<UserRepository>()),
    );

    // image picker controller
    Get.lazyPut<ImagePickerController>(() => ImagePickerController());

    // controller
    Get.lazyPut<UserDetailController>(
      () => UserDetailController(
        userData: Get.find<UserDataController>(),
        imagePicker: Get.find<ImagePickerController>(),
      ),
    );
  }
}
