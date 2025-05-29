import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project428app/app/services/order_service.dart';
import 'package:project428app/app/widgets/confirmation_dialog.dart';
import 'package:project428app/app/widgets/get_unit_title.dart';

import '../../models/order.dart';

class OrderDetailItemWidget extends StatelessWidget {
  const OrderDetailItemWidget({
    super.key,
    required this.order,
    required this.index,
  });

  final Order order;
  final int index;

  @override
  Widget build(BuildContext context) {
    Color? color = order.items[index].accepted ? Colors.green[700]! : null;
    OrderService OrderS = Get.find<OrderService>();
    return Card(
      margin: EdgeInsets.all(0),
      color: Colors.grey[50],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Container(
        width: double.infinity,
        child: InkWell(
          onTap:
              () => ConfirmationDialog(
                'Konfirmasi',
                'Yakin jumlah yang tertera sudah sesuai?',
                () async {
                  if (order.items[index].accepted == false) {
                    await order.changeItemStatus(index, true).then((success) {
                      if (success) {
                        OrderS.getOrders();
                      }
                    });
                  } else {
                    await order.changeItemStatus(index, false).then((success) {
                      if (success) {
                        OrderS.getOrders();
                      }
                    });
                  }
                  OrderS.currentOrder.refresh();
                  OrderS.orders.refresh();
                  Get.back();
                },
              ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Row(
                        children: [
                          Text(
                            order.items[index].name,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: color,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          if (order.items[index].accepted)
                            Row(
                              children: [
                                SizedBox(width: 5),
                                Icon(
                                  Icons.check_circle,
                                  color: color,
                                  size: 18,
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),

                    Expanded(
                      flex: 2,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            '${order.items[index].qty} ${getUnitTitle(order.items[index].stock.unit, true)}',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: color,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Harga',
                              style: TextStyle(fontSize: 10, color: color),
                            ),
                            Text(
                              order.items[index].getPriceInIDR(),
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: color,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Expanded(
                      flex: 3,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Total',
                              style: TextStyle(fontSize: 10, color: color),
                            ),
                            Text(
                              order.items[index].getTotalInIDR(),
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: color,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
