import 'package:get/get.dart';
import 'package:project428app/app/data/providers/outlet_provider.dart';
import 'package:project428app/app/modules/gerai/models/outlet_list_item.dart';
import 'package:project428app/app/services/outlet_service.dart';

class GeraiController extends GetxController {
  OutletProvider OutletP = OutletProvider();
  OutletService OutletS = Get.find<OutletService>();
  RxList<OutletListItem> outletList = <OutletListItem>[].obs;

  @override
  void onInit() {
    getOutletList();
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

  void getOutletList() {
    outletList.clear();
    try {
      OutletP.getOutlets().then((res) {
        for (var e in res.body) {
          outletList.add(OutletListItem.fromJson(e));
        }
        outletList = outletList.reversed.toList().obs;
        outletList.refresh();
      });
    } catch (e) {
      print(e);
    }
  }

  List<String> getAllRegencyOfOutletList() {
    List<String> regency = [];
    for (var e in outletList) {
      regency.add(e.regency);
    }

    return regency.toSet().toList();
  }

  List<OutletListItem> getOutletItemByRegency(String regency) {
    return outletList.where((outlet) {
      return outlet.regency == regency;
    }).toList();
  }
}
