import 'package:abg_pos_app/app/utils/helpers/get_storage_helper.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import '../../../../shared/horizontal_sized_box.dart';
import '../../../../data/models/Outlet.dart';
import '../../../../routes/app_pages.dart';
import '../../../../shared/custom_input_with_error.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../shared/custom_nav_item.dart';
import '../../../../shared/status_sign.dart';
import '../../../../shared/vertical_sized_box.dart';
import '../../../../shared/buttons/floating_add_button.dart';
import '../../../../shared/custom_appbar.dart';
import '../../../../shared/custom_drawer.dart';
import '../../../../utils/constants/string_value.dart';
import '../../../../utils/helpers/time_helper.dart';
import '../../../../utils/theme/custom_text.dart';
import '../controllers/outlet_list_controller.dart';

class OutletListView extends GetView<OutletListController> {
  const OutletListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('Gerai'),
      drawer: customDrawer(context),
      body: RefreshIndicator(
        onRefresh: controller.refreshData,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.DEFAULT_PADDING,
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: CustomInputWithError(
                      controller: controller.searchC,
                      hint: StringValue.SEARCH_OUTLET,
                      prefixIcon: Icon(
                        Icons.search,
                        size: AppConstants.DEFAULT_ICON_SIZE,
                      ),
                      onChanged: (value) => controller.keyword.value = value,
                    ),
                  ),
                  const HorizontalSizedBox(width: 0.7),
                  SizedBox(
                    child: IconButton(
                      onPressed: () {
                        controller.changeGroupedBy();
                      },
                      icon: Icon(Icons.sort_rounded),
                    ),
                  ),
                ],
              ),
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
      floatingActionButton: FloatingAddButton(
        tooltip: 'Tambah Gerai',
        onPressed: () => Get.toNamed(Routes.OUTLET_INPUT),
      ),
    );
  }

  Widget _buildGroupedOutletList(Map<String, List<Outlet>> grouped) {
    final svg = Svg(AppConstants.IMG_PLACEHOLDER);
    final BoxHelper box = BoxHelper();
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
                subTitle: outlet.address.street,
                image: svg,
                trailing: StatusSign(
                  status: outlet.isActive,
                  size: AppConstants.DEFAULT_FONT_SIZE.round(),
                ),
                onTap: () {
                  Get.find<OutletListController>().data.selectedOutlet.value =
                      outlet;
                  box.setValue(AppConstants.KEY_CURRENT_OUTLET, outlet.id);
                  Get.toNamed(Routes.OUTLET_DETAIL);
                },
              ),
            ),
          ],
        ),
        const VerticalSizedBox(),
        if (Get.find<OutletListController>().data.latestSync.value != null)
          customFooterText(
            textAlign: TextAlign.center,
            text:
                'Diperbarui ${contextualLocalDateTimeFormat(Get.find<OutletListController>().data.latestSync.value!)}',
          ),
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
            onPressed: Get.find<OutletListController>().refreshData,
            child: const Text('Muat Ulang'),
          ),
        ],
      ),
    );
  }
}
