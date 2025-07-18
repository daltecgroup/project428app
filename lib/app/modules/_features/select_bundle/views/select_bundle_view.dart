import 'package:abg_pos_app/app/modules/_features/select_bundle/widgets/select_bundle_item.dart';
import 'package:abg_pos_app/app/shared/custom_appbar_lite.dart';
import 'package:abg_pos_app/app/shared/vertical_sized_box.dart';
import 'package:abg_pos_app/app/utils/constants/app_constants.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../shared/custom_card.dart';
import '../../../../utils/theme/custom_text.dart';
import '../controllers/select_bundle_controller.dart';

class SelectBundleView extends GetView<SelectBundleController> {
  const SelectBundleView({super.key});
  @override
  Widget build(BuildContext context) {
    final customWidth = (Get.width - AppConstants.DEFAULT_PADDING * 2) / 4;
    return Scaffold(
      appBar: customAppBarLite(title: 'Pilih Paket', result: null),
      body: Obx(() {
        return Column(
          children: [
            // online bundle switch
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.DEFAULT_PADDING,
              ),
              child: CustomCard(
                padding: 8,
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: AppConstants.DEFAULT_PADDING / 2,
                      ),
                      child: customLabelText(text: 'Menu Online'),
                    ),
                    SizedBox(
                      height: 40,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Switch(
                          value: controller.showOnline.value,
                          onChanged: (value) =>
                              controller.showOnline.value = value,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // bundle list
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(
                  horizontal: AppConstants.DEFAULT_PADDING,
                ),
                children: [
                  const VerticalSizedBox(height: 2),

                  // bundle list
                  if (controller.getBundles.isNotEmpty) ...[
                    customListHeaderText(text: 'Paket'),
                    const VerticalSizedBox(),
                    _buildGrid(
                      items: controller.getBundles
                          .map(
                            (bundle) => SelectBundleItem(
                              controller: controller,
                              customWidth: customWidth,
                              bundle: bundle,
                            ),
                          )
                          .toList(),
                      customWidth: customWidth,
                    ),
                    const VerticalSizedBox(height: 2),
                  ],
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildGrid({
    required List<Widget> items,
    required double customWidth,
  }) {
    return GridView(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: customWidth,
        mainAxisExtent: customWidth + AppConstants.DEFAULT_PADDING * 2,
        mainAxisSpacing: AppConstants.DEFAULT_PADDING,
        crossAxisSpacing: AppConstants.DEFAULT_PADDING,
      ),
      children: items,
    );
  }
}
