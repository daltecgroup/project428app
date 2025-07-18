import 'package:abg_pos_app/app/utils/theme/text_style.dart';
import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.title,
    required this.onPressed,
  });

  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(visualDensity: VisualDensity.compact),
      child: Text(title, style: AppTextStyle.secondLinkText),
    );
  }
}
