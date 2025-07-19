import 'package:abg_pos_app/app/utils/helpers/text_helper.dart';
import 'package:flutter/material.dart';
import '../utils/theme/app_colors.dart';
import '../utils/constants/app_constants.dart';

class CustomNavItem extends StatelessWidget {
  const CustomNavItem({
    super.key,
    this.title,
    this.titleWidget,
    this.subTitle,
    this.subTitleWidget,
    this.onTap,
    this.disabled,
    this.trailing,
    this.leading,
    this.image,
    this.disableTrailing,
    this.marginBottom,
    this.isProfileImage,
    this.isThreeLine,
    this.disablePaddingRight,
  });

  final String? title;
  final Widget? titleWidget;
  final String? subTitle;
  final Widget? subTitleWidget;
  final VoidCallback? onTap;
  final bool? disabled;
  final Widget? trailing;
  final Widget? leading;
  final ImageProvider? image;
  final bool? disableTrailing;
  final bool? marginBottom;
  final bool? isProfileImage;
  final bool? isThreeLine;
  final bool? disablePaddingRight;

  @override
  Widget build(BuildContext context) {
    Color? color;

    final mb = marginBottom ?? true;
    final pi = isProfileImage ?? false;

    if (disabled == null || disabled == false) {
      color = AppColors.onPrimary;
    }

    return Card(
      margin: mb
          ? EdgeInsets.only(bottom: AppConstants.DEFAULT_VERTICAL_MARGIN)
          : EdgeInsets.all(0),
      elevation: 1,
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(
          AppConstants.DEFAULT_BORDER_RADIUS,
        ),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.only(
          left: AppConstants.DEFAULT_PADDING,
          right: disablePaddingRight == null ? AppConstants.DEFAULT_PADDING : 0,
        ),
        isThreeLine: isThreeLine,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(
            AppConstants.DEFAULT_BORDER_RADIUS,
          ),
        ),
        leading: leading ?? leadingImg(image, pi),
        title:
            titleWidget ??
            Text(
              normalizeName(title ?? ''),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
        subtitle:
            subTitleWidget ??
            (subTitle != null
                ? Text(
                    subTitle!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14),
                  )
                : null),
        onTap: onTap,
        trailing:
            trailing ??
            (disableTrailing ?? false
                ? null
                : Icon(Icons.arrow_forward_ios_rounded)),
      ),
    );
  }

  Container? leadingImg(ImageProvider? image, bool circle) {
    if (image != null) {
      return Container(
        height: 36,
        width: 36,
        decoration: BoxDecoration(
          shape: circle ? BoxShape.circle : BoxShape.rectangle,
          borderRadius: circle
              ? null
              : BorderRadius.circular(AppConstants.DEFAULT_BORDER_RADIUS),
          image: DecorationImage(image: image),
        ),
      );
    }
    return null;
  }
}
