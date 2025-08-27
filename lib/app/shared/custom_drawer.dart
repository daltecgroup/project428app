import 'package:abg_pos_app/app/utils/constants/padding_constants.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../routes/app_pages.dart';
import '../utils/theme/custom_text.dart';
import '../utils/services/auth_service.dart';
import '../utils/constants/app_constants.dart';
import '../utils/services/setting_service.dart';
import '../utils/constants/admin_nav_list.dart';
import '../utils/constants/spvarea_nav_list.dart';
import '../utils/constants/operator_nav_list.dart';
import '../utils/constants/franchisee_nav_list.dart';

Drawer customDrawer() {
  final setting = Get.find<SettingService>();
  final auth = Get.find<AuthService>();

  final roleMap = {
    AppConstants.ROLE_ADMIN: ('Menu Admin', adminNav),
    AppConstants.ROLE_FRANCHISEE: ('Menu Franchisee', franchiseeNav),
    AppConstants.ROLE_SPVAREA: ('Menu SPV Area', spvareaNav),
    AppConstants.ROLE_OPERATOR: ('Menu Operator', operatorNav),
  };

  final (title, navList) =
      roleMap[setting.currentRole.value] ?? ('Menu Pengguna', operatorNav);

  return Drawer(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        const SizedBox(height: 100),
        Padding(
          padding: const EdgeInsets.only(left: AppConstants.DEFAULT_PADDING),
          child: customCaptionText(text: title),
        ),
        ...navList.map(
          (item) => DrawerListItem(item: item, indicator: item.indicator),
        ),
        Padding(padding: horizontalPadding, child: Divider(height: 0.2)),
        _drawerTile(
          Icons.settings,
          'Pengaturan',
          () => Get.toNamed(Routes.SETTING),
          Get.currentRoute == Routes.SETTING,
        ),
        _drawerTile(
          Icons.logout_outlined,
          'Logout',
          () => auth.logout(),
          false,
        ),
      ],
    ),
  );
}

Widget _drawerTile(
  IconData icon,
  String label,
  VoidCallback onTap,
  bool isSelected,
) {
  SettingService setting = Get.find<SettingService>();
  return ListTile(
    selected: isSelected,
    leading: Icon(icon, size: AppConstants.DEFAULT_NAV_ICON_SIZE),
    title: Text(label),
    onTap: onTap,
    selectedColor: setting.currentTheme.primaryColor,
    selectedTileColor: setting.currentTheme.highlightColor,
  );
}

class DrawerListItem extends StatelessWidget {
  const DrawerListItem({super.key, required this.item, this.indicator});

  final DrawerItem item;
  final int? indicator;

  @override
  Widget build(BuildContext context) {
    SettingService setting = Get.find<SettingService>();
    return ListTile(
      leading: Icon(item.icon, size: AppConstants.DEFAULT_NAV_ICON_SIZE),
      title: Text(item.title),
      selected: item.isSelected,
      selectedColor: setting.currentTheme.primaryColor,
      selectedTileColor: setting.currentTheme.highlightColor,
      trailing: indicator == null
          ? null
          : Badge(label: Text(indicator.toString())),
      onTap: () {
        // Handle item tap
        Get.toNamed(item.route);
      },
    );
  }
}

class DrawerItem {
  final String title;
  final String route;
  final IconData icon;
  final int? indicator;

  DrawerItem({
    required this.title,
    required this.route,
    required this.icon,
    this.indicator,
  });

  bool get isSelected {
    return route == Get.currentRoute;
  }
}
