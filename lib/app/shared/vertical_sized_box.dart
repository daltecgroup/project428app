import 'package:abg_pos_app/app/utils/constants/app_constants.dart';
import 'package:flutter/material.dart';

class VerticalSizedBox extends StatelessWidget {
  const VerticalSizedBox({super.key, this.height});

  final double? height;

  @override
  Widget build(BuildContext context) {
    num h = height ?? 1;
    return SizedBox(height: AppConstants.DEFAULT_VERTICAL_MARGIN * h);
  }
}
