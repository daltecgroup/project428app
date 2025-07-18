import 'package:abg_pos_app/app/utils/constants/string_value.dart';
import 'package:abg_pos_app/app/utils/theme/custom_text.dart';
import 'package:abg_pos_app/app/utils/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FailedPagePlaceholder extends StatelessWidget {
  const FailedPagePlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          customCaptionText(text: 'Gagal memuat halaman'),
          TextButton(
            onPressed: () => Get.back(),
            child: Text(StringValue.BACK, style: AppTextStyle.linkText),
          ),
        ],
      ),
    );
  }
}
