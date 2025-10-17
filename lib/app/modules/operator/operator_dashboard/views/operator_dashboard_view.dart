import 'package:abg_pos_app/app/data/models/Outlet.dart';
import 'package:abg_pos_app/app/shared/pages/failed_page_placeholder.dart';
import 'package:abg_pos_app/app/shared/vertical_sized_box.dart';
import 'package:abg_pos_app/app/utils/constants/padding_constants.dart';
import 'package:abg_pos_app/app/utils/helpers/outlet_helper.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../shared/custom_appbar.dart';
import '../../../../shared/custom_card.dart';
import '../../../../shared/custom_circle_avatar_image.dart';
import '../../../../shared/custom_drawer.dart';
import '../../../../shared/status_sign.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/helpers/number_helper.dart';
import '../../../../utils/helpers/time_helper.dart';
import '../../../../utils/theme/app_colors.dart';
import '../../../../utils/theme/custom_text.dart';
import '../../../_features/outlet/widgets/indicator_oder_done_widget.dart';
import '../controllers/operator_dashboard_controller.dart';

class OperatorDashboardView extends GetView<OperatorDashboardController> {
  const OperatorDashboardView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final currentOutlet = controller.outletData.currentOutlet;
      if (currentOutlet == null) return FailedPagePlaceholder();
      final report = controller.reportData.currentReport.value;

      return Scaffold(
        appBar: customAppBar(currentOutletName ?? '-'),
        drawer: customDrawer(),
        body: RefreshIndicator(
          onRefresh: () => controller.refreshData(),
          child: ListView(
            padding: horizontalPadding,
            children: [
              _currentDateInfo(currentOutlet),
              const VerticalSizedBox(),
              CustomCard(
                content: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: customTitleText(
                            maxLines: 1,
                            text: report == null
                                ? 'Rp 0'
                                : inRupiah(report.totalSale),
                          ),
                        ),
                        Expanded(
                          child: customTitleText(
                            textAlign: TextAlign.right,
                            maxLines: 1,
                            text: 'Rp 0',
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        customSmallLabelText(text: 'Omzet hari ini'),
                        customSmallLabelText(text: 'Omzet bulan ini'),
                      ],
                    ),

                    const VerticalSizedBox(height: 0.7),
                    Container(
                      alignment: Alignment.center,
                      height: 65,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IndicatorOderDoneWidget(
                            position: 'left',
                            title: 'Order Selesai',
                            number: report == null
                                ? '0'
                                : inLocalNumber(report.saleComplete),
                          ),
                          IndicatorOderDoneWidget(
                            position: 'center',
                            title: 'Single Terjual',
                            number: report == null
                                ? '0'
                                : report.singleItemSold.toString(),
                          ),
                          IndicatorOderDoneWidget(
                            position: 'right',
                            title: 'Paket Terjual',
                            number: report == null
                                ? '0'
                                : report.bundleItemSold.toString(),
                          ),
                        ],
                      ),
                    ),
                    if (controller.currentUser != null) ...[
                      const VerticalSizedBox(),
                      Material(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 1,
                        child: ListTile(
                          selected: true,
                          selectedTileColor: AppColors.surface,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          leading: CustomCircleAvatarImage(),
                          title: Text(
                            controller.currentUser!.name,
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          subtitle: Text(
                            'ID ${controller.currentUser!.userId}',
                            style: TextStyle(fontSize: 14),
                          ),
                          trailing: IconButton(
                            onPressed: () => controller.auth.logout(),
                            icon: Icon(Icons.logout_rounded),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const VerticalSizedBox(),
            ],
          ),
        ),
      );
    });
  }

  CustomCard _currentDateInfo(Outlet currentOutlet) {
    return CustomCard(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          customLabelText(text: localDayDateFormat(DateTime.now())),
          StatusSign(
            status: currentOutlet.isActive,
            size: AppConstants.DEFAULT_FONT_SIZE.round(),
          ),
        ],
      ),
    );
  }
}
