import 'package:abg_pos_app/app/controllers/image_picker_controller.dart';
import 'package:abg_pos_app/app/controllers/sale_data_controller.dart';
import 'package:abg_pos_app/app/utils/helpers/get_storage_helper.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mime/mime.dart';
import '../../../../controllers/bundle_data_controller.dart';
import '../../../../controllers/menu_category_data_controller.dart';
import '../../../../controllers/promo_setting_data_controller.dart';
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
    required this.service,
    required this.bundleData,
    required this.menuData,
    required this.menuCategoryData,
    required this.addonData,
    required this.promoSettingData,
    required this.imagePickerController,
    required this.saleData,
  });

  // box
  BoxHelper box = BoxHelper();

  // data controllers
  final SaleService service;
  final BundleDataController bundleData;
  final AddonDataController addonData;
  final MenuDataController menuData;
  final MenuCategoryDataController menuCategoryData;
  final PromoSettingDataController promoSettingData;
  final ImagePickerController imagePickerController;
  final SaleDataController saleData;

  // input controllers
  final TextEditingController inputC = TextEditingController();
  final TextEditingController paidC = TextEditingController();

  // boolean
  RxBool showBundles = true.obs;
  RxBool showSingles = true.obs;
  RxBool paidError = false.obs;

  // String text
  RxString paidErrorText = ''.obs;

  // selected indicator
  RxInt selectedPaymentMethod = 0.obs;

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
    paidC.dispose();
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
                total = total + (addon.price * item.qty);
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
      currentPendingSale!.addPromoItem(
        PendingSaleItemPromo(menuId: newMenuId, promoType: promoType),
      );
      service.selectedPendingSale.refresh();
    }
  }

  bool get isError {
    final errors = <String>[];

    void setPaidError(String message) {
      errors.add(message);
      paidError.value = true;
      paidErrorText.value = message;
    }

    final paidText = paidC.text;

    if (paidText.isEmpty) {
      setPaidError('Kolom jumlah bayar harus diisi');
    } else if (!GetUtils.isNum(paidText)) {
      setPaidError('Jumlah bayar harus berupa angka');
    } else {
      final paidAmount = double.parse(paidText);
      if (paidAmount < totalPrice) {
        setPaidError(
          'Jumlah yang dibayarkan kurang ${inLocalNumber(totalPrice - paidAmount)}',
        );
      }
    }

    if (currentPendingSale!.isAnyItemBundleEmpty) {
      errors.add('Item Paket harus diisi');
    }

    if (errors.isNotEmpty) {
      customAlertDialogWithTitle(
        title: 'Peringatan',
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
            errors.length,
            (i) => Text('${i + 1}. ${errors[i]}'),
          ),
        ),
      );
    }

    return errors.isNotEmpty;
  }

  Future<void> submit() async {
    if (currentPendingSale == null) {
      customAlertDialog('Data pembelian tidak ditemukan');
      return;
    }

    if (currentPendingSale!.itemBundle.isEmpty &&
        currentPendingSale!.itemSingle.isEmpty) {
      customAlertDialog('Tidak ada produk yang dipilih');
      return;
    }

    if (!promoBuyGetEligibility && currentPendingSale!.itemPromo.isNotEmpty) {
      if (currentPendingSale!.itemPromo.first.promoType ==
          AppConstants.PROMO_SETTING_BUY_GET)
        currentPendingSale!.itemPromo.clear();
    }
    if (!promoSpendGetEligibility && currentPendingSale!.itemPromo.isNotEmpty) {
      if (currentPendingSale!.itemPromo.first.promoType ==
          AppConstants.PROMO_SETTING_SPEND_GET)
        currentPendingSale!.itemPromo.clear();
    }

    service.selectedPendingSale.refresh();

    if ((promoBuyGetEligibility || promoSpendGetEligibility) &&
        currentPendingSale!.itemPromo.isEmpty) {
      final promoConf = await customConfirmationDialog(
        'Promo tersedia. Yakin lanjut tanpa pilih promo?',
        () {
          Get.back(result: false);
        },
      );
      if (promoConf ?? true) {
        return;
      }
    }

    if (!isError) {
      final FormData formData = FormData({
        'outletId': box.getValue(AppConstants.KEY_CURRENT_OUTLET),
        'totalPaid': paidC.text,
      });

      const paymentMethods = [
        AppConstants.PAYMENT_CASH,
        AppConstants.PAYMENT_TRANSFER,
        AppConstants.PAYMENT_QRIS,
      ];

      formData.fields.add(
        MapEntry(
          'payment[method]',
          paymentMethods[selectedPaymentMethod.value],
        ),
      );
      final imageFile = imagePickerController.selectedImage.value;

      if (imageFile != null) {
        final mimeType = lookupMimeType(imageFile.path)!;
        formData.files.add(
          MapEntry(
            'paymentEvidence',
            MultipartFile(
              imageFile,
              filename:
                  'img-${currentPendingSale!.id}.${imageFile.path.split('.').last}',
              contentType: mimeType,
            ),
          ),
        );
      }

      final itemSingle = currentPendingSale!.itemSingle;
      if (itemSingle.isNotEmpty) {
        for (var i = 0; i < itemSingle.length; i++) {
          formData.fields.add(
            MapEntry('itemSingle[$i][menuId]', itemSingle[i].menuId),
          );
          formData.fields.add(
            MapEntry('itemSingle[$i][qty]', itemSingle[i].qty.toString()),
          );

          if (itemSingle[i].notes != null) {
            formData.fields.add(
              MapEntry('itemSingle[$i][notes]', itemSingle[i].notes!),
            );
          }

          if (itemSingle[i].addons.isNotEmpty) {
            for (var j = 0; j < itemSingle[i].addons.length; j++) {
              formData.fields.add(
                MapEntry(
                  'itemSingle[$i][addons][$j][addonId]',
                  itemSingle[i].addons[j].addonId,
                ),
              );
              formData.fields.add(
                MapEntry('itemSingle[$i][addons][$j][qty]', 1.toString()),
              );
            }
          }
        }
      }

      final itemBundle = currentPendingSale!.itemBundle;
      if (itemBundle.isNotEmpty) {
        for (var i = 0; i < itemBundle.length; i++) {
          formData.fields.add(
            MapEntry('itemBundle[$i][menuBundleId]', itemBundle[i].bundleId),
          );
          formData.fields.add(
            MapEntry('itemBundle[$i][qty]', itemBundle[i].qty.toString()),
          );

          if (itemBundle[i].items.isNotEmpty) {
            for (var j = 0; j < itemBundle[i].items.length; j++) {
              formData.fields.add(
                MapEntry(
                  'itemBundle[$i][items][$j][menuId]',
                  itemBundle[i].items[j].menuId!,
                ),
              );
              formData.fields.add(
                MapEntry('itemBundle[$i][items][$j][qty]', 1.toString()),
              );
            }
          }
        }
      }

      final itemPromo = currentPendingSale!.itemPromo;
      if (itemPromo.isNotEmpty) {
        for (var i = 0; i < itemPromo.length; i++) {
          formData.fields.add(
            MapEntry('itemPromo[$i][menuId]', itemPromo[i].menuId),
          );
          formData.fields.add(MapEntry('itemPromo[$i][qty]', 1.toString()));
        }
      }

      // print(formData.files.first.value.filename);
      await saleData.createSale(formData);
      service.pendingSales.removeWhere(
        (e) => e.id == service.selectedPendingSale.value!.id,
      );
    }
  }
}
