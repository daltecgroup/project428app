import 'package:abg_pos_app/app/data/models/PendingSale.dart';
import 'package:get/get.dart';

class SaleService extends GetxService {
  RxList<PendingSale> pendingSales = <PendingSale>[].obs;
  Rx<PendingSale?> selectedPendingSale = (null as PendingSale?).obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void removePendingSale(String id) {
    pendingSales.removeWhere((e) => e.id == id);
    pendingSales.refresh();
  }

  void removeEmptyPendingSale() {
    pendingSales.removeWhere(
      (pending) => pending.itemBundle.isEmpty && pending.itemSingle.isEmpty,
    );
  }
}
