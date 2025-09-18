import 'package:abg_pos_app/app/shared/input_error_text.dart';
import 'package:abg_pos_app/app/shared/vertical_sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/theme/app_colors.dart';
import '../utils/theme/custom_text.dart';

class CustomInputWithError extends StatelessWidget {
  const CustomInputWithError({
    super.key,
    required this.controller,
    this.enable,
    this.title,
    this.error,
    this.errorText,
    this.suffixIcon,
    this.prefixIcon,
    this.onChanged,
    this.inputFormatter,
    this.inputType,
    this.hint,
    this.obscure,
    this.autoFocus,
    this.onSubmitted,
    this.onTap,
    this.maxLines,
  });

  final TextEditingController controller;
  final bool? enable;
  final String? title;
  final bool? error;
  final String? errorText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final ValueChanged<String>? onChanged;
  final List<TextInputFormatter>? inputFormatter;
  final TextInputType? inputType;
  final String? hint;
  final bool? obscure;
  final bool? autoFocus;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onTap;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) customInputTitleText(text: title!),
        const VerticalSizedBox(height: 0.6),
        Material(
          elevation: 1,
          borderRadius: BorderRadius.circular(8),
          child: TextField(
            enabled: enable,
            maxLines: maxLines,
            controller: controller,
            inputFormatters: inputFormatter,
            keyboardType: inputType,
            obscureText: obscure ?? false,
            autofocus: autoFocus ?? false,
            onSubmitted: onSubmitted,
            onTap: onTap,
            decoration: InputDecoration(
              isDense: true,
              filled: true,
              hintText: hint,

              fillColor: AppColors.surface,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  style: BorderStyle.solid,
                  color: error != null
                      ? error!
                            ? Colors.red
                            : Colors.transparent
                      : Colors.transparent,
                ),
              ),
              suffixIcon: suffixIcon,
              prefixIcon: prefixIcon,
            ),
            onChanged: onChanged,
          ),
        ),
        if (error != null && errorText != null)
          InputErrorText(isError: error!, text: errorText!),
      ],
    );
  }
}
