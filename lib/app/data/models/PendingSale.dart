import 'package:abg_pos_app/app/shared/custom_alert.dart';
import 'package:get/get.dart';

class PendingSaleItemSingleAddon {
  String addonId;

  PendingSaleItemSingleAddon({required this.addonId});
}

class PendingSaleItemSingle {
  String menuId;
  String? notes;
  int qty;
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
  String menuId;

  PendingSaleItemPromo({required this.menuId});
}

class PendingSale {
  final String id = DateTime.now().millisecondsSinceEpoch.toString();
  final List<PendingSaleItemSingle> itemSingle = [];
  final List<PendingSaleItemBundle> itemBundle = [];
  final List<PendingSaleItemPromo> itemPromo = [];

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

  int get itemCount {
    final singleCount = itemSingle.fold<int>(0, (sum, e) => sum + e.qty);
    final bundleCount = itemBundle.fold(0, (sum, e) {
      final filledSlots = e.items.where((slot) => !slot.isEmpty).length;
      return sum + (filledSlots * e.qty);
    });
    final promoCount = itemPromo.length;
    return singleCount + bundleCount + promoCount;
  }

  void addSingleItem(PendingSaleItemSingle item) {
    itemSingle.add(item);
  }

  void addBundleItem(PendingSaleItemBundle item) {
    itemBundle.add(item);
  }

  void addPromoItem(PendingSaleItemPromo item) {
    itemPromo.add(item);
  }
}
