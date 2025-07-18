import '../../../../controllers/order_data_controller.dart';
import '../../../../data/models/Order.dart';
import '../../../../shared/custom_nav_item.dart';
import '../../../../shared/order_status.dart';
import '../../../../utils/helpers/text_helper.dart';
import '../../../../utils/theme/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';

class OrderHistoryItem extends StatelessWidget {
  const OrderHistoryItem({
    super.key,
    required this.order,
    required this.dataController,
  });

  final Order order;
  final OrderDataController dataController;

  @override
  Widget build(BuildContext context) {
    return CustomNavItem(
      onTap: () {
        dataController.selectedOrder.value = order;
        Get.toNamed(Routes.ORDER_DETAIL);
      },
      titleWidget: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(order.code),
          OrderStatus(status: order.status),
        ],
      ),
      subTitleWidget: customSmallLabelText(
        text:
            '${normalizeName(order.outlet.name)} / ${order.items.length} item / Rp 190.000',
      ),
      disableTrailing: true,
    );
  }
}
