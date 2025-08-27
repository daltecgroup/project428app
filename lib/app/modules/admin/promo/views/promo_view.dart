import 'package:abg_pos_app/app/utils/constants/padding_constants.dart';
import 'package:abg_pos_app/app/utils/helpers/number_helper.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../routes/app_pages.dart';
import '../../../../shared/custom_appbar_lite.dart';
import '../../../../shared/custom_nav_item.dart';
import '../../../../shared/vertical_sized_box.dart';
import '../../../../utils/constants/app_constants.dart';
import '../controllers/promo_controller.dart';

class PromoView extends GetView<PromoController> {
  const PromoView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarLite(
        context: context,
        title: 'Promo',
        backRoute: Routes.PRODUCT,
      ),
      body: Obx(() {
        int bundleCount = controller.bundleData.bundles.length;
        final buyGet = controller.promoData.getPromoSetting(
          AppConstants.PROMO_SETTING_BUY_GET,
        );
        final spendGet = controller.promoData.getPromoSetting(
          AppConstants.PROMO_SETTING_SPEND_GET,
        );
        return ListView(
          padding: horizontalPadding,
          children: [
            const VerticalSizedBox(height: 2),
            CustomNavItem(
              title: 'Paket Menu',
              subTitle: '$bundleCount item',
              onTap: () {
                Get.toNamed(Routes.BUNDLE_LIST);
              },
            ),
            CustomNavItem(
              title: 'Beli N Gratis N',
              subTitle: buyGet == null
                  ? null
                  : '${buyGet.isActive ? 'Aktif' : 'Nonaktif'}, min. ${buyGet.nominal.round()} item',
              onTap: () => Get.toNamed(Routes.BUY_GET_PROMO),
            ),
            CustomNavItem(
              title: 'Belanja N Gratis N',
              subTitle: spendGet == null
                  ? null
                  : '${spendGet.isActive ? 'Aktif' : 'Nonaktif'}, min. ${inLocalNumber(spendGet.nominal)}',
              onTap: () => Get.toNamed(Routes.SPEND_GET_PROMO),
            ),
          ],
        );
      }),
    );
  }
}
