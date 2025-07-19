import 'package:get/get.dart';
import '../../data/models/PendingSale.dart';

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
