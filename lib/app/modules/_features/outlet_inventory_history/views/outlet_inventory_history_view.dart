import 'package:abg_pos_app/app/shared/custom_alert.dart';
import 'package:abg_pos_app/app/shared/custom_nav_item.dart';
import 'package:abg_pos_app/app/shared/horizontal_sized_box.dart';
import 'package:abg_pos_app/app/shared/vertical_sized_box.dart';
import 'package:abg_pos_app/app/utils/constants/app_constants.dart';
import 'package:abg_pos_app/app/utils/constants/padding_constants.dart';
import 'package:abg_pos_app/app/utils/helpers/number_helper.dart';
import 'package:abg_pos_app/app/utils/helpers/outlet_helper.dart';
import 'package:abg_pos_app/app/utils/helpers/text_helper.dart';
import 'package:abg_pos_app/app/utils/helpers/time_helper.dart';
import 'package:abg_pos_app/app/utils/theme/custom_text.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../shared/custom_appbar_lite.dart';
import '../controllers/outlet_inventory_history_controller.dart';

class OutletInventoryHistoryView
    extends GetView<OutletInventoryHistoryController> {
  const OutletInventoryHistoryView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarLite(
        title: 'Riwayat Adjustment',
        subtitle: currentOutletName,
      ),
      body: Obx(() {
        final groupedOits = controller.data.groupedOit;
        return RefreshIndicator(
          onRefresh: () => controller.data.syncData(
            refresh: true,
            transactionType: AppConstants.TRXTYPE_ADJUSTMENT,
          ),
          child: ListView(
            padding: horizontalPadding,
            children: [
              const VerticalSizedBox(height: 2),
              ...groupedOits.entries.map((oit) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    customListHeaderText(
                      text: normalizeName(
                        contextualLocalDateFormat(DateTime.parse(oit.key)),
                      ),
                    ),
                    const VerticalSizedBox(height: 0.7),
                    ...oit.value.map((sub) {
                      return CustomNavItem(
                        titleWidget: Row(
                          children: [
                            Text(normalizeName(sub.ingredient.name)),
                            if (sub.notes != null && sub.notes != '') ...[
                              const HorizontalSizedBox(width: 0.7),
                              Icon(
                                Icons.notes,
                                size: AppConstants.DEFAULT_FONT_SIZE,
                              ),
                            ],
                          ],
                        ),
                        subTitle: localTimeFormat(sub.createdAt),
                        trailing: AdjustmentHistoryQtyChange(qty: sub.qty),
                        onTap: () {
                          customAlertDialogWithTitle(
                            title: 'Rincian',
                            content: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        customInputTitleText(
                                          text: 'Bahan Baku',
                                        ),
                                        customCaptionText(
                                          text: normalizeName(
                                            sub.ingredient.name,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        customInputTitleText(
                                          text: 'Adjustment',
                                        ),
                                        AdjustmentHistoryQtyChange(
                                          qty: sub.qty,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const VerticalSizedBox(height: 0.7),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        customInputTitleText(text: 'Dibuat'),
                                        customCaptionText(
                                          text: normalizeName(
                                            localDateTimeFormat(sub.createdAt),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const VerticalSizedBox(height: 0.7),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        customInputTitleText(text: 'Pembuat'),
                                        customCaptionText(
                                          text: normalizeName(
                                            sub.createdBy.name,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const VerticalSizedBox(height: 0.7),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        customInputTitleText(text: 'Catatan'),
                                        customCaptionText(
                                          text:
                                              sub.notes == null ||
                                                  sub.notes == ''
                                              ? '-'
                                              : GetUtils.capitalizeFirst(
                                                  sub.notes!,
                                                )!,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }),
                    const VerticalSizedBox(),
                  ],
                );
              }),
            ],
          ),
        );
      }),
    );
  }
}

class AdjustmentHistoryQtyChange extends StatelessWidget {
  const AdjustmentHistoryQtyChange({super.key, required this.qty});

  final double qty;

  @override
  Widget build(BuildContext context) {
    String indicator = '+';
    Color badgeColor = Colors.lightBlue;

    if (qty.isNegative) {
      indicator = '';
      badgeColor = Colors.redAccent.shade200;
    }
    return Badge(
      padding: EdgeInsets.all(6),
      backgroundColor: Colors.transparent,
      label: Text(
        '$indicator${inLocalNumber(qty)} g',
        style: TextStyle(
          fontSize: AppConstants.DEFAULT_FONT_SIZE - 2,
          fontWeight: FontWeight.w700,
          color: badgeColor,
        ),
      ),
    );
  }
}
