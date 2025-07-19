import 'package:abg_pos_app/app/shared/horizontal_sized_box.dart';
import 'package:abg_pos_app/app/utils/constants/app_constants.dart';
import 'package:flutter/material.dart';

class CustomCardHeader extends StatelessWidget {
  const CustomCardHeader({
    super.key,
    required this.title,
    this.isOpen,
    this.onTap,
  });

  final String title;
  final bool? isOpen;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final open = isOpen ?? true;
    return Card(
      margin: EdgeInsets.all(0),
      color: Colors.red[50],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.only(
          topLeft: Radius.circular(AppConstants.DEFAULT_BORDER_RADIUS),
          topRight: Radius.circular(AppConstants.DEFAULT_BORDER_RADIUS),
          bottomLeft: open
              ? Radius.zero
              : Radius.circular(AppConstants.DEFAULT_BORDER_RADIUS),
          bottomRight: open
              ? Radius.zero
              : Radius.circular(AppConstants.DEFAULT_BORDER_RADIUS),
        ),
      ),
      child: Padding(
        padding: EdgeInsetsGeometry.only(
          left: AppConstants.DEFAULT_PADDING,
          right: AppConstants.DEFAULT_PADDING,
          top: AppConstants.DEFAULT_PADDING / 2,
          bottom: AppConstants.DEFAULT_PADDING / 2,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: AppConstants.DEFAULT_FONT_SIZE - 2,
              ),
            ),
            if (isOpen != null)
              GestureDetector(
                onTap: onTap,
                child: Row(
                  children: [
                    Text(open ? 'Tutup' : 'Buka'),
                    const HorizontalSizedBox(width: 0.5),
                    Icon(
                      open
                          ? Icons.expand_less_rounded
                          : Icons.expand_more_rounded,
                      size: AppConstants.DEFAULT_FONT_SIZE,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
