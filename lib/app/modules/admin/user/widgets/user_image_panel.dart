import 'package:abg_pos_app/app/utils/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserImagePanel extends StatelessWidget {
  const UserImagePanel({super.key, this.imgUrl});

  final String? imgUrl;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: Get.width * 0.2,
        width: Get.width * 0.2,
        child: Stack(
          children: [
            Material(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              elevation: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                child: SizedBox(
                  height: Get.width * 0.2,
                  width: Get.width * 0.2,
                  child: imgUrl == null
                      ? Image.asset(
                          AppConstants.PROFILE_PLACEHOLDER_PNG,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          AppConstants.PROFILE_PLACEHOLDER_PNG,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: () {
                  // update user image function
                },
                child: CircleAvatar(
                  backgroundColor: Colors.blue[50],
                  radius: AppConstants.DEFAULT_NAV_ICON_SIZE / 1.5,
                  child: Icon(
                    Icons.camera_alt,
                    size: AppConstants.DEFAULT_NAV_ICON_SIZE / 1.5,
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
