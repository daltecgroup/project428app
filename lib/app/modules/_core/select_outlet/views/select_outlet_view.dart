import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import '../../../../shared/custom_appbar_lite.dart';
import '../../../../data/models/Outlet.dart';
import '../../../../shared/custom_nav_item.dart';
import '../../../../shared/vertical_sized_box.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/theme/custom_text.dart';
import '../controllers/select_outlet_controller.dart';

class SelectOutletView extends GetView<SelectOutletController> {
  const SelectOutletView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarLite(title: 'Pilih Gerai'),
      body: RefreshIndicator(
        onRefresh: controller.refreshData,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.DEFAULT_PADDING,
          ),
          child: Column(
            children: [
              const VerticalSizedBox(height: 2),
              Expanded(
                child: Obx(() {
                  final groupedOutlet = controller.groupOutletByRegency(
                    controller.keyword.value,
                  );
                  if (groupedOutlet.isEmpty) {
                    return _buildEmptyState();
                  }
                  return _buildGroupedOutletList(groupedOutlet);
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGroupedOutletList(Map<String, List<Outlet>> grouped) {
    final svg = Svg(AppConstants.IMG_PLACEHOLDER);
    return ListView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      children: [
        ...grouped.entries.expand(
          (entry) => [
            customListHeaderText(text: entry.key),
            const VerticalSizedBox(height: 0.7),
            ...entry.value.map(
              (outlet) => CustomNavItem(
                title: outlet.name,
                subTitleWidget: customSmallLabelText(
                  text: outlet.address.street,
                ),
                image: svg,
                onTap: () {
                  // on tap
                  Get.back(result: outlet);
                },
              ),
            ),
          ],
        ),
        const VerticalSizedBox(height: 10),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          customListTitleText(text: 'Outlet Kosong'),
          TextButton(
            onPressed: controller.refreshData,
            child: const Text('Muat Ulang'),
          ),
        ],
      ),
    );
  }
}
