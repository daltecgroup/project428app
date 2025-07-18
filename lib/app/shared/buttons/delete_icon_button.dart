import 'package:abg_pos_app/app/utils/constants/app_constants.dart';
import 'package:abg_pos_app/app/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';

class DeleteIconButton extends StatelessWidget {
  const DeleteIconButton({super.key, required this.onPressed, this.tooltip});

  final String? tooltip;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      tooltip: tooltip,
      icon: Icon(
        Icons.delete,
        size: AppConstants.DEFAULT_ICON_SIZE,
        color: AppColors.error,
      ),
    );
  }
}
