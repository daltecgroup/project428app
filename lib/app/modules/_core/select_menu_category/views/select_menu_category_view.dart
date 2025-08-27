import 'package:abg_pos_app/app/utils/constants/padding_constants.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../shared/custom_appbar_lite.dart';
import '../../../../shared/custom_card.dart';
import '../../../../shared/pages/empty_list_page.dart';
import '../../../../shared/vertical_sized_box.dart';
import '../../../../utils/helpers/text_helper.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/helpers/number_helper.dart';
import '../controllers/select_menu_category_controller.dart';

class SelectMenuCategoryView extends GetView<SelectMenuCategoryController> {
  const SelectMenuCategoryView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarLite(
        title: 'Pilih Kategori Paket',
        result: controller.initialList,
        actions: [
          Obx(
            () => controller.bundleCategoryList.isNotEmpty
                ? IconButton(
                    onPressed: () {
                      Get.back(result: controller.bundleCategoryList);
                    },
                    icon: Icon(
                      Icons.check,
                      size: AppConstants.DEFAULT_ICON_SIZE + 4,
                    ),
                  )
                : SizedBox(),
          ),
          SizedBox(width: 8),
        ],
      ),
      body: Obx(() {
        final categories = controller.data.categories;
        if (categories.isEmpty)
          return EmptyListPage(
            refresh: () => controller.data.syncData(refresh: true),
            text: 'Daftar Kategori tidak ditemukan',
          );
        return ListView(
          padding: horizontalPadding,
          children: [
            const VerticalSizedBox(height: 2),
            ...categories.map((category) {
              final bundleCategory = controller.getBundleCategoryById(
                category.id,
              );
              return Column(
                children: [
                  CustomCard(
                    padding: 10,
                    content: Column(
                      children: [
                        // name and qty selector
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Text(
                                normalizeName(category.name),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: IntrinsicWidth(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    if (bundleCategory != null)
                                      IconButton(
                                        visualDensity: VisualDensity.compact,
                                        onPressed: () {
                                          bundleCategory.substractQty();
                                          if (bundleCategory.qty == 0) {
                                            controller.removeBundleCategory(
                                              category.id,
                                            );
                                          }
                                          controller.bundleCategoryList
                                              .refresh();
                                        },
                                        icon: Icon(
                                          Icons.remove_circle_rounded,
                                          color: Colors.red,
                                        ),
                                      ),
                                    if (bundleCategory != null)
                                      GestureDetector(
                                        onTap: () async {},
                                        child: Container(
                                          constraints: BoxConstraints(
                                            minWidth: 40,
                                          ),
                                          child: Text(
                                            textAlign: TextAlign.center,
                                            inLocalNumber(bundleCategory.qty),
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                    IconButton(
                                      visualDensity: VisualDensity.compact,
                                      onPressed: () async {
                                        if (bundleCategory == null) {
                                          controller.addCategoryToList(
                                            category,
                                          );
                                        } else {
                                          bundleCategory.addQty();
                                          controller.bundleCategoryList
                                              .refresh();
                                        }
                                      },
                                      icon: Icon(
                                        Icons.add_circle_rounded,
                                        color: bundleCategory != null
                                            ? Colors.lightGreen[700]
                                            : Colors.grey[500],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                        // category status
                      ],
                    ),
                  ),
                  const VerticalSizedBox(),
                ],
              );
            }),
          ],
        );
      }),
    );
  }
}
