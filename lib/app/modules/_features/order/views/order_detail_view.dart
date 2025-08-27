import 'package:abg_pos_app/app/modules/_features/order/widgets/order_item_widget.dart';
import 'package:abg_pos_app/app/shared/custom_alert.dart';
import 'package:abg_pos_app/app/utils/constants/padding_constants.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../shared/custom_card.dart';
import '../../../../shared/order_status.dart';
import '../../../../shared/vertical_sized_box.dart';
import '../../../../shared/custom_appbar_lite.dart';
import '../../../../shared/pages/failed_page_placeholder.dart';
import '../../../../utils/helpers/number_helper.dart';
import '../../../../utils/constants/string_value.dart';
import '../../../../utils/helpers/user_helper.dart';
import '../../../../utils/theme/custom_text.dart';
import '../controllers/order_detail_controller.dart';

class OrderDetailView extends GetView<OrderDetailController> {
  const OrderDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    final c = controller;
    return Obx(() {
      final order = controller.data.selectedOrder.value;
      if (order == null) return FailedPagePlaceholder();

      return Scaffold(
        appBar: customAppBarLite(
          title: order.code,
          backRoute: controller.backRoute,
          actions: [
            PopupMenuButton(
              color: Colors.white,
              icon: Icon(Icons.more_vert),
              itemBuilder: (context) => <PopupMenuEntry>[
                if (!isOperator)
                  PopupMenuItem(
                    onTap: () {
                      c.updateOrder();
                    },
                    child: Text('Ubah Status'),
                  ),
                if (!isOperator)
                  PopupMenuItem(
                    onTap: () {},
                    child: Text('Hapus', style: TextStyle(color: Colors.red)),
                  ),
                if (isOperator)
                  PopupMenuItem(
                    onTap: () {},
                    child: Text(
                      'Minta Hapus',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
              ],
            ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () => c.refreshData(),
          child: ListView(
            padding: horizontalPadding,
            children: [
              const VerticalSizedBox(height: 2),

              // order info
              CustomCard(
                content: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        customLabelText(text: StringValue.ORDER_CODE),
                        customLabelText(text: StringValue.STATUS),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        customCaptionText(text: order.code),
                        OrderStatus(status: order.status),
                      ],
                    ),
                    const VerticalSizedBox(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        customLabelText(text: StringValue.SPV_AREA),
                        customLabelText(text: StringValue.ITEM_QTY),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        customCaptionText(text: '-'),
                        customCaptionText(text: '${order.items.length} item'),
                      ],
                    ),
                    const VerticalSizedBox(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        customLabelText(text: StringValue.DESTINATION),
                        customLabelText(text: StringValue.TOTAL_PRICE),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        customCaptionText(text: order.outlet.name),
                        customCaptionText(text: inRupiah(order.totalPrice)),
                      ],
                    ),
                  ],
                ),
              ),
              const VerticalSizedBox(),

              // items
              CustomCard(
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    customLabelText(text: StringValue.ORDER_ITEM),
                    const VerticalSizedBox(),
                    ...order.items.map((item) {
                      return Column(
                        children: [
                          OrderItemWidget(
                            item: item,
                            onTap: () {
                              if (item.isAccepted) {
                                if (!isOperator) {
                                  c.unacceptOrderItem(item);
                                } else {
                                  customAlertDialog(
                                    'Operator tidak bisa membatalkan status pesanan.',
                                  );
                                }
                              } else {
                                c.acceptOrderItem(item);
                              }
                            },
                          ),
                          if (order.items.indexOf(item) !=
                              order.items.length - 1)
                            const VerticalSizedBox(),
                        ],
                      );
                    }),
                  ],
                ),
              ),
              const VerticalSizedBox(height: 10),
            ],
          ),
        ),
      );
    });
  }
}
