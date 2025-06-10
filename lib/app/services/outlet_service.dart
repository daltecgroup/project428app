import 'package:get/get.dart';
import 'package:project428app/app/data/models/outlet.dart';

import '../data/providers/outlet_provider.dart';
import '../modules/gerai/models/outlet_list_item.dart';

class OutletService extends GetxService {
  OutletProvider OutletP = OutletProvider();
  RxList<Outlet> outlets = <Outlet>[].obs;
  RxList<OutletListItem> outletList = <OutletListItem>[].obs;

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

  void getOutlets() {
    try {
      OutletP.getOutlets().then((res) {
        if (res.statusCode == 200) {
          outlets.clear();
          for (var e in res.body) {
            outlets.add(Outlet.fromJson(e));
          }
          outlets = outlets.reversed.toList().obs;
          outlets.refresh();
        } else {
          print('Failed: Getting outlets data from database');
        }
      });
    } catch (e) {
      print(e);
    }
  }

  void getOutletList() {
    try {
      OutletP.getOutlets().then((res) {
        if (res.statusCode == 200) {
          outletList.clear();
          for (var e in res.body) {
            outletList.add(OutletListItem.fromJson(e));
          }
          outletList = outletList.reversed.toList().obs;
          outletList.refresh();
        }
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

  // delete outlet
  void deleteOutlet() {}
}
