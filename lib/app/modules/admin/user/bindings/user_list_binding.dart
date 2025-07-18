import 'package:get/get.dart';
import '../../../../data/providers/user_provider.dart';
import '../controllers/user_list_controller.dart';
import '../../../../controllers/user_data_controller.dart';
import '../../../../data/repositories/user_repository.dart';

class UserListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserProvider>(() => UserProvider());
    Get.lazyPut<UserRepository>(
      () => UserRepository(userProvider: Get.find<UserProvider>()),
    );
    Get.lazyPut<UserDataController>(
      () => UserDataController(userRepository: Get.find<UserRepository>()),
    );
    Get.lazyPut<UserListController>(
      () => UserListController(userData: Get.find<UserDataController>()),
    );
  }
}
