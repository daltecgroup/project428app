import 'package:flutter/material.dart';

import '../../routes/app_pages.dart';
import '../../shared/custom_drawer.dart';

List<DrawerItem> get operatorNav {
  return [
    DrawerItem(
      title: 'Beranda',
      route: Routes.OPERATOR_DASHBOARD,
      icon: Icons.home_filled,
    ),
    DrawerItem(
      title: 'Penjualan',
      route: Routes.OPERATOR_SALE,
      icon: Icons.monetization_on,
    ),
    DrawerItem(
      title: 'Pesanan',
      route: Routes.OPERATOR_ORDER_LIST,
      icon: Icons.delivery_dining,
      // indicator: 2,
    ),
    DrawerItem(
      title: 'Stok',
      route: Routes.OPERATOR_OUTLET_INVENTORY,
      icon: Icons.inventory_2,
      // indicator: 2,
    ),
    DrawerItem(
      title: 'Presensi',
      route: Routes.OPERATOR_ATTENDANCE,
      icon: Icons.list_alt_outlined,
    ),
  ];
}
