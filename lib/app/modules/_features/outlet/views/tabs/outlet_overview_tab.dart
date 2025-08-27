import 'package:abg_pos_app/app/modules/_features/outlet/widgets/outlet_overview_nav_item.dart';
import 'package:abg_pos_app/app/routes/app_pages.dart';
import 'package:abg_pos_app/app/shared/custom_card.dart';
import 'package:abg_pos_app/app/shared/vertical_sized_box.dart';
import 'package:abg_pos_app/app/utils/constants/app_constants.dart';
import 'package:abg_pos_app/app/utils/constants/order_constants.dart';
import 'package:abg_pos_app/app/utils/constants/padding_constants.dart';
import 'package:abg_pos_app/app/utils/theme/custom_text.dart';
import 'package:get/get.dart';

import '../../../../../utils/helpers/get_storage_helper.dart';
import '../../controllers/outlet_detail_controller.dart';
import 'package:flutter/material.dart';

import '../../widgets/indicator_oder_done_widget.dart';

class OutletOverviewTab extends StatelessWidget {
  const OutletOverviewTab({super.key, required this.c});
  final OutletDetailController c;
  @override
  Widget build(BuildContext context) {
    final customWidth = (Get.width - AppConstants.DEFAULT_PADDING * 4) / 5;
    return Obx(() {
      final activeOrder = c.orderData.filteredOrders(
        [
          OrderConstants.ORDERED,
          OrderConstants.PROCESSED,
          OrderConstants.ON_THE_WAY,
        ],
        outletId: [box.getValue(AppConstants.KEY_CURRENT_OUTLET)],
      );

      final menuItems = [
        {
          'icon': Icons.payment,
          'label': 'Penjualan',
          'indicator': null,
          'onTap': () {
            Get.toNamed(Routes.OUTLET_SALE_LIST);
          },
        },
        {
          'icon': Icons.shopping_bag,
          'label': 'Stok',
          'indicator': null,
          'onTap': () {
            Get.toNamed(Routes.OUTLET_INVENTORY_LIST);
          },
        },
        {
          'icon': Icons.shopping_cart,
          'label': 'Pesanan',
          'indicator': activeOrder.isNotEmpty ? activeOrder.length : null,
          'onTap': () {
            Get.toNamed(Routes.OUTLET_ORDER_LIST);
          },
        },
        {
          'icon': Icons.payment,
          'label': 'Belanja',
          'indicator': null,
          'onTap': () {},
        },
        {
          'icon': Icons.access_time,
          'label': 'Presensi',
          'indicator': null,
          'onTap': () {},
        },
        {
          'icon': Icons.file_present,
          'label': 'Laporan',
          'indicator': null,
          'onTap': () {},
        },
        {
          'icon': Icons.fastfood,
          'label': 'Menu',
          'indicator': null,
          'onTap': () {},
        },
      ];
      return ListView(
        padding: horizontalPadding,
        children: [
          const VerticalSizedBox(height: 2),
          CustomCard(
            content: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: customTitleText(maxLines: 1, text: '450.000'),
                    ),
                    Expanded(
                      child: customTitleText(
                        textAlign: TextAlign.right,
                        maxLines: 1,
                        text: '12.450.000',
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    customSmallLabelText(text: 'Omzet hari ini'),
                    customSmallLabelText(text: 'Omzet bulan ini'),
                  ],
                ),
                const VerticalSizedBox(height: 0.7),
                Container(
                  alignment: Alignment.center,
                  height: 65,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IndicatorOderDoneWidget(
                        position: 'left',
                        title: 'Order Selesai',
                        number: '12',
                      ),
                      IndicatorOderDoneWidget(
                        position: 'right',
                        title: 'Item Terjual',
                        number: '12',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const VerticalSizedBox(),
          CustomCard(
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customInputTitleText(text: 'Pilihan'),
                const VerticalSizedBox(height: 0.7),
                Row(
                  children: [
                    Expanded(
                      child: GridView(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: customWidth,
                          mainAxisExtent:
                              customWidth + AppConstants.DEFAULT_PADDING,
                          mainAxisSpacing: AppConstants.DEFAULT_PADDING,
                          crossAxisSpacing: AppConstants.DEFAULT_PADDING,
                        ),
                        // physics: const NeverScrollableScrollPhysics(),
                        children: menuItems.map((item) {
                          return OutletOverviewNavItem(item: item);
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
