import 'package:abg_pos_app/app/utils/constants/app_constants.dart';
import 'package:flutter/material.dart';

class HorizontalSizedBox extends StatelessWidget {
  const HorizontalSizedBox({super.key, this.width});

  final double? width;

  @override
  Widget build(BuildContext context) {
    double w = width ?? 1;
    return SizedBox(width: AppConstants.DEFAULT_VERTICAL_MARGIN * w);
  }
}
