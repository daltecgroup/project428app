import 'package:abg_pos_app/app/data/models/DashboardResponse.dart';
import 'package:abg_pos_app/app/modules/admin/admin_dashboard/views/admin_dashboard_view.dart';
import 'package:abg_pos_app/app/modules/admin/admin_dashboard/widgets/type_title.dart';
import 'package:abg_pos_app/app/shared/custom_card.dart';
import 'package:abg_pos_app/app/shared/vertical_sized_box.dart';
import 'package:abg_pos_app/app/utils/helpers/number_helper.dart';
import 'package:abg_pos_app/app/utils/helpers/text_helper.dart';
import 'package:abg_pos_app/app/utils/theme/custom_text.dart';
import 'package:flutter/material.dart';

class TopProductsPanel extends StatelessWidget {
  const TopProductsPanel({super.key, required this.thisMonthTopProducts});
  final List<TopProduct> thisMonthTopProducts;
  @override
  Widget build(BuildContext context) {
    return CustomCard(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              customListHeaderText(text: 'Produk Teratas'),
              customLabelText(text: 'Bulan Ini'),
            ],
          ),
          const VerticalSizedBox(height: 0.7),
          Row(
            children: [
              Expanded(
                child: CustomCard(
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customTitleText(
                        maxLines: 1,
                        text: normalizeName(thisMonthTopProducts.first.name),
                      ),
                      const VerticalSizedBox(height: 0.5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                customSmallLabelText(text: 'Jenis'),
                                TypeTitle(
                                  type: thisMonthTopProducts.first.type,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                customSmallLabelText(text: 'Terjual'),
                                customLabelText(
                                  text: thisMonthTopProducts.first.qtySold
                                      .toString(),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 6,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                customSmallLabelText(text: 'Total Pendapatan'),
                                customLabelText(
                                  text: inRupiah(
                                    thisMonthTopProducts
                                        .first
                                        .revenueContribution
                                        .toDouble(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          if (thisMonthTopProducts.length > 1) ...[
            const VerticalSizedBox(),
            Row(
              children: [
                Expanded(
                  child: CustomCard(
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        customTitleText(
                          maxLines: 1,
                          text: normalizeName(thisMonthTopProducts[1].name),
                        ),
                        const VerticalSizedBox(height: 0.5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  customSmallLabelText(text: 'Jenis'),
                                  TypeTitle(type: thisMonthTopProducts[1].type),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  customSmallLabelText(text: 'Terjual'),
                                  customLabelText(
                                    text: thisMonthTopProducts[1].qtySold
                                        .toString(),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 6,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  customSmallLabelText(
                                    text: 'Total Pendapatan',
                                  ),
                                  customLabelText(
                                    text: inRupiah(
                                      thisMonthTopProducts[1]
                                          .revenueContribution
                                          .toDouble(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
