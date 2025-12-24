import 'package:abg_pos_app/app/utils/theme/custom_text.dart';
import 'package:flutter/material.dart';

class TypeTitle extends StatelessWidget {
  const TypeTitle({super.key, required this.type});

  final String type;

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case 'addon':
        return customLabelText(text: 'Addon');
      case 'menu_single':
        return customLabelText(text: 'Reguler');
      case 'bundle':
        return customLabelText(text: 'Paket');
      default:
        return customLabelText(text: '');
    }
  }
}
