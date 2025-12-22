import 'package:abg_pos_app/app/controllers/request_data_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../shared/custom_drawer.dart';

List<DrawerItem> get adminNav {
  final RequestDataController? requestData =
      Get.isRegistered<RequestDataController>()
      ? Get.find<RequestDataController>()
      : null;

  return [
    DrawerItem(
      title: 'Beranda',
      route: Routes.ADMIN_DASHBOARD,
      icon: Icons.home_filled,
    ),
    DrawerItem(
      title: 'Laporan',
      route: Routes.REPORT,
      icon: Icons.file_open_rounded,
    ),
    DrawerItem(title: 'Gerai', route: Routes.OUTLET_LIST, icon: Icons.flag),
    DrawerItem(
      title: 'Pesanan',
      route: Routes.ORDER_LIST,
      icon: Icons.delivery_dining,
    ),
    DrawerItem(title: 'Pengguna', route: Routes.USER_LIST, icon: Icons.person),
    DrawerItem(
      title: 'Produk',
      route: Routes.PRODUCT,
      icon: Icons.fastfood_rounded,
    ),
    DrawerItem(
      title: 'Permintaan',
      route: Routes.REQUEST,
      icon: Icons.request_quote_outlined,
      indicator: requestData == null
          ? null
          : requestData.pendingRequestCount == 0
          ? null
          : requestData.pendingRequestCount,
    ),
  ];
}
