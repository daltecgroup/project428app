import 'package:abg_pos_app/app/utils/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class DetailImagePanel extends StatelessWidget {
  const DetailImagePanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(AppConstants.DEFAULT_BORDER_RADIUS),
        topLeft: Radius.circular(AppConstants.DEFAULT_BORDER_RADIUS),
      ),
      elevation: 2,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(AppConstants.DEFAULT_BORDER_RADIUS),
          topLeft: Radius.circular(AppConstants.DEFAULT_BORDER_RADIUS),
        ),
        child: Stack(
          children: [
            SizedBox(
              height: Get.width - AppConstants.DEFAULT_PADDING * 2,
              width: double.infinity,
              child: SvgPicture.asset(AppConstants.IMG_PLACEHOLDER),
            ),
            Positioned(
              right: 5,
              top: 5,
              child: IconButton(
                tooltip: 'Ubah Gambar',
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.black12),
                  iconColor: WidgetStatePropertyAll(Colors.black87),
                ),
                onPressed: () {
                  // change addon image
                },
                icon: Icon(Icons.edit),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
