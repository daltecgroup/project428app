import 'package:get/get.dart';
import '../../../../controllers/bundle_data_controller.dart';
import '../../../../controllers/menu_category_data_controller.dart';
import '../../../../controllers/menu_data_controller.dart';
import '../../../../data/models/Bundle.dart';
import '../../../../data/models/PendingSale.dart';
import '../../../../utils/services/sale_service.dart';
import '../../../../routes/app_pages.dart';

class SelectSaleItemController extends GetxController {
  SelectSaleItemController({
    required this.categoryData,
    required this.menuData,
    required this.bundleData,
    required this.service,
  });
  final MenuCategoryDataController categoryData;
  final MenuDataController menuData;
  final BundleDataController bundleData;
  final SaleService service;

  RxMap<String, int> selectedMenu = <String, int>{}.obs;
  RxMap<String, int> selectedBundle = <String, int>{}.obs;

  RxBool showOnline = false.obs;

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

  int menuCount(String menuId) {
    if (selectedMenu[menuId] == null) return 0;
    return selectedMenu[menuId] ?? 0;
  }

  void addMenuQty(String menuId) {
    if (selectedMenu[menuId] == null) {
      selectedMenu[menuId] = 1;
    } else {
      selectedMenu[menuId] = selectedMenu[menuId]! + 1;
    }
  }

  void resetMenuQty(String menuId) {
    selectedMenu.remove(menuId);
  }

  void substractMenuQty(String menuId) {
    if (selectedMenu[menuId] == 1) return resetMenuQty(menuId);
    selectedMenu[menuId] = selectedMenu[menuId]! - 1;
  }

  int bundleCount(String bundleId) {
    if (selectedBundle[bundleId] == null) return 0;
    return selectedBundle[bundleId] ?? 0;
  }

  void addBundleQty(String bundleId) {
    if (selectedBundle[bundleId] == null) {
      selectedBundle[bundleId] = 1;
    } else {
      selectedBundle[bundleId] = selectedBundle[bundleId]! + 1;
    }
  }

  void resetBundleQty(String bundleId) {
    selectedBundle.remove(bundleId);
  }

  void substractBundleQty(String bundleId) {
    if (selectedBundle[bundleId] == 1) return resetBundleQty(bundleId);
    selectedBundle[bundleId] = selectedBundle[bundleId]! - 1;
  }

  void createPendingSale() {
    if (selectedBundle.isEmpty && selectedMenu.isEmpty) return Get.back();
    service.isLoading.value = true;
    final PendingSale newPendingSale = PendingSale();

    newPendingSale.itemBundle.assignAll(
      selectedBundle.entries.map((e) {
        List<ItemBundleMenuSlot> slots = [];
        Bundle bundle = bundleData.getBundle(e.key)!;
        for (var category in bundle.categories) {
          for (var i = 0; i < category.qty; i++) {
            slots.add(
              ItemBundleMenuSlot(menuCategoryId: category.menuCategoryId),
            );
          }
        }
        PendingSaleItemBundle newItemBundle = PendingSaleItemBundle(
          bundleId: e.key,
          qty: e.value,
        );
        newItemBundle.setItems(slots);
        return newItemBundle;
      }).toList(),
    );
    newPendingSale.itemSingle.assignAll(
      selectedMenu.entries
          .map((e) => PendingSaleItemSingle(menuId: e.key, qty: e.value))
          .toList(),
    );

    service.pendingSales.add(newPendingSale);
    service.selectedPendingSale.value = newPendingSale;
    service.selectedPendingSale.refresh();
    selectedBundle.clear();
    selectedMenu.clear();
    service.isLoading.value = false;
    Get.toNamed(Routes.SALE_INPUT);
  }
}
