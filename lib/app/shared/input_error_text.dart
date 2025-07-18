import 'package:abg_pos_app/app/utils/theme/text_style.dart';
import 'package:flutter/material.dart';

class InputErrorText extends StatelessWidget {
  const InputErrorText({super.key, required this.isError, required this.text});

  final bool isError;
  final String text;

  @override
  Widget build(BuildContext context) {
    return isError
        ? Column(
            children: [
              SizedBox(height: 5),
              Text(text, style: AppTextStyle.errorText),
            ],
          )
        : SizedBox();
  }
}
