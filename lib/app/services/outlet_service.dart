import 'package:get/get.dart';
import 'package:project428app/app/data/models/outlet.dart';

import '../data/providers/outlet_provider.dart';

class OutletService extends GetxService {
  OutletProvider OutletP = OutletProvider();
  RxList<Outlet> outlets = <Outlet>[].obs;
  @override
  void onInit() {
    super.onInit();
    Future.delayed(Duration(seconds: 5)).then((_) async {
      getOutlets();
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getOutlets() {
    outlets.clear();
    try {
      OutletP.getOutlets().then((res) {
        if (res.statusCode == 200) {
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

  // delete outlet
  void deleteOutlet() {}
}
