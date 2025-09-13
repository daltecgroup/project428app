import 'package:abg_pos_app/app/modules/admin/user/controllers/user_detail_controller.dart';
import 'package:abg_pos_app/app/utils/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserImagePanel extends StatelessWidget {
  const UserImagePanel({super.key, this.imgUrl, required this.c});

  final String? imgUrl;
  final UserDetailController c;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: Get.width * 0.2,
        width: Get.width * 0.2,
        child: Stack(
          children: [
            GestureDetector(
              onTap: () {
                print('test');
              },
              child: Material(
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
                        : Image.network(
                            AppConstants.CURRENT_BASE_API_URL_IMAGE + imgUrl!,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: () {
                  // update user image function
                  c.selectProfileImage();
                },
                child: CircleAvatar(
                  backgroundColor: Colors.blue[50],
                  radius: AppConstants.DEFAULT_NAV_ICON_SIZE / 1.3,
                  child: Icon(
                    Icons.camera_alt,
                    size: AppConstants.DEFAULT_NAV_ICON_SIZE / 1.2,
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
