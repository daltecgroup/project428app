import 'package:abg_pos_app/app/utils/constants/padding_constants.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../shared/pages/empty_list_page.dart';
import '../../../../utils/helpers/number_helper.dart';
import '../../../../shared/custom_appbar_lite.dart';
import '../../../../shared/vertical_sized_box.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../shared/custom_nav_item.dart';
import '../controllers/buy_get_promo_controller.dart';

class BuyGetPromoView extends GetView<BuyGetPromoController> {
  const BuyGetPromoView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarLite(title: 'Beli N Gratis N'),
      body: Obx(() {
        final setting = controller.data.getPromoSetting(
          AppConstants.PROMO_SETTING_BUY_GET,
        );
        if (setting == null)
          return EmptyListPage(
            refresh: () => controller.refreshData(),
            text: 'Gagal memperoleh pengaturan',
          );
        return RefreshIndicator(
          onRefresh: () => controller.refreshData(),
          child: ListView(
            padding: horizontalPadding,
            children: [
              const VerticalSizedBox(height: 2),

              // config
              CustomNavItem(
                leading: const Icon(Icons.local_offer_outlined),
                title: 'Status Promo',
                subTitle: setting.isActive ? 'Aktif' : 'Nonaktif',
                trailing: SizedBox(
                  height: 40,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Switch(
                      padding: EdgeInsets.zero,
                      value: setting.isActive,
                      onChanged: (value) {
                        controller.data.changeStatus(setting.id, value);
                      },
                    ),
                  ),
                ),
              ),
              CustomNavItem(
                leading: const Icon(Icons.shopping_bag_outlined),
                title: 'Belanja Minimum',
                subTitle: '${setting.nominal.round()} item',
                onTap: () => controller.setMinimumItem(),
              ),
              CustomNavItem(
                leading: const Icon(Icons.monetization_on_outlined),
                title: 'Harga Bonus',
                subTitle: 'Maks. ${inRupiah(setting.bonusMaxPrice)}',
                onTap: () => controller.setBonusItemMaxPrice(),
              ),
              CustomNavItem(
                leading: const Icon(Icons.title_outlined),
                title: 'Judul Promo',
                subTitle: setting.title,
                onTap: () => controller.setPromoTitle(),
              ),
              CustomNavItem(
                leading: const Icon(Icons.description_outlined),
                title: 'Deskripsi',
                subTitleWidget: Text(setting.description ?? '-'),
                onTap: () => controller.setPromoDescription(),
              ),
            ],
          ),
        );
      }),
    );
  }
}
