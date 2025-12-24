import 'package:abg_pos_app/app/shared/custom_card.dart';
import 'package:abg_pos_app/app/utils/helpers/time_helper.dart';
import 'package:abg_pos_app/app/utils/theme/custom_text.dart';
import 'package:flutter/material.dart';

class CurrentDatePanel extends StatelessWidget {
  const CurrentDatePanel({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          customListHeaderText(text: 'Tanggal'),
          customLabelText(text: localDateFormat(DateTime.now())),
        ],
      ),
    );
  }
}
