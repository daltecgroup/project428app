import 'package:flutter/material.dart';

import '../../routes/app_pages.dart';
import '../../shared/custom_drawer.dart';

List<DrawerItem> get franchiseeNav {
  return [
    DrawerItem(
      title: 'Beranda',
      route: Routes.FRANCHISEE_DASHBOARD,
      icon: Icons.home_filled,
    ),
    DrawerItem(
      title: 'Laporan',
      route: Routes.REPORT,
      icon: Icons.file_open_rounded,
    ),
    DrawerItem(title: 'Gerai', route: Routes.OUTLET_LIST, icon: Icons.flag),
  ];
}
