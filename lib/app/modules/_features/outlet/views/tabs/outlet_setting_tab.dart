import 'package:abg_pos_app/app/utils/constants/padding_constants.dart';

import '../../controllers/outlet_detail_controller.dart';
import '../../widgets/outlet_detail_info_panel.dart';
import '../../../../../shared/buttons/custom_text_button.dart';
import '../../../../../shared/buttons/delete_icon_button.dart';
import '../../../../../shared/custom_card.dart';
import '../../../../../shared/custom_nav_item.dart';
import '../../../../../shared/pages/failed_page_placeholder.dart';
import '../../../../../shared/panels/detail_image_panel.dart';
import '../../../../../shared/vertical_sized_box.dart';
import '../../../../../utils/constants/app_constants.dart';
import '../../../../../utils/constants/string_value.dart';
import '../../../../../utils/helpers/time_helper.dart';
import '../../../../../utils/theme/custom_text.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';

class OutletSettingTab extends StatelessWidget {
  const OutletSettingTab({super.key, required this.c});

  final OutletDetailController c;

  @override
  Widget build(BuildContext context) {
    final svg = Svg(AppConstants.PROFILE_PLACEHOLDER);
    return Obx(() {
      final outlet = c.data.selectedOutlet.value;
      if (outlet == null) return FailedPagePlaceholder();
      final franchisees = c.userData.getUsersByList(outlet.franchisees);
      final spvAreas = c.userData.getUsersByList(outlet.spvAreas);
      final operators = c.userData.getUsersByList(outlet.operators);
      final latestSync = c.data.latestSync.value;
      return RefreshIndicator(
        onRefresh: () => c.refreshData(),
        child: ListView(
          padding: horizontalPadding,
          children: [
            const VerticalSizedBox(height: 2),

            // image panel
            DetailImagePanel(),

            // outlet info
            OutletDetailInfoPanel(outlet: outlet, controller: c.data),

            // franchisee panel
            const VerticalSizedBox(height: 2),
            CustomCard(
              content: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      customLabelText(text: StringValue.FRANCHISEE),
                      CustomTextButton(
                        title: 'Tambah',
                        onPressed: () {
                          c.linkUserToOutletRole(AppConstants.ROLE_FRANCHISEE);
                        },
                      ),
                    ],
                  ),
                  ...franchisees
                      .mapIndexed(
                        (index, user) => [
                          CustomNavItem(
                            image: svg,
                            isProfileImage: true,
                            title: user.name,
                            trailing: DeleteIconButton(
                              onPressed: () {
                                c.deleteUserFromOutlet(
                                  AppConstants.ROLE_FRANCHISEE,
                                  user.id,
                                  user.name,
                                );
                              },
                            ),
                            marginBottom: false,
                          ),
                          if (index < franchisees.length - 1)
                            VerticalSizedBox(),
                        ],
                      )
                      .expand((widget) => widget),
                ],
              ),
            ),

            // spv area panel
            const VerticalSizedBox(height: 2),
            CustomCard(
              content: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      customLabelText(text: StringValue.SPV_AREA),
                      CustomTextButton(
                        title: 'Tambah',
                        onPressed: () {
                          c.linkUserToOutletRole(AppConstants.ROLE_SPVAREA);
                        },
                      ),
                    ],
                  ),
                  ...spvAreas
                      .mapIndexed(
                        (index, user) => [
                          CustomNavItem(
                            image: svg,
                            isProfileImage: true,
                            title: user.name,
                            trailing: DeleteIconButton(
                              onPressed: () {
                                c.deleteUserFromOutlet(
                                  AppConstants.ROLE_SPVAREA,
                                  user.id,
                                  user.name,
                                );
                              },
                            ),
                            marginBottom: false,
                          ),
                          if (index < spvAreas.length - 1) VerticalSizedBox(),
                        ],
                      )
                      .expand((widget) => widget),
                ],
              ),
            ),

            // operator panel
            const VerticalSizedBox(height: 2),
            CustomCard(
              content: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      customLabelText(text: StringValue.OPERATOR),
                      CustomTextButton(
                        title: 'Tambah',
                        onPressed: () {
                          c.linkUserToOutletRole(AppConstants.ROLE_OPERATOR);
                        },
                      ),
                    ],
                  ),
                  ...operators
                      .mapIndexed(
                        (index, user) => [
                          CustomNavItem(
                            image: svg,
                            isProfileImage: true,
                            title: user.name,
                            trailing: DeleteIconButton(
                              onPressed: () {
                                c.deleteUserFromOutlet(
                                  AppConstants.ROLE_OPERATOR,
                                  user.id,
                                  user.name,
                                );
                              },
                            ),
                            marginBottom: false,
                          ),
                          if (index < operators.length - 1) VerticalSizedBox(),
                        ],
                      )
                      .expand((widget) => widget),
                ],
              ),
            ),

            const VerticalSizedBox(height: 2),
            if (latestSync != null)
              customFooterText(
                textAlign: TextAlign.center,
                text:
                    'Diperbarui ${contextualLocalDateTimeFormat(c.data.latestSync.value!)}',
              ),
            const VerticalSizedBox(height: 10),
          ],
        ),
      );
    });
  }
}
