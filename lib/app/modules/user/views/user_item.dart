import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project428app/app/services/user_service.dart';
import 'package:project428app/app/widgets/status_sign.dart';
import 'package:project428app/app/widgets/users/user_profile_avatar_widget.dart';

import '../../../models/user.dart';
import '../../../widgets/users/user_roles.dart';

Widget UserItem(User user) {
  UserService UserS = Get.find<UserService>();

  return Card(
    color: user.isActive ? Colors.white : Colors.grey[200],
    margin: const EdgeInsets.only(bottom: 10, left: 15, right: 15),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    child: InkWell(
      onTap: () {
        UserS.currentUser.value = user;
        Get.toNamed('/user-detail');
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
        child: ListTile(
          contentPadding: EdgeInsets.only(
            left: 12,
            right: 12,
            bottom: 5,
            top: 0,
          ),
          leading:
              GetPlatform.isWeb
                  ? CircleAvatar()
                  : UserProfileAvatarWidget(user: user),
          title: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Text(
                    user.name,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
                StatusSign(status: user.isActive, size: 12),
              ],
            ),
          ),
          subtitle: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: UserRoles(
              role: user.role,
              status: user.isActive,
              alignment: MainAxisAlignment.start,
            ),
          ),
        ),
      ),
    ),
  );
}
