import 'package:abg_pos_app/app/data/models/DashboardResponse.dart';
import 'package:abg_pos_app/app/shared/custom_card.dart';
import 'package:abg_pos_app/app/shared/horizontal_sized_box.dart';
import 'package:abg_pos_app/app/shared/vertical_sized_box.dart';
import 'package:abg_pos_app/app/utils/helpers/number_helper.dart';
import 'package:abg_pos_app/app/utils/theme/custom_text.dart';
import 'package:flutter/material.dart';

class RevenuePanel extends StatelessWidget {
  const RevenuePanel({
    super.key,
    required this.todayFinancials,
    required this.thisMonthFinancials,
  });

  final Financials todayFinancials;
  final Financials thisMonthFinancials;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customListHeaderText(text: 'Pemasukan'),
          const VerticalSizedBox(height: 0.7),
          Row(
            children: [
              Expanded(
                child: CustomCard(
                  content: Column(
                    children: [
                      customTitleText(
                        maxLines: 1,
                        text: inLocalNumber(todayFinancials.revenue.toDouble()),
                      ),
                      customSmallLabelText(text: 'Hari Ini'),
                    ],
                  ),
                ),
              ),
              const HorizontalSizedBox(),
              Expanded(
                child: CustomCard(
                  content: Column(
                    children: [
                      customTitleText(
                        maxLines: 1,
                        text: inLocalNumber(
                          thisMonthFinancials.revenue.toDouble(),
                        ),
                      ),
                      customSmallLabelText(text: 'Bulan Ini'),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const VerticalSizedBox(),
          Row(
            children: [
              Expanded(
                child: CustomCard(
                  content: Column(
                    children: [
                      customTitleText(
                        maxLines: 1,
                        text: inLocalNumber(
                          thisMonthFinancials.netProfit.toDouble(),
                        ),
                      ),
                      customSmallLabelText(text: 'Net Profit (Bulanan)'),
                    ],
                  ),
                ),
              ),
              const HorizontalSizedBox(),
              Expanded(
                child: CustomCard(
                  content: Column(
                    children: [
                      customTitleText(
                        maxLines: 1,
                        text: thisMonthFinancials.margin,
                      ),
                      customSmallLabelText(text: 'Margin (Bulanan)'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
