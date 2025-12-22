import 'dart:io';

import 'package:abg_pos_app/app/shared/buttons/custom_text_button.dart';
import 'package:abg_pos_app/app/utils/constants/padding_constants.dart';
import 'package:abg_pos_app/app/utils/helpers/time_helper.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../../../../routes/app_pages.dart';
import '../../../../shared/custom_card.dart';
import '../../../../shared/custom_input_with_error.dart';
import '../../../../shared/custom_nav_item.dart';
import '../../../../shared/buttons/custom_small_text_button.dart';
import '../../../../shared/buttons/custom_elevated_button.dart';
import '../../../../shared/custom_appbar_lite.dart';
import '../../../../shared/pages/failed_page_placeholder.dart';
import '../../../../shared/vertical_sized_box.dart';
import '../../../../utils/helpers/text_helper.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/theme/custom_text.dart';
import '../widgets/sale_bundle_item.dart';
import '../widgets/sale_promo_item.dart' as promo;
import '../widgets/sale_indicator.dart';
import '../widgets/sale_single_item.dart';
import '../controllers/sale_input_controller.dart';

class SaleInputView extends GetView<SaleInputController> {
  const SaleInputView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarLite(
        title: 'Penjualan Baru',
        backRoute: Routes.OPERATOR_SALE,
      ),
      body: Obx(() {
        if (controller.service.isLoading.value)
          return Center(child: CircularProgressIndicator());
        if (controller.service.selectedPendingSale.value == null)
          return FailedPagePlaceholder();
        final bundles =
            controller.service.selectedPendingSale.value!.itemBundle;
        final singles =
            controller.service.selectedPendingSale.value!.itemSingle;
        final promoBuyGetSetting = controller.promoSettingData.getPromoSetting(
          AppConstants.PROMO_SETTING_BUY_GET,
        );
        final paymentEvidenceImg =
            controller.currentPendingSale!.paymentEvidenceImg;

        final currentSale = controller.currentPendingSale!;

        final promoSpendGetSetting = controller.promoSettingData
            .getPromoSetting(AppConstants.PROMO_SETTING_SPEND_GET);

        final selectedImage =
            controller.imagePickerController.selectedImage.value;
        return Stack(
          children: [
            // sale indicator
            ListView(
              padding: horizontalPadding,
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              children: [
                const VerticalSizedBox(height: 6),

                // bundle item
                if (bundles.isNotEmpty) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      customListHeaderText(text: 'Paket (${bundles.length})'),
                      CustomSmallTextButton(
                        title: controller.showBundles.value ? 'Tutup' : 'Buka',
                        icon: Icon(
                          controller.showBundles.value
                              ? Icons.expand_less_rounded
                              : Icons.expand_more_rounded,
                        ),
                        onPressed: () {
                          controller.showBundles.toggle();
                        },
                      ),
                    ],
                  ),
                  if (controller.showBundles.value) ...[
                    ...List.generate(bundles.length, (index) {
                      return SaleBundleItem(
                        controller: controller,
                        item: bundles[index],
                        index: index,
                        lastItem: index == bundles.length - 1,
                      );
                    }),
                    const VerticalSizedBox(height: 1),
                  ],
                ],
                if (controller.showBundles.value) ...[
                  CustomElevatedButton(
                    text: '+ Tambah Paket',
                    onPressed: () {
                      controller.addNewBundleMenu();
                    },
                  ),
                  const VerticalSizedBox(height: 1),
                ],

                // single item
                if (singles.isNotEmpty) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      customListHeaderText(text: 'Satuan (${singles.length})'),
                      CustomSmallTextButton(
                        title: controller.showSingles.value ? 'Tutup' : 'Buka',
                        icon: Icon(
                          controller.showSingles.value
                              ? Icons.expand_less_rounded
                              : Icons.expand_more_rounded,
                        ),
                        onPressed: () {
                          controller.showSingles.toggle();
                        },
                      ),
                    ],
                  ),
                  if (controller.showSingles.value) ...[
                    ...List.generate(singles.length, (index) {
                      return SaleSingleItem(
                        controller: controller,
                        item: singles[index],
                        index: index,
                        lastItem: index == singles.length - 1,
                      );
                    }),
                    const VerticalSizedBox(height: 1),
                  ],
                ],
                if (controller.showSingles.value) ...[
                  CustomElevatedButton(
                    text: '+ Tambah Menu',
                    onPressed: () {
                      controller.addNewSingleMenu();
                    },
                  ),
                ],
                const VerticalSizedBox(height: 2),

                // promo item
                if (controller.currentPendingSale!.itemPromo.isEmpty) ...[
                  promo.SalePromoItem(
                    available: controller.promoBuyGetEligibility,
                    title: promoBuyGetSetting == null
                        ? '-'
                        : promoBuyGetSetting.title,
                    onTap: () {
                      if (controller.promoBuyGetEligibility)
                        controller.addNewPromoItem(
                          AppConstants.PROMO_SETTING_BUY_GET,
                        );
                    },
                  ),
                  const VerticalSizedBox(),

                  promo.SalePromoItem(
                    available: controller.promoSpendGetEligibility,
                    title: promoSpendGetSetting == null
                        ? '-'
                        : promoSpendGetSetting.title,
                    onTap: () {
                      if (controller.promoSpendGetEligibility)
                        controller.addNewPromoItem(
                          AppConstants.PROMO_SETTING_SPEND_GET,
                        );
                    },
                  ),
                  const VerticalSizedBox(height: 1),
                ],

                if (controller.currentPendingSale!.itemPromo.isNotEmpty &&
                    (promoBuyGetSetting != null ||
                        promoSpendGetSetting != null)) ...[
                  CustomNavItem(
                    leading: Icon(Icons.discount_rounded),
                    trailing: GestureDetector(
                      onTap: () {
                        controller.currentPendingSale!.itemPromo.clear();
                        controller.service.selectedPendingSale.refresh();
                      },
                      child: Icon(Icons.close),
                    ),

                    titleWidget: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'PROMO: ${controller.currentPendingSale!.itemPromo.first.promoType == AppConstants.PROMO_SETTING_BUY_GET ? promoBuyGetSetting!.title : promoSpendGetSetting!.title}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    subTitle: normalizeName(
                      controller.menuData.getMenu(
                                controller
                                    .currentPendingSale!
                                    .itemPromo
                                    .first
                                    .menuId,
                              ) ==
                              null
                          ? '-'
                          : controller.menuData
                                .getMenu(
                                  controller
                                      .currentPendingSale!
                                      .itemPromo
                                      .first
                                      .menuId,
                                )!
                                .name,
                    ),
                  ),
                ],
                const VerticalSizedBox(height: 1),

                // select evidence
                CustomCard(
                  content: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          customInputTitleText(text: 'Bukti Transaksi'),
                          CustomTextButton(
                            title: 'Unggah Bukti',
                            onPressed: () async {
                              currentSale.addPaymentEvidenceImgPath(await controller.imagePickerController.pickImage(
                                ImageSource.camera,
                              )); 
                              // await controller.imagePickerController.pickImage(
                              //  ImageSource.camera,
                              // );
                            },
                          ),
                        ],
                      ),
                      // if (selectedImage != null) ...[
                      //   EvidenceImgFromMemory(controller: controller),
                      // ],
                      // const VerticalSizedBox(height: 1),
                      if (paymentEvidenceImg != '')
                        EvidenceImgFromStorage(controller: controller),
                    ],
                  ),
                ),
                const VerticalSizedBox(height: 2),

                // payment input
                CustomCard(
                  content: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Material(
                              elevation: 1,
                              borderRadius: BorderRadius.circular(
                                AppConstants.DEFAULT_BORDER_RADIUS,
                              ),
                              child: ToggleSwitch(
                                minWidth: double.infinity,
                                initialLabelIndex:
                                    controller.selectedPaymentMethod.value,
                                totalSwitches: 3,
                                cornerRadius:
                                    AppConstants.DEFAULT_BORDER_RADIUS,
                                activeFgColor: Colors.white,
                                activeBgColor: [Colors.red[900]!],
                                inactiveBgColor: Colors.grey[100],
                                labels: ['Tunai', 'Transfer', 'QRIS'],
                                onToggle: (index) {
                                  if (index != null)
                                    controller.selectedPaymentMethod.value =
                                        index;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      const VerticalSizedBox(height: 2),
                      CustomInputWithError(
                        controller: controller.paidC,
                        title: 'Jumlah Bayar',
                        hint: 'Masukkan jumlah pembayaran',
                        inputFormatter: [
                          FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                          LengthLimitingTextInputFormatter(6),
                        ],
                        inputType: TextInputType.number,
                        maxLines: 1,
                        suffixIcon: IconButton(
                          onPressed: () {
                            controller.paidC.text = controller.totalPrice
                                .toInt()
                                .toString();
                            controller.paidError.value = false;
                            controller.paidError.refresh();
                          },
                          icon: Icon(
                            Icons.check_circle_rounded,
                            size: AppConstants.DEFAULT_ICON_SIZE,
                            color:
                                controller.totalPrice <=
                                    double.parse(
                                      GetUtils.isNum(controller.paidC.text)
                                          ? controller.paidC.text
                                          : '0',
                                    )
                                ? Colors.green[700]
                                : Colors.grey,
                          ),
                        ),
                        error: controller.paidError.value,
                        errorText: controller.paidErrorText.value,
                        onChanged: (_) {
                          controller.paidError.value = false;
                          controller.paidError.refresh();
                        },
                      ),
                    ],
                  ),
                ),
                const VerticalSizedBox(height: 2),

                // navigation button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextButton(
                        child: Text('Kembali'),
                        onPressed: () => Get.back(),
                      ),
                    ),
                    SizedBox(width: AppConstants.DEFAULT_PADDING),
                    Expanded(
                      child: CustomElevatedButton(
                        text: 'Simpan',
                        onPressed: () {
                          controller.submit();
                        },
                      ),
                    ),
                  ],
                ),
                const VerticalSizedBox(height: 2),
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: horizontalPadding,
                  child: SaleIndicator(controller: controller),
                ),
              ],
            ),
          ],
        );
      }),
    );
  }
}

class EvidenceImgFromMemory extends StatelessWidget {
  const EvidenceImgFromMemory({super.key, required this.controller});

  final SaleInputController controller;

  @override
  Widget build(BuildContext context) {
    return CustomNavItem(
      disablePaddingRight: true,
      marginBottom: false,
      trailing: IconButton(
        onPressed: () {
          controller.imagePickerController.selectedImage.value = null;
        },
        icon: Icon(Icons.close),
      ),
      onTap: () {
        Get.dialog(
          Stack(
            children: [
              Container(
                padding: EdgeInsets.all(AppConstants.DEFAULT_PADDING * 2),
                child: Image.file(
                  controller.imagePickerController.selectedImage.value!,
                  fit: BoxFit.contain,
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(Icons.close),
                ),
              ),
            ],
          ),
        );
      },
      title: localDateFormat(
        controller.imagePickerController.selectedImage.value!
            .lastModifiedSync(),
      ),
      subTitle: localTimeFormat(
        controller.imagePickerController.selectedImage.value!
            .lastModifiedSync(),
      ),
      leading: SizedBox(
        width: 36,
        height: 36,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(
            AppConstants.DEFAULT_BORDER_RADIUS - 2,
          ),
          child: Image.file(
            fit: BoxFit.cover,
            controller.imagePickerController.selectedImage.value!,
          ),
        ),
      ),
    );
  }
}

class EvidenceImgFromStorage extends StatelessWidget {
  const EvidenceImgFromStorage({super.key, required this.controller});

  final SaleInputController controller;

  @override
  Widget build(BuildContext context) {
    final evidence = controller.currentPendingSale!.paymentEvidenceImg;
    return CustomNavItem(
      disablePaddingRight: true,
      marginBottom: false,
      trailing: IconButton(
        onPressed: () {
          controller.service.selectedPendingSale.value!
              .removePaymentEvidenceImgPath();
              controller.service.selectedPendingSale.refresh();
        },
        icon: Icon(Icons.close),
      ),
      onTap: () {
        Get.dialog(
          Stack(
            children: [
              Container(
                padding: EdgeInsets.all(AppConstants.DEFAULT_PADDING * 2),
                child: Image.file(File(evidence), fit: BoxFit.contain),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(Icons.close),
                ),
              ),
            ],
          ),
        );
      },
      title: localDateFormat(File(evidence).lastModifiedSync()),
      subTitle: localTimeFormat(File(evidence).lastModifiedSync()),
      leading: SizedBox(
        width: 36,
        height: 36,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(
            AppConstants.DEFAULT_BORDER_RADIUS - 2,
          ),
          child: Image.file(fit: BoxFit.cover, File(evidence)),
        ),
      ),
    );
  }
}
