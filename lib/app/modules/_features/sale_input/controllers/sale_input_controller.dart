import 'package:abg_pos_app/app/controllers/bundle_data_controller.dart';
import 'package:abg_pos_app/app/controllers/menu_category_data_controller.dart';
import 'package:abg_pos_app/app/controllers/promo_setting_data_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../controllers/addon_data_controller.dart';
import '../../../../controllers/menu_data_controller.dart';
import '../../../../routes/app_pages.dart';
import '../../../../shared/custom_alert.dart';
import '../../../../shared/custom_nav_item.dart';
import '../../../../utils/helpers/number_helper.dart';
import '../../../../utils/helpers/text_helper.dart';
import '../../../../utils/services/sale_service.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/theme/text_style.dart';
import '../../../../data/models/PendingSale.dart';

class SaleInputController extends GetxController {
  SaleInputController({
    required this.bundleData,
    required this.menuData,
    required this.menuCategoryData,
    required this.addonData,
    required this.promoSettingData,
    required this.service,
  });
  final BundleDataController bundleData;
  final AddonDataController addonData;
  final MenuDataController menuData;
  final MenuCategoryDataController menuCategoryData;
  final PromoSettingDataController promoSettingData;
  final SaleService service;

  // input controllers
  final TextEditingController inputC = TextEditingController();

  // boolean
  RxBool showBundles = true.obs;
  RxBool showSingles = true.obs;

  RxString selectedPromo = ''.obs;

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
    inputC.dispose();
    service.removeEmptyPendingSale();
    super.onClose();
  }

  PendingSale? get currentPendingSale {
    return service.selectedPendingSale.value;
  }

  bool get promoBuyGetEligibility {
    bool status = false;

    final promoSetting = promoSettingData.getPromoSetting(
      AppConstants.PROMO_SETTING_BUY_GET,
    );

    if (promoSetting != null) {
      if (promoSetting.isActive &&
          service.selectedPendingSale.value!.itemCount >=
              promoSetting.nominal.toInt())
        status = true;
    }

    return status;
  }

  bool get promoSpendGetEligibility {
    bool status = false;

    final promoSetting = promoSettingData.getPromoSetting(
      AppConstants.PROMO_SETTING_SPEND_GET,
    );

    if (promoSetting != null) {
      if (promoSetting.isActive && totalPrice >= promoSetting.nominal)
        status = true;
    }

    return status;
  }

  double get totalPrice {
    double total = 0;
    if (currentPendingSale == null) return 0;

    if (currentPendingSale!.itemSingle.isNotEmpty) {
      for (var item in currentPendingSale!.itemSingle) {
        final menu = menuData.getMenu(item.menuId);
        if (menu != null) {
          total = total + (item.qty.toDouble() * menu.priceAfterDiscount);
          if (item.addons.isNotEmpty) {
            for (var itemAddon in item.addons) {
              final addon = addonData.getAddon(itemAddon.addonId);
              if (addon != null) {
                total = total + addon.price;
              }
            }
          }
        }
      }
    }

    if (currentPendingSale!.itemBundle.isNotEmpty) {
      for (var item in currentPendingSale!.itemBundle) {
        final bundle = bundleData.getBundle(item.bundleId);
        if (bundle != null) {
          total = total + (item.qty.toDouble() * bundle.price);
        }
      }
    }

    return total;
  }

  double get totalSaving {
    double total = 0;
    if (currentPendingSale == null) return 0;

    if (currentPendingSale!.itemSingle.isNotEmpty) {
      for (var item in currentPendingSale!.itemSingle) {
        final menu = menuData.getMenu(item.menuId);
        if (menu != null) {
          total = total + (item.qty.toDouble() * menu.savings);
        }
      }
    }

    return total;
  }

  Future<String?> addAddon() async {
    return await Get.defaultDialog(
      title: 'Pilih Addon',
      titleStyle: AppTextStyle.dialogTitle,
      radius: AppConstants.DEFAULT_BORDER_RADIUS,
      contentPadding: EdgeInsets.all(AppConstants.DEFAULT_PADDING),
      content: Container(
        constraints: BoxConstraints(
          maxHeight: Get.height - 200,
          maxWidth: Get.width - 40,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ...addonData.addons.map(
                (addon) => CustomNavItem(
                  title: addon.name,
                  subTitle: inRupiah(addon.price),
                  onTap: () {
                    Get.back(result: addon.id);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addNotes(PendingSaleItemSingle item) async {
    inputC.text = item.notes ?? '';
    final notes = await customTextInputDialog(
      title: normalizeName(menuData.getMenu(item.menuId)!.name),
      initialValue: item.notes,
      controller: inputC,
      disableText: true,
      maxLines: 2,
      labelText: 'Tulis Catatan:',
      inputType: TextInputType.text,
    );
    item.addNotes(notes != null && notes != '' ? notes : null);
    inputC.clear();
  }

  Future<void> addNewBundleMenu() async {
    final newBundleId = await Get.toNamed(Routes.SELECT_BUNDLE);

    if (newBundleId != null && newBundleId is String) {
      final bundle = bundleData.getBundle(newBundleId);

      if (bundle == null) return;
      List<ItemBundleMenuSlot> slots = [];
      for (var category in bundle.categories) {
        for (var i = 0; i < category.qty; i++) {
          slots.add(
            ItemBundleMenuSlot(menuCategoryId: category.menuCategoryId),
          );
        }
      }

      final newBundleItem = PendingSaleItemBundle(
        bundleId: newBundleId,
        qty: 1,
      );
      newBundleItem.setItems(slots);
      currentPendingSale!.addBundleItem(newBundleItem);
      service.selectedPendingSale.refresh();
    }
  }

  Future<void> addNewSingleMenu() async {
    final newMenuId = await Get.toNamed(Routes.SELECT_MENU);
    if (newMenuId != null && newMenuId is String) {
      currentPendingSale!.addSingleItem(
        PendingSaleItemSingle(menuId: newMenuId, qty: 1),
      );
      service.selectedPendingSale.refresh();
    }
  }

  Future<void> addNewPromoItem(String promoType) async {
    final newMenuId = await Get.toNamed(Routes.SELECT_MENU);
    if (newMenuId != null && newMenuId is String) {
      currentPendingSale!.addPromoItem(PendingSaleItemPromo(menuId: newMenuId));
      service.selectedPendingSale.refresh();
    }
  }
}
