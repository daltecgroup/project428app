import 'package:abg_pos_app/app/shared/pages/order_list/controllers/order_list_controller.dart';
import 'package:abg_pos_app/app/shared/buttons/custom_text_button.dart';
import 'package:abg_pos_app/app/shared/vertical_sized_box.dart';
import 'package:abg_pos_app/app/utils/constants/app_constants.dart';
import 'package:abg_pos_app/app/utils/helpers/time_helper.dart';
import 'package:abg_pos_app/app/utils/theme/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/active_order_item.dart';
import '../widgets/order_history_item.dart';

class OrderList extends StatelessWidget {
  const OrderList({super.key, required this.controller});

  final OrderListController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final activeOrders = controller.activeOrder();
      final groupedHistory = controller.groupedOrders();

      return RefreshIndicator(
        onRefresh: controller.refreshData,
        child: ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.DEFAULT_PADDING,
          ),
          children: [
            if (activeOrders.isNotEmpty)
              _buildSection(
                title: 'Pesanan Aktif',
                isOpen: controller.openActive.value,
                onToggle: controller.openActive.toggle,
                children: activeOrders.map(
                  (e) => ActiveOrderItem(
                    order: e,
                    dataController: controller.data,
                  ),
                ),
              ),
            if (groupedHistory.isNotEmpty)
              _buildSection(
                title: 'Riwayat Pesanan',
                isOpen: controller.openHistory.value,
                onToggle: controller.openHistory.toggle,
                children: groupedHistory.entries.expand(
                  (entry) => [
                    Text(
                      contextualLocalDateFormat(
                        DateTime.parse(entry.key),
                      ).capitalize!,
                    ),
                    const VerticalSizedBox(height: 0.7),
                    ...entry.value.map(
                      (e) => OrderHistoryItem(
                        order: e,
                        dataController: controller.data,
                      ),
                    ),
                  ],
                ),
              ),
            const VerticalSizedBox(height: 10),
          ],
        ),
      );
    });
  }

  Widget _buildSection({
    required String title,
    required bool isOpen,
    required VoidCallback onToggle,
    required Iterable<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            customInputTitleText(text: title),
            CustomTextButton(
              title: isOpen ? 'Tutup' : 'Buka',
              onPressed: onToggle,
            ),
          ],
        ),
        if (isOpen) ...[...children, const VerticalSizedBox()],
      ],
    );
  }
}
