import '../../shared/custom_alert.dart';
import 'package:get/get.dart';

class PendingSaleItemSingleAddon {
  String addonId;

  PendingSaleItemSingleAddon({required this.addonId});
}

class PendingSaleItemSingle {
  String menuId;
  int qty;
  String? notes;
  List<PendingSaleItemSingleAddon> addons = [];

  PendingSaleItemSingle({required this.menuId, required this.qty, this.notes});

  void addQty() {
    qty++;
  }

  void removeQty() {
    qty = qty > 0 ? qty - 1 : 0;
  }

  void addAddon(String addonId) {
    addons.add(PendingSaleItemSingleAddon(addonId: addonId));
  }

  void removeAddon(int index) {
    addons.removeAt(index);
  }

  void addNotes(String? notes) {
    this.notes = notes;
  }

  void removeNotes() {
    notes = null;
  }
}

class ItemBundleMenuSlot {
  String menuCategoryId;
  String? menuId;

  ItemBundleMenuSlot({required this.menuCategoryId});

  void setMenuId(String id) {
    menuId = id;
  }

  bool get isEmpty {
    return menuId == null;
  }

  void removeMenuId() {
    menuId = null;
  }
}

class PendingSaleItemBundle {
  String bundleId;
  int qty;
  List<ItemBundleMenuSlot> items = [];

  PendingSaleItemBundle({required this.bundleId, required this.qty});

  void setItems(List<ItemBundleMenuSlot> slots) {
    items.assignAll(slots);
  }

  bool get isAnyItemEmpty => items.any((item) => item.isEmpty);

  void addQty() {
    qty++;
  }

  void removeQty() {
    qty = qty > 0 ? qty - 1 : 0;
  }
}

class PendingSaleItemPromo {
  String menuId, promoType;

  PendingSaleItemPromo({required this.menuId, required this.promoType});
}

class PendingSale {
  final String id = DateTime.now().millisecondsSinceEpoch.toString();
  final List<PendingSaleItemSingle> itemSingle = [];
  final List<PendingSaleItemBundle> itemBundle = [];
  final List<PendingSaleItemPromo> itemPromo = [];

  String paymentEvidenceImg = '';

  Future<void> removeItemSingle(int index) async {
    await customDeleteAlertDialog('Yakin menghapus item?', () {
      Get.back();
      itemSingle.removeAt(index);
    });
  }

  Future<void> removeItemBundle(int index) async {
    await customDeleteAlertDialog('Yakin menghapus paket?', () {
      Get.back();
      itemBundle.removeAt(index);
    });
  }

  bool get isAnyItemBundleEmpty {
    if (itemBundle.isEmpty) return false;
    return itemBundle.any((bundle) => bundle.isAnyItemEmpty);
  }

  int get itemCount {
    final singleCount = itemSingle.fold<int>(0, (sum, e) => sum + e.qty);
    final bundleCount = itemBundle.fold(0, (sum, e) {
      final filledSlots = e.items.where((slot) => !slot.isEmpty).length;
      return sum + (filledSlots * e.qty);
    });
    return singleCount + bundleCount;
  }

  void addSingleItem(PendingSaleItemSingle item) {
    itemSingle.add(item);
  }

  void addBundleItem(PendingSaleItemBundle item) {
    itemBundle.add(item);
  }

  void addPromoItem(PendingSaleItemPromo item) {
    if (itemPromo.isEmpty) {
      itemPromo.add(item);
      return;
    }
    if (itemPromo.length > 1) {
      itemPromo.clear();
      itemPromo.add(item);
    }
  }

  void addPaymentEvidenceImgPath(String path){
    paymentEvidenceImg = path;
  }

  void removePaymentEvidenceImgPath(){
    paymentEvidenceImg = '';
  }
}
