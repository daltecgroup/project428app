import 'package:abg_pos_app/app/utils/constants/padding_constants.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../shared/pages/empty_list_page.dart';
import '../../../../shared/pages/order_list/controllers/order_list_controller.dart';
import '../../../../shared/buttons/custom_text_button.dart';
import '../../../../shared/vertical_sized_box.dart';
import '../../../../utils/helpers/time_helper.dart';
import '../../../../utils/theme/custom_text.dart';
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

      if (controller.data.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      }

      if (activeOrders.isEmpty && groupedHistory.isEmpty) {
        return EmptyListPage(
          refresh: () => controller.data.syncData(refresh: true),
          text: 'Pesanan Kosong',
        );
      }

      return RefreshIndicator(
        onRefresh: controller.refreshData,
        child: ListView(
          padding: horizontalPadding,
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
