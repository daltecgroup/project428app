import 'package:abg_pos_app/app/controllers/bundle_data_controller.dart';
import 'package:get/get.dart';

import '../../../../data/providers/bundle_provider.dart';
import '../../../../data/repositories/bundle_repository.dart';
import '../controllers/select_bundle_controller.dart';

class SelectBundleBinding extends Bindings {
  @override
  void dependencies() {
    // bundle data
    Get.lazyPut<BundleProvider>(() => BundleProvider());
    Get.lazyPut<BundleRepository>(
      () => BundleRepository(provider: Get.find<BundleProvider>()),
    );
    Get.lazyPut<BundleDataController>(
      () => BundleDataController(repository: Get.find<BundleRepository>()),
    );

    Get.lazyPut<SelectBundleController>(
      () =>
          SelectBundleController(bundleData: Get.find<BundleDataController>()),
    );
  }
}
