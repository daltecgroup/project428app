import 'package:abg_pos_app/app/shared/pages/empty_list_page.dart';
import 'package:abg_pos_app/app/utils/helpers/get_storage_helper.dart';
import 'package:abg_pos_app/app/utils/helpers/number_helper.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../shared/buttons/delete_icon_button.dart';
import '../../../../shared/buttons/floating_add_button.dart';
import '../../../../shared/custom_nav_item.dart';
import '../../../../shared/vertical_sized_box.dart';
import '../../../../shared/custom_appbar.dart';
import '../../../../shared/custom_drawer.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/helpers/time_helper.dart';
import '../../../../utils/theme/custom_text.dart';
import '../../../../routes/app_pages.dart';
import '../controllers/operator_sale_controller.dart';

class OperatorSaleView extends GetView<OperatorSaleController> {
  const OperatorSaleView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('Penjualan'),
      drawer: customDrawer(),
      body: Obx(() {
        BoxHelper box = BoxHelper();
        String? currentOutlet = box.getValue(AppConstants.KEY_CURRENT_OUTLET);

        if (controller.service.pendingSales.isEmpty &&
            controller.data.groupedSales(outletId: currentOutlet).isEmpty)
          return EmptyListPage(
            refresh: () => controller.data.syncData(refresh: true),
            text: 'Penjualan Kosong',
          );
        return RefreshIndicator(
          onRefresh: () => controller.data.syncData(refresh: true),
          child: ListView(
            padding: EdgeInsets.symmetric(
              horizontal: AppConstants.DEFAULT_PADDING,
            ),
            children: [
              const VerticalSizedBox(height: 2),

              // pending sales
              if (controller.service.pendingSales.isNotEmpty) ...[
                customInputTitleText(text: 'Pending Sales'),
                const VerticalSizedBox(height: 0.7),
                ...controller.service.pendingSales.map((pending) {
                  final pendingSaleTitle = localDateTimeFormat(
                    DateTime.fromMillisecondsSinceEpoch(
                      int.parse(pending.id),
                    ).toLocal(),
                  );
                  return CustomNavItem(
                    title: pendingSaleTitle,
                    subTitle: '${pending.itemCount} item',
                    onTap: () {
                      controller.service.selectedPendingSale.value = pending;
                      Get.toNamed(Routes.SALE_INPUT);
                    },
                    trailing: DeleteIconButton(
                      onPressed: () =>
                          controller.service.removePendingSale(pending.id),
                    ),
                  );
                }),
                const VerticalSizedBox(height: 1),
              ],

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
      floatingActionButton: FloatingAddButton(
        onPressed: () => controller.addSaleItem(),
      ),
    );
  }
}
