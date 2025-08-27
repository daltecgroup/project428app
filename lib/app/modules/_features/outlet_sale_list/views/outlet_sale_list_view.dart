import 'package:abg_pos_app/app/shared/custom_appbar_lite.dart';
import 'package:abg_pos_app/app/shared/pages/failed_page_placeholder.dart';
import 'package:abg_pos_app/app/utils/constants/padding_constants.dart';
import 'package:abg_pos_app/app/utils/helpers/text_helper.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';
import '../../../../shared/custom_nav_item.dart';
import '../../../../shared/pages/empty_list_page.dart';
import '../../../../shared/vertical_sized_box.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/helpers/get_storage_helper.dart';
import '../../../../utils/helpers/number_helper.dart';
import '../../../../utils/helpers/time_helper.dart';
import '../../../../utils/theme/custom_text.dart';
import '../controllers/outlet_sale_list_controller.dart';

class OutletSaleListView extends GetView<OutletSaleListController> {
  const OutletSaleListView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final outlet = controller.outletData.currentOutlet;
      if (outlet == null) return FailedPagePlaceholder();
      return Scaffold(
        appBar: customAppBarLite(
          title: 'Penjualan Gerai',
          subtitle: normalizeName(outlet.name),
          backRoute: controller.backRoute,
        ),
        body: Obx(() {
          String? currentOutlet = box.getValue(AppConstants.KEY_CURRENT_OUTLET);

          if (controller.data.groupedSales(outletId: currentOutlet).isEmpty)
            return EmptyListPage(
              refresh: () => controller.data.syncData(refresh: true),
              text: 'Penjualan Kosong',
            );
          return RefreshIndicator(
            onRefresh: () => controller.data.syncData(refresh: true),
            child: ListView(
              padding: horizontalPadding,
              children: [
                const VerticalSizedBox(height: 2),

                // sale history
                if (controller.data
                    .groupedSales(outletId: currentOutlet)
                    .isNotEmpty) ...[
                  customInputTitleText(text: 'Riwayat Penjualan'),
                  const VerticalSizedBox(height: 0.7),
                  ...controller.data
                      .groupedSales(outletId: currentOutlet)
                      .entries
                      .expand((entry) {
                        return [
                          Text(
                            contextualLocalDateFormat(
                              DateTime.parse(entry.key),
                            ).capitalize!,
                          ),
                          const VerticalSizedBox(height: 0.7),
                          ...entry.value.map((sale) {
                            return CustomNavItem(
                              onTap: () {
                                controller.data.selectedSale.value = sale;
                                Get.toNamed(Routes.OPERATOR_SALE_DETAIL);
                              },
                              title: sale.code,
                              subTitle:
                                  '${localTimeFormat(sale.createdAt)} - ${sale.itemCount} item, ${inRupiah(sale.totalPrice)}',
                            );
                          }),
                        ];
                      }),
                ],
                const VerticalSizedBox(height: 5),
              ],
            ),
          );
        }),
      );
    });
  }
}
