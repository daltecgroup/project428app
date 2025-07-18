import 'package:abg_pos_app/app/shared/buttons/bottom_nav_button.dart';
import 'package:abg_pos_app/app/shared/buttons/custom_small_text_button.dart';
import 'package:abg_pos_app/app/shared/buttons/custom_text_button.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../shared/buttons/custom_elevated_button.dart';
import '../../../../utils/theme/button_style.dart';
import '../widgets/sale_bundle_item.dart';
import '../widgets/sale_promo_item.dart' as promo;
import '../widgets/sale_indicator.dart';
import '../widgets/sale_single_item.dart';
import '../../../../routes/app_pages.dart';
import '../../../../shared/custom_appbar_lite.dart';
import '../../../../shared/pages/failed_page_placeholder.dart';
import '../../../../shared/vertical_sized_box.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/theme/custom_text.dart';
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
        final promoSpendGetSetting = controller.promoSettingData
            .getPromoSetting(AppConstants.PROMO_SETTING_SPEND_GET);
        return Column(
          children: [
            // sale indicator
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.DEFAULT_PADDING,
              ),
              child: SaleIndicator(controller: controller),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(
                  horizontal: AppConstants.DEFAULT_PADDING,
                ),
                children: [
                  const VerticalSizedBox(height: 2),

                  // bundle item
                  if (bundles.isNotEmpty) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        customListHeaderText(text: 'Paket (${bundles.length})'),
                        CustomSmallTextButton(
                          title: controller.showBundles.value
                              ? 'Tutup'
                              : 'Buka',
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
                    const VerticalSizedBox(height: 2),
                  ],

                  // single item
                  if (singles.isNotEmpty) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        customListHeaderText(
                          text: 'Satuan (${singles.length})',
                        ),
                        CustomSmallTextButton(
                          title: controller.showSingles.value
                              ? 'Tutup'
                              : 'Buka',
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
                  if (controller.selectedPromo.value.isEmpty ||
                      controller.selectedPromo.value ==
                          AppConstants.PROMO_SETTING_SPEND_GET)
                    promo.SalePromoItem(
                      available: controller.promoBuyGetEligibility,
                      title: promoBuyGetSetting == null
                          ? '-'
                          : promoBuyGetSetting.title,
                      onTap: () {},
                    ),
                  const VerticalSizedBox(),

                  if (controller.selectedPromo.value.isEmpty ||
                      controller.selectedPromo.value ==
                          AppConstants.PROMO_SETTING_BUY_GET)
                    promo.SalePromoItem(
                      available: controller.promoSpendGetEligibility,
                      title: promoSpendGetSetting == null
                          ? '-'
                          : promoSpendGetSetting.title,
                      onTap: () {},
                    ),
                  const VerticalSizedBox(height: 2),
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
                          text: 'Lanjut',
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                  const VerticalSizedBox(height: 2),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
