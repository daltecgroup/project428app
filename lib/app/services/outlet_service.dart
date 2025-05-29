import 'package:get/get.dart';
import 'package:project428app/app/models/outlet.dart';

import '../data/outlet_provider.dart';

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
        for (var e in res.body) {
          outlets.add(Outlet.fromJson(e));
        }
        outlets = outlets.reversed.toList().obs;
        outlets.refresh();
      });
    } catch (e) {
      print(e);
    }
  }
}
