import 'package:abg_pos_app/app/utils/constants/padding_constants.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../shared/custom_nav_item.dart';
import '../controllers/product_controller.dart';
import '../../../../routes/app_pages.dart';
import '../../../../shared/custom_appbar.dart';
import '../../../../shared/custom_drawer.dart';
import '../../../../utils/constants/app_constants.dart';

class ProductView extends GetView<ProductController> {
  const ProductView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('Produk'),
      drawer: customDrawer(),
      body: Obx(
        () => RefreshIndicator(
          child: ListView(
            padding: horizontalPadding,
            children: [
              SizedBox(height: AppConstants.DEFAULT_VERTICAL_MARGIN * 2),
              CustomNavItem(
                title: 'Menu',
                subTitle: '${controller.menuCount} item',
                onTap: () => Get.toNamed(Routes.MENU_LIST),
              ),
              CustomNavItem(
                title: 'Kategori Menu',
                subTitle: '${controller.menuCategoryCount} item',
                onTap: () => Get.toNamed(Routes.MENU_CATEGORY_LIST),
              ),
              CustomNavItem(
                title: 'Bahan Baku',
                subTitle: '${controller.ingredientCount} item',
                onTap: () => Get.toNamed(Routes.INGREDIENT_LIST),
              ),
              CustomNavItem(
                title: 'Add-on',
                subTitle: '${controller.addonCount} item',
                onTap: () => Get.toNamed(Routes.ADDON_LIST),
              ),
              CustomNavItem(
                title: 'Promo',
                subTitle: 'Paket dan Bonus Pembelian',
                onTap: () => Get.toNamed(Routes.PROMO),
              ),
            ],
          ),
          onRefresh: () => controller.refreshAll(),
        ),
      ),
    );
  }
}
