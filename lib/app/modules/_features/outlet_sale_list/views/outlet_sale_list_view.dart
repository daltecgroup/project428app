import 'package:abg_pos_app/app/shared/buttons/custom_small_text_button.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../utils/constants/padding_constants.dart';
import '../../../../utils/helpers/text_helper.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/helpers/get_storage_helper.dart';
import '../../../../utils/helpers/number_helper.dart';
import '../../../../utils/helpers/time_helper.dart';
import '../../../../utils/theme/custom_text.dart';
import '../../../../shared/custom_appbar_lite.dart';
import '../../../../shared/custom_card.dart';
import '../../../../shared/pages/failed_page_placeholder.dart';
import '../../../../shared/custom_nav_item.dart';
import '../../../../shared/vertical_sized_box.dart';
import '../../../../routes/app_pages.dart';
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
          title: 'Riwayat Penjualan',
          subtitle: normalizeName(outlet.name),
          backRoute: controller.backRoute,
          actions: controller.actionButtons,
        ),
        body: Obx(() {
          String? currentOutlet = box.getValue(AppConstants.KEY_CURRENT_OUTLET);

          return RefreshIndicator(
            onRefresh: () => controller.data.syncData(refresh: true),
            child: Column(
              children: [
                Padding(
                  padding: horizontalPadding,
                  child: Column(
                    children: [
                      const VerticalSizedBox(),
                      if (controller.isLoading.isTrue)
                        Center(child: LinearProgressIndicator()),
                      GestureDetector(
                        onTap: () => controller.setDateRange(context),
                        child: CustomCard(
                          customPadding: EdgeInsets.symmetric(
                            vertical: AppConstants.DEFAULT_PADDING - 6,
                            horizontal: AppConstants.DEFAULT_PADDING,
                          ),
                          content: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    customSmallLabelText(text: 'Dari'),
                                    Text(
                                      normalizeName(
                                        contextualLocalDateFormat(
                                          controller.startDate.value,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    customSmallLabelText(text: 'Sampai'),
                                    Text(
                                      normalizeName(
                                        contextualLocalDateFormat(
                                          controller.endDate.value,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (controller.startDate.value.day !=
                          controller.endDate.value.day) ...[
                        const VerticalSizedBox(height: 1.2),
                        CustomAlertBar(
                          text:
                              'Menampilkan hasil selama ${daysBetween(controller.startDate.value, controller.endDate.value) + 1} hari',
                          buttonText: 'Reset',
                          callBack: () => controller.resetDateRange(),
                        ),
                        const VerticalSizedBox(height: 0.7),
                      ],
                    ],
                  ),
                ),
                if (controller.startDate.value.day ==
                    controller.endDate.value.day)
                  const VerticalSizedBox(height: 2),
                Expanded(
                  child: ListView(
                    padding: horizontalPadding,
                    children: [
                      // sale history
                      if (controller.data
                              .groupedSales(outletId: currentOutlet)
                              .isNotEmpty &&
                          controller.isLoading.isFalse) ...[
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
                ),
              ],
            ),
          );
        }),
      );
    });
  }
}

class CustomAlertBar extends StatelessWidget {
  const CustomAlertBar({
    super.key,
    required this.text,
    this.buttonText,
    this.callBack,
  });

  final String text;
  final String? buttonText;
  final VoidCallback? callBack;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: AppConstants.DEFAULT_PADDING),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(AppConstants.DEFAULT_BORDER_RADIUS),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(text, overflow: TextOverflow.ellipsis, maxLines: 1),
          ),
          CustomSmallTextButton(
            title: buttonText ?? 'Action',
            onPressed: callBack ?? () {},
          ),
        ],
      ),
    );
  }
}
