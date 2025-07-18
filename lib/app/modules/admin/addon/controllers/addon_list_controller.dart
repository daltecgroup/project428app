import 'package:abg_pos_app/app/controllers/addon_data_controller.dart';
import 'package:abg_pos_app/app/data/models/Addon.dart';
import 'package:get/get.dart';

import '../../../../utils/helpers/get_storage_helper.dart';

class AddonListController extends GetxController {
  AddonListController({required this.data});
  AddonDataController data;
  late BoxHelper box;
  final String backRoute = Get.previousRoute;

  @override
  Future<void> onInit() async {
    super.onInit();
    box = BoxHelper();
    await data.syncData();
  }

  Future<void> refreshCategories() => data.syncData(refresh: true);

  List<Addon> filteredAddons({bool? status}) {
    List<Addon> list = data.addons;
    if (status != null) {
      list = data.addons.where((e) => e.isActive == status).toList();
    }
    return list;
  }
}
