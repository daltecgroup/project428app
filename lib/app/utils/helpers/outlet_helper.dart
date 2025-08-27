import 'package:abg_pos_app/app/controllers/outlet_data_controller.dart';
import 'package:abg_pos_app/app/data/providers/outlet_provider.dart';
import 'package:abg_pos_app/app/data/repositories/outlet_repository.dart';
import 'package:abg_pos_app/app/utils/constants/app_constants.dart';
import 'package:abg_pos_app/app/utils/helpers/get_storage_helper.dart';
import 'package:abg_pos_app/app/utils/helpers/text_helper.dart';
import 'package:get/get.dart';

final OutletDataController outletData = Get.isRegistered<OutletDataController>()
    ? Get.find<OutletDataController>()
    : Get.put(
        OutletDataController(
          repository: Get.put(
            OutletRepository(provider: Get.put(OutletProvider())),
          ),
        ),
      );

String? get currentOutletName {
  final key = AppConstants.KEY_CURRENT_OUTLET;
  if (box.isNull(key)) return null;
  final outlet = outletData.getOutletById(box.getValue(key));
  if (outlet == null) return null;
  return normalizeName(outlet.name);
}
