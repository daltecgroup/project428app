import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../utils/theme/app_colors.dart';
import '../../../../utils/constants/app_constants.dart';

class SettingNavItem extends StatelessWidget {
  const SettingNavItem({
    super.key,
    required this.title,
    this.subTitle,
    this.route,
  });

  final String title;
  final String? subTitle;
  final String? route;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(
        bottom: AppConstants.DEFAULT_VERTICAL_MARGIN,
        left: AppConstants.DEFAULT_VERTICAL_MARGIN,
        right: AppConstants.DEFAULT_VERTICAL_MARGIN,
      ),
      elevation: 1,
      color: AppColors.onPrimary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(
          AppConstants.DEFAULT_BORDER_RADIUS,
        ),
      ),
      child: ListTile(
        onTap: () {
          if (route != null) Get.toNamed(route!);
        },
        title: Text(title),
        subtitle: subTitle != null ? Text(subTitle!) : null,
        trailing: Icon(Icons.arrow_forward_ios_rounded),
      ),
    );
  }
}
