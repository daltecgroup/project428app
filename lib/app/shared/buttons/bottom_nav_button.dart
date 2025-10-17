import 'package:abg_pos_app/app/utils/constants/app_constants.dart';
import 'package:abg_pos_app/app/utils/constants/string_value.dart';
import 'package:abg_pos_app/app/utils/theme/button_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavButton extends StatelessWidget {
  const BottomNavButton({
    super.key,
    this.backBtn,
    this.nextBtn,
    this.backCb,
    this.nextCb,
  });

  final String? backBtn, nextBtn;
  final VoidCallback? backCb, nextCb;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        alignment: Alignment.bottomCenter,
        padding: const EdgeInsets.only(
          bottom: AppConstants.DEFAULT_PADDING,
          left: AppConstants.DEFAULT_PADDING,
          right: AppConstants.DEFAULT_PADDING,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: TextButton(
                onPressed: backCb ?? () => Get.back(),
                child: Text(
                  backBtn ?? StringValue.BACK,
                  style: TextStyle(fontSize: AppConstants.DEFAULT_FONT_SIZE),
                ),
              ),
            ),
            SizedBox(width: AppConstants.DEFAULT_PADDING),
            Expanded(
              child: ElevatedButton(
                style: nextButtonStyle(),
                onPressed: nextCb ?? () {},
                child: Text(
                  nextBtn ?? StringValue.SUBMIT,
                  style: TextStyle(
                    fontSize: AppConstants.DEFAULT_FONT_SIZE,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
