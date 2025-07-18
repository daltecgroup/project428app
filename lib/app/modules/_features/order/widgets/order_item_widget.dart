import '../../../../data/models/OrderItem.dart';
import '../../../../shared/custom_card.dart';
import '../../../../shared/order_item_status.dart';
import '../../../../shared/vertical_sized_box.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/helpers/number_helper.dart';
import '../../../../utils/helpers/text_helper.dart';
import '../../../../utils/theme/custom_text.dart';
import 'package:flutter/material.dart';

class OrderItemWidget extends StatelessWidget {
  const OrderItemWidget({
    super.key,
    required this.item,
    required this.onTap,
    this.showStatus,
  });
  final OrderItem item;
  final VoidCallback onTap;
  final bool? showStatus;

  @override
  Widget build(BuildContext context) {
    bool show = showStatus ?? true;
    return Stack(
      children: [
        CustomCard(
          padding: 10,
          content: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: customCaptionText(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      text: normalizeName(item.name),
                    ),
                  ),
                  if (show)
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: OrderItemStatus(isAccepted: item.isAccepted),
                      ),
                    ),
                ],
              ),
              const VerticalSizedBox(height: 0.5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  customSmallLabelText(text: 'Jumlah x Harga Satuan'),
                  customSmallLabelText(text: 'Subtotal'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  customInputTitleText(
                    text:
                        '${inLocalNumber(item.qty / 1000)}Kg x ${inRupiah(item.price * 1000)}',
                  ),
                  customInputTitleText(text: inRupiah(item.price * item.qty)),
                ],
              ),
            ],
          ),
        ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(
                AppConstants.DEFAULT_BORDER_RADIUS,
              ),
              onTap: onTap,
            ),
          ),
        ),
      ],
    );
  }
}
