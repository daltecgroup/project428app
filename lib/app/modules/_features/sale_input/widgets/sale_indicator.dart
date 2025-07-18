import 'package:abg_pos_app/app/modules/_features/sale_input/controllers/sale_input_controller.dart';
import 'package:abg_pos_app/app/shared/custom_card.dart';
import 'package:abg_pos_app/app/utils/helpers/number_helper.dart';
import 'package:abg_pos_app/app/utils/theme/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SaleIndicator extends StatelessWidget {
  const SaleIndicator({super.key, required this.controller});

  final SaleInputController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      int itemCount = controller.service.selectedPendingSale.value!.itemCount;
      int itemPromo =
          controller.service.selectedPendingSale.value!.itemPromo.length;
      return CustomCard(
        padding: 12,
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  customSmallLabelText(text: 'Item'),
                  customLabelText(text: itemCount.toString()),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  customSmallLabelText(text: 'Promo'),
                  customLabelText(text: itemPromo.toString()),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  customSmallLabelText(text: 'Hemat'),
                  customLabelText(text: inRupiah(controller.totalSaving)),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  customSmallLabelText(text: 'Total'),
                  customLabelText(text: inRupiah(controller.totalPrice)),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
