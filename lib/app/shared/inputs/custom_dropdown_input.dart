import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../utils/constants/app_constants.dart';
import '../../utils/theme/custom_text.dart';

class CustomDropdownInput extends StatelessWidget {
  const CustomDropdownInput({
    super.key,
    required this.title,
    required this.data,
    required this.onChanged,
    this.value,
  });

  final String title;
  final List data;
  final ValueChanged onChanged;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        customInputTitleText(text: title),
        SizedBox(height: 5),
        Material(
          elevation: 1,
          borderRadius: BorderRadius.circular(
            AppConstants.DEFAULT_BORDER_RADIUS,
          ),
          child: DropdownButtonFormField<String>(
            decoration: InputDecoration(
              isDense: true,
              filled: true,
              fillColor: Colors.grey[50],
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(
                  AppConstants.DEFAULT_BORDER_RADIUS,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  AppConstants.DEFAULT_BORDER_RADIUS,
                ),
                borderSide: BorderSide(
                  style: BorderStyle.solid,
                  color: Colors.transparent,
                ),
              ),
            ),
            value: value,
            items: data
                .map(
                  (e) => DropdownMenuItem<String>(
                    value: e['id'],
                    child: SizedBox(
                      width: Get.width - (AppConstants.DEFAULT_PADDING * 8),
                      child: Text(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        e['nama'],
                      ),
                    ),
                  ),
                )
                .toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
