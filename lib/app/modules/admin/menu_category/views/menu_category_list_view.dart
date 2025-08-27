import 'package:abg_pos_app/app/utils/constants/padding_constants.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../routes/app_pages.dart';
import '../../../../shared/status_sign.dart';
import '../../../../shared/custom_nav_item.dart';
import '../../../../utils/theme/custom_text.dart';
import '../../../../shared/custom_appbar_lite.dart';
import '../../../../shared/vertical_sized_box.dart';
import '../../../../utils/helpers/time_helper.dart';
import '../../../../utils/constants/app_constants.dart';
import '../controllers/menu_category_list_controller.dart';
import '../../../../shared/buttons/floating_add_button.dart';

class MenuCategoryListView extends GetView<MenuCategoryListController> {
  const MenuCategoryListView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarLite(
        context: context,
        title: 'Kategori Menu',
        backRoute: controller.backRoute,
      ),
      body: RefreshIndicator(
        child: Obx(() {
          var activeCategories = controller.filteredCategories(status: true);
          var deactiveCategories = controller.filteredCategories(status: false);

          if (controller.data.isLoading.value) {
            Center(child: CircularProgressIndicator());
          }

          if (controller.data.categories.isEmpty) {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  customListTitleText(text: 'Kategori Kosong'),
                  TextButton(
                    onPressed: () {
                      controller.data.syncData(refresh: true);
                    },
                    child: Text('Muat Ulang'),
                  ),
                ],
              ),
            );
          }

          return ListView(
            padding: horizontalPadding,
            children: [
              VerticalSizedBox(height: 2),
              if (activeCategories.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(activeCategories.length, (index) {
                    return CustomNavItem(
                      leading: Icon(Icons.list_alt_rounded),
                      title: activeCategories[index].name.capitalize!,
                      onTap: () {
                        controller.showActions(
                          name: activeCategories[index].name,
                          categoryId: activeCategories[index].id,
                          currentStatus: activeCategories[index].isActive,
                        );
                      },
                      trailing: StatusSign(
                        status: activeCategories[index].isActive,
                        size: (AppConstants.DEFAULT_ICON_SIZE / 1.5).round(),
                      ),
                    );
                  }),
                ),
              if (deactiveCategories.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    VerticalSizedBox(),
                    customListHeaderText(text: 'Kategori Nonaktif'),
                    VerticalSizedBox(),
                    ...List.generate(deactiveCategories.length, (index) {
                      return CustomNavItem(
                        title: deactiveCategories[index].name.capitalize!,
                        onTap: () {
                          controller.showActions(
                            name: deactiveCategories[index].name,
                            categoryId: deactiveCategories[index].id,
                            currentStatus: deactiveCategories[index].isActive,
                          );
                        },
                        trailing: StatusSign(
                          status: deactiveCategories[index].isActive,
                          size: (AppConstants.DEFAULT_ICON_SIZE / 1.5).round(),
                        ),
                      );
                    }),
                  ],
                ),
              VerticalSizedBox(),
              if (controller.data.latestSync.value != null)
                customFooterText(
                  textAlign: TextAlign.center,
                  text:
                      'Diperbarui ${contextualLocalDateTimeFormat(controller.data.latestSync.value!)}',
                ),
              VerticalSizedBox(height: 5),
            ],
          );
        }),
        onRefresh: () => controller.refreshCategories(),
      ),
      floatingActionButton: FloatingAddButton(
        tooltip: 'Tambah Kategori Menu',
        onPressed: () {
          controller.data.selectedMenuCategory.value = null;
          Get.toNamed(Routes.MENU_CATEGORY_INPUT);
        },
      ),
    );
  }
}
