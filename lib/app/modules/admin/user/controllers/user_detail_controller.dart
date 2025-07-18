import 'package:get/get.dart';
import '../../../../data/models/User.dart';
import '../../../../shared/alert_snackbar.dart';
import '../../../../controllers/user_data_controller.dart';

class UserDetailController extends GetxController {
  UserDetailController({required this.userData});
  UserDataController userData;
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
}
