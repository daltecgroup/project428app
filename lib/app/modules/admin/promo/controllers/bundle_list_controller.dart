import 'package:abg_pos_app/app/controllers/bundle_data_controller.dart';
import 'package:get/get.dart';

class BundleListController extends GetxController {
  BundleListController({required this.data});
  final BundleDataController data;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> refreshData() async => await data.syncData(refresh: true);
}
