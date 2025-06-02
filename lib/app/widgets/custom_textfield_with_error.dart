import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project428app/app/widgets/field_error_widget.dart';
import 'package:project428app/app/widgets/text_header.dart';

class CustomTextfieldWithError extends StatelessWidget {
  const CustomTextfieldWithError({
    super.key,
    required this.controller,
    required this.title,
    required this.error,
    required this.errorText,
    this.suffixIcon,
    this.onChanged,
    this.inputFormatter,
    this.inputType,
  });

  final TextEditingController controller;
  final String title, errorText;
  final bool error;
  final Widget? suffixIcon;
  final ValueChanged<String>? onChanged;
  final List<TextInputFormatter>? inputFormatter;
  final TextInputType? inputType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextTitle(text: title),
        SizedBox(height: 5),
        Material(
          elevation: 1,
          borderRadius: BorderRadius.circular(8),
          child: TextField(
            controller: controller,
            inputFormatters: inputFormatter,
            keyboardType: inputType,
            decoration: InputDecoration(
              isDense: true,
              filled: true,
              fillColor: Colors.grey[50],
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  style: BorderStyle.solid,
                  color: error ? Colors.red : Colors.transparent,
                ),
              ),
              suffixIcon: suffixIcon,
            ),
            onChanged: onChanged,
          ),
        ),
        FieldErrorWidget(isError: error, text: errorText),
      ],
    );
  }
}
