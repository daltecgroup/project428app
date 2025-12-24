import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../shared/custom_appbar.dart';
import '../../../../shared/custom_drawer.dart';
import '../../../../shared/vertical_sized_box.dart';
import '../../../../shared/custom_circle_avatar_image.dart';
import '../../../../utils/constants/padding_constants.dart';
import '../../../../utils/theme/app_colors.dart';
import '../controllers/admin_dashboard_controller.dart';
import '../widgets/current_date_panel.dart';
import '../widgets/inventory_alert_panel.dart';
import '../widgets/operations_panel.dart';
import '../widgets/revenue_panel.dart';
import '../widgets/top_products_panel.dart';
part '../widgets/user_indicator.dart';

class AdminDashboardView extends GetView<AdminDashboardController> {
  const AdminDashboardView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('Admin'),
      drawer: customDrawer(),
      body: RefreshIndicator(
        onRefresh: controller.refreshData,
        child: Obx(() {
          final data = controller.data.data.value;
          if (data == null) {
            return const Center(child: CircularProgressIndicator());
          }

          final topProducts = data.thisMonth.topProducts
            ..sort((a, b) => b.revenueContribution.compareTo(a.revenueContribution));

          return ListView(
            padding: horizontalPadding,
            children: [
              if (controller.currentUser != null)
                UserIndicator(controller: controller),
              const VerticalSizedBox(height: 0.7),
              CurrentDatePanel(),
              const VerticalSizedBox(),
              OperationsPanel(thisMonthOperations: data.thisMonth.operations),
              const VerticalSizedBox(),
              RevenuePanel(
                todayFinancials: data.today.financials,
                thisMonthFinancials: data.thisMonth.financials,
              ),
              if (topProducts.isNotEmpty) ...[
                const VerticalSizedBox(),
                TopProductsPanel(thisMonthTopProducts: topProducts),
              ],
              if (data.inventoryAlerts.isNotEmpty) ...[
                const VerticalSizedBox(),
                InventoryAlertPanel(inventoryAlerts: data.inventoryAlerts),
              ],
              const VerticalSizedBox(height: 10),
            ],
          );
        }),
      ),
    );
  }
}
