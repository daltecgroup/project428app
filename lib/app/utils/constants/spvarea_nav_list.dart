import 'package:flutter/material.dart';

import '../../routes/app_pages.dart';
import '../../shared/custom_drawer.dart';

List<DrawerItem> get spvareaNav {
  return [
    DrawerItem(
      title: 'Beranda',
      route: Routes.SPVAREA_DASHBOARD,
      icon: Icons.home_filled,
    ),
    DrawerItem(
      title: 'Pesanan',
      route: Routes.ORDER_LIST,
      icon: Icons.delivery_dining,
    ),
    DrawerItem(title: 'Gerai', route: Routes.OUTLET_LIST, icon: Icons.flag),
  ];
}
