import '../../../../utils/theme/button_style.dart';
import 'package:flutter/material.dart';

class SelectRoleButton extends StatelessWidget {
  const SelectRoleButton({
    super.key,
    required this.title,
    required this.color,
    required this.onPressed,
  });

  final String title;
  final Color color;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 45,
      margin: EdgeInsets.only(bottom: 10),
      child: TextButton(
        onPressed: onPressed,
        style: selectRoleButtonStyle(color),
        child: Text(title),
      ),
    );
  }
}
