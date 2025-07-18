import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../routes/app_pages.dart';
import '../../../../data/models/User.dart';
import '../../../../shared/user_roles.dart';
import '../../../../shared/status_sign.dart';
import '../../../../utils/theme/custom_text.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../controllers/user_data_controller.dart';

Widget userListItem(User user) {
  UserDataController userData = Get.find<UserDataController>();

  return Card(
    color: user.isActive ? Colors.white : Colors.grey[200],
    margin: const EdgeInsets.only(
      bottom: 10,
      left: AppConstants.DEFAULT_PADDING,
      right: AppConstants.DEFAULT_PADDING,
    ),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    child: InkWell(
      onTap: () {
        userData.selectedUser.value = user;
        Get.toNamed(Routes.USER_DETAIL);
      },
      child: ListTile(
        contentPadding: EdgeInsets.only(left: 12, right: 12, bottom: 5, top: 0),
        leading: CircleAvatar(
          backgroundImage: AssetImage(AppConstants.PROFILE_PLACEHOLDER_PNG),
        ),
        title: Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(flex: 5, child: customListTitleText(text: user.name)),
              StatusSign(
                status: user.isActive,
                size: AppConstants.DEFAULT_FONT_SIZE.toInt(),
              ),
            ],
          ),
        ),
        subtitle: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: UserRoles(
            role: user.roles,
            status: user.isActive,
            alignment: MainAxisAlignment.start,
          ),
        ),
      ),
    ),
  );
}
