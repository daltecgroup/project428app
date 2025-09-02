import 'package:abg_pos_app/app/controllers/image_picker_controller.dart';
import 'package:abg_pos_app/app/utils/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class DetailImagePanel extends StatelessWidget {
  const DetailImagePanel({
    super.key,
    required this.imagePicker,
    this.imgUrl,
    this.selectImage,
  });

  final ImagePickerController imagePicker;
  final String? imgUrl;
  final VoidCallback? selectImage;

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
              child: imgUrl == null
                  ? SvgPicture.asset(AppConstants.IMG_PLACEHOLDER)
                  : Image.network(
                      AppConstants.CURRENT_BASE_API_URL_IMAGE + imgUrl!,
                      fit: BoxFit.cover,
                    ),
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
                onPressed: selectImage,
                icon: Icon(Icons.edit),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
