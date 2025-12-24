import 'package:abg_pos_app/app/data/models/DashboardResponse.dart';
import 'package:abg_pos_app/app/shared/custom_card.dart';
import 'package:abg_pos_app/app/shared/horizontal_sized_box.dart';
import 'package:abg_pos_app/app/utils/theme/custom_text.dart';
import 'package:flutter/material.dart';

class OperationsPanel extends StatelessWidget {
  const OperationsPanel({super.key, required this.thisMonthOperations});

  final Operations thisMonthOperations;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomCard(
            content: Column(
              children: [
                customTitleText(
                  maxLines: 1,
                  text: thisMonthOperations.totalOutletsMaster.toString(),
                ),
                customSmallLabelText(text: 'Gerai'),
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
                  text: thisMonthOperations.totalOperatorsMaster.toString(),
                ),
                customSmallLabelText(text: 'Operator'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
