import 'package:get/get.dart';
import '../../../../data/providers/user_provider.dart';
import '../../../../controllers/user_data_controller.dart';
import '../../../../data/repositories/user_repository.dart';
import '../controllers/edit_user_controller.dart';

class EditUserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserProvider>(() => UserProvider());
    Get.lazyPut<UserRepository>(
      () => UserRepository(userProvider: Get.find<UserProvider>()),
    );
    Get.lazyPut<UserDataController>(
      () => UserDataController(userRepository: Get.find<UserRepository>()),
    );
    Get.lazyPut<EditUserController>(
      () => EditUserController(userData: Get.find<UserDataController>()),
    );
  }
}
