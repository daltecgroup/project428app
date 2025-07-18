import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../controllers/order_data_controller.dart';
import '../../../../data/models/Order.dart';
import '../../../../shared/custom_card.dart';
import '../../../../shared/order_status.dart';
import '../../../../shared/vertical_sized_box.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/helpers/number_helper.dart';
import '../../../../utils/helpers/time_helper.dart';
import '../../../../utils/theme/custom_text.dart';
import '../../../../utils/theme/text_style.dart';
import '../../../../routes/app_pages.dart';

class ActiveOrderItem extends StatelessWidget {
  const ActiveOrderItem({
    super.key,
    required this.order,
    required this.dataController,
  });

  final Order order;
  final OrderDataController dataController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            CustomCard(
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          order.code,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyle.bodyText,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: OrderStatus(status: order.status),
                        ),
                      ),
                    ],
                  ),
                  VerticalSizedBox(),
                  customSmallLabelText(
                    text:
                        '${localTimeFormat(order.createdAt)}, ${localDateFormat(order.createdAt)}',
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${order.outlet.name} / ${order.items.length} ${order.items.length.isGreaterThan(1) ? 'items' : 'item'}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyle.inputLabel,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              inRupiah(order.totalPrice),
                              style: AppTextStyle.inputLabel,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.all(
                    Radius.circular(AppConstants.DEFAULT_BORDER_RADIUS),
                  ),
                  onTap: () {
                    dataController.selectedOrder.value = order;
                    Get.toNamed(Routes.ORDER_DETAIL);
                  },
                ),
              ),
            ),
          ],
        ),
        const VerticalSizedBox(),
      ],
    );
  }
}
