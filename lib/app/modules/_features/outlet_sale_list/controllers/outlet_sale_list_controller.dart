import 'package:abg_pos_app/app/controllers/outlet_data_controller.dart';
import 'package:abg_pos_app/app/controllers/sale_data_controller.dart';
import 'package:abg_pos_app/app/utils/helpers/get_storage_helper.dart';
import 'package:get/get.dart';

class OutletSaleListController extends GetxController {
  OutletSaleListController({required this.outletData, required this.data});
  final OutletDataController outletData;
  final SaleDataController data;

  BoxHelper box = BoxHelper();

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
}
