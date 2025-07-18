import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../shared/buttons/delete_icon_button.dart';
import '../../../../shared/buttons/floating_add_button.dart';
import '../../../../shared/custom_nav_item.dart';
import '../../../../shared/vertical_sized_box.dart';
import '../../../../shared/custom_appbar.dart';
import '../../../../shared/custom_drawer.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/helpers/time_helper.dart';
import '../../../../utils/theme/custom_text.dart';
import '../../../../routes/app_pages.dart';
import '../controllers/operator_sale_controller.dart';

class OperatorSaleView extends GetView<OperatorSaleController> {
  const OperatorSaleView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('Penjualan'),
      drawer: customDrawer(context),
      body: Obx(() {
        return ListView(
          padding: EdgeInsets.symmetric(
            horizontal: AppConstants.DEFAULT_PADDING,
          ),
          children: [
            const VerticalSizedBox(height: 2),
            if (controller.service.pendingSales.isNotEmpty) ...[
              customListHeaderText(text: 'Pending Sales'),
              const VerticalSizedBox(height: 0.7),
              ...controller.service.pendingSales.map((pending) {
                final pendingSaleTitle = localDateTimeFormat(
                  DateTime.fromMillisecondsSinceEpoch(
                    int.parse(pending.id),
                  ).toLocal(),
                );
                return CustomNavItem(
                  title: pendingSaleTitle,
                  subTitle: '${pending.itemCount} item',
                  onTap: () {
                    controller.service.selectedPendingSale.value = pending;
                    Get.toNamed(Routes.SALE_INPUT);
                  },
                  trailing: DeleteIconButton(
                    onPressed: () =>
                        controller.service.removePendingSale(pending.id),
                  ),
                );
              }),
            ],
          ],
        );
      }),
      floatingActionButton: FloatingAddButton(
        onPressed: () => controller.addSaleItem(),
      ),
    );
  }
}
