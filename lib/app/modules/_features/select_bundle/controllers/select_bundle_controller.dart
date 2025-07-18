import 'package:abg_pos_app/app/controllers/bundle_data_controller.dart';
import 'package:abg_pos_app/app/data/models/Bundle.dart';
import 'package:get/get.dart';

class SelectBundleController extends GetxController {
  SelectBundleController({required this.bundleData});
  final BundleDataController bundleData;

  RxBool showOnline = false.obs;

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

  List<Bundle> get getBundles {
    if (showOnline.value) {
      return bundleData.bundles
          .where((bundle) => bundle.name.contains('online'))
          .toList();
    }
    return bundleData.bundles;
  }
}
