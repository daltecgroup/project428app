import 'package:abg_pos_app/app/shared/custom_appbar_lite.dart';
import 'package:abg_pos_app/app/shared/pages/empty_list_page.dart';
import 'package:abg_pos_app/app/utils/constants/padding_constants.dart';
import 'package:abg_pos_app/app/utils/helpers/number_helper.dart';
import 'package:abg_pos_app/app/utils/helpers/text_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

import 'package:get/get.dart';

import '../../../../data/models/Menu.dart';
import '../../../../routes/app_pages.dart';
import '../../../../shared/buttons/floating_add_button.dart';
import '../../../../shared/custom_nav_item.dart';
import '../../../../shared/status_sign.dart';
import '../../../../shared/vertical_sized_box.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/helpers/time_helper.dart';
import '../../../../utils/theme/custom_text.dart';
import '../controllers/menu_list_controller.dart';

class MenuListView extends GetView<MenuListController> {
  const MenuListView({super.key});
  @override
  Widget build(BuildContext context) {
    final svg = Svg(AppConstants.IMG_PLACEHOLDER);
    return Scaffold(
      appBar: customAppBarLite(
        context: context,
        title: 'Menu',
        backRoute: Routes.PRODUCT,
      ),
      body: RefreshIndicator(
        child: Obx(() {
          var groupedMenu = controller.groupMenusByCategory;

          if (groupedMenu.keys.toList().isEmpty) {
            return EmptyListPage(
              refresh: () {
                controller.refreshData();
              },
              text: 'Menu Kosong',
            );
          }

          if (controller.data.menus.isEmpty)
            return EmptyListPage(
              refresh: () => controller.data.syncData(refresh: true),
              text: 'Menu Kosong',
            );
          return ListView(
            padding: horizontalPadding,
            children: [
              const VerticalSizedBox(height: 2),
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
                          controller.categoryData.getCategoryName(
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
                            image: svg,
                            title: normalizeName(menu.name),
                            subTitle: inRupiah(menu.price),
                            trailing: StatusSign(
                              status: menu.isActive,
                              size: (AppConstants.DEFAULT_ICON_SIZE / 1.5)
                                  .round(),
                            ),
                            onTap: () {
                              controller.data.selectedMenu.value = menu;
                              Get.toNamed(Routes.MENU_DETAIL);
                            },
                          );
                        },
                      ),
                    ],
                  );
                }),
              ),
              const VerticalSizedBox(),
              if (controller.data.latestSync.value != null)
                customFooterText(
                  textAlign: TextAlign.center,
                  text:
                      'Diperbarui ${contextualLocalDateTimeFormat(controller.data.latestSync.value!)}',
                ),
              const VerticalSizedBox(height: 5),
            ],
          );
        }),
        onRefresh: () => controller.refreshData(),
      ),
      floatingActionButton: FloatingAddButton(
        tooltip: 'Tambah Menu',
        onPressed: () {
          controller.data.selectedMenu.value = null as Menu?;
          Get.toNamed(Routes.MENU_INPUT);
        },
      ),
    );
  }
}
