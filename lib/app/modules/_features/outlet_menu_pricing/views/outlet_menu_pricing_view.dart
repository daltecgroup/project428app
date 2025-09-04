import 'package:abg_pos_app/app/shared/custom_appbar_lite.dart';
import 'package:abg_pos_app/app/shared/vertical_sized_box.dart';
import 'package:abg_pos_app/app/utils/constants/padding_constants.dart';
import 'package:abg_pos_app/app/utils/helpers/text_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

import 'package:get/get.dart';

import '../../../../data/models/Menu.dart';
import '../../../../routes/app_pages.dart';
import '../../../../shared/custom_nav_item.dart';
import '../../../../shared/horizontal_sized_box.dart';
import '../../../../shared/pages/empty_list_page.dart';
import '../../../../shared/pages/failed_page_placeholder.dart';
import '../../../../shared/status_sign.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/helpers/number_helper.dart';
import '../../../../utils/helpers/time_helper.dart';
import '../../../../utils/theme/custom_text.dart';
import '../controllers/outlet_menu_pricing_controller.dart';

class OutletMenuPricingView extends GetView<OutletMenuPricingController> {
  const OutletMenuPricingView({super.key});
  @override
  Widget build(BuildContext context) {
    final svg = Svg(AppConstants.IMG_PLACEHOLDER);
    return Obx(() {
      final outlet = controller.outletData.currentOutlet;
      if (outlet == null) FailedPagePlaceholder();

      var groupedMenu = controller.groupMenusByCategory;
      if (groupedMenu.keys.toList().isEmpty) {
        return EmptyListPage(
          refresh: () {
            controller.refreshData();
          },
          text: 'Menu Kosong',
        );
      }

      if (controller.menuData.menus.isEmpty)
        return EmptyListPage(
          refresh: () => controller.menuData.syncData(refresh: true),
          text: 'Menu Kosong',
        );

      return Scaffold(
        appBar: customAppBarLite(
          title: 'Harga Jual',
          subtitle: normalizeName(outlet!.name),
        ),
        body: RefreshIndicator(
          onRefresh: () => controller.refreshData(),
          child: ListView(
            padding: horizontalPadding,
            children: [
              const VerticalSizedBox(height: 2),

              // menu category
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(groupedMenu.keys.length, (index) {
                  if (groupedMenu[groupedMenu.keys.toList()[index]]!.isEmpty) {
                    return SizedBox();
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customListHeaderText(
                        text: normalizeName(
                          controller.menuCategoryData.getCategoryName(
                            groupedMenu.keys.toList()[index],
                          ),
                        ),
                      ),
                      const VerticalSizedBox(height: 0.7),
                      ...List.generate(
                        groupedMenu[groupedMenu.keys.toList()[index]]!.length,
                        (secondIndex) {
                          Menu? menu =
                              groupedMenu[groupedMenu.keys
                                  .toList()[index]]?[secondIndex];

                          if (menu == null) {
                            return SizedBox();
                          }

                          return CustomNavItem(
                            image: menu.image == null
                                ? svg
                                : NetworkImage(
                                    AppConstants.CURRENT_BASE_API_URL_IMAGE +
                                        menu.image!,
                                  ),
                            title: normalizeName(menu.name),
                            // subTitle: inRupiah(menu.price),
                            subTitleWidget: Row(
                              children: [
                                Text(inRupiah(menu.priceAfterDiscount)),
                                if (menu.discount.isGreaterThan(0)) ...[
                                  const HorizontalSizedBox(width: 0.5),
                                  Badge(
                                    backgroundColor: menu.isActive
                                        ? null
                                        : Colors.grey,
                                    label: Text(
                                      '${inLocalNumber(menu.discount)}%',
                                    ),
                                  ),
                                ],
                              ],
                            ),
                            trailing: StatusSign(
                              status: menu.isActive,
                              size: (AppConstants.DEFAULT_ICON_SIZE / 1.5)
                                  .round(),
                            ),
                            onTap: () {
                              // controller.menuData.selectedMenu.value = menu;
                              // Get.toNamed(Routes.MENU_DETAIL);
                            },
                          );
                        },
                      ),
                    ],
                  );
                }),
              ),
              const VerticalSizedBox(),
              if (controller.menuData.latestSync.value != null)
                customFooterText(
                  textAlign: TextAlign.center,
                  text:
                      'Diperbarui ${contextualLocalDateTimeFormat(controller.menuData.latestSync.value!)}',
                ),
              const VerticalSizedBox(height: 5),
            ],
          ),
        ),
      );
    });
  }
}
