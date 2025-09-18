import 'package:abg_pos_app/app/utils/constants/app_constants.dart';
import 'package:abg_pos_app/app/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.content,
    this.flatTop,
    this.padding,
    this.color,
    this.customPadding,
    this.enableShadow,
  });

  final Widget content;
  final bool? flatTop;
  final double? padding;
  final Color? color;
  final EdgeInsets? customPadding;
  final bool? enableShadow;

  @override
  Widget build(BuildContext context) {
    final borderRadius = (flatTop ?? false)
        ? const BorderRadius.only(
            topLeft: Radius.circular(0),
            topRight: Radius.circular(0),
            bottomLeft: Radius.circular(AppConstants.DEFAULT_BORDER_RADIUS),
            bottomRight: Radius.circular(AppConstants.DEFAULT_BORDER_RADIUS),
          )
        : BorderRadius.circular(AppConstants.DEFAULT_BORDER_RADIUS);

    final shadow = enableShadow ?? true;

    return Card(
      color: color ?? AppColors.surface,
      elevation: shadow ? 1 : 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: borderRadius),
      child: Padding(
        padding:
            customPadding ??
            EdgeInsets.all(padding ?? AppConstants.DEFAULT_PADDING),
        child: content,
      ),
    );
  }
}
