import 'package:abg_pos_app/app/shared/horizontal_sized_box.dart';
import 'package:flutter/material.dart';

class CustomSmallTextButton extends StatelessWidget {
  const CustomSmallTextButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.icon,
  });

  final String title;
  final VoidCallback onPressed;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        visualDensity: VisualDensity.compact,
        padding: WidgetStatePropertyAll(EdgeInsets.all(0)),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(5),
          ),
        ),
      ),
      child: Row(
        children: [
          Text(title, style: TextStyle(fontSize: 12)),
          icon == null ? SizedBox() : const HorizontalSizedBox(width: 0.5),
          icon ?? SizedBox(),
        ],
      ),
    );
  }
}
