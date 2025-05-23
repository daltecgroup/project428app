import 'package:get/get.dart';
import 'package:project428app/app/data/outlet_provider.dart';
import 'package:project428app/app/modules/gerai/models/outlet_list_item.dart';

class GeraiController extends GetxController {
  OutletProvider OutletP = OutletProvider();
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

  getOutletList() {
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
