import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:project428app/app/core/constants/constants.dart';
import 'package:project428app/app/data/models/user.dart';
import 'package:project428app/app/services/auth_service.dart';

class UserProfileAvatarWidget extends StatelessWidget {
  const UserProfileAvatarWidget({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    final AuthService AuthS = Get.find<AuthService>();
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(30)),
      child:
          AuthS.isConnected.value
              ? user.imgUrl != null
                  ? Container(
                    height: 50,
                    width: 50,
                    child: FadeInImage.assetNetwork(
                      fit: BoxFit.cover,
                      placeholder: kAssetLoading,
                      image:
                          '${AuthS.mainServerUrl.value}/api/v1/uploads/${user.imgUrl!}',
                      // '${AuthS.mainServerUrl.value}/api/v1/${user.imgUrl}',
                    ),
                  )
                  : Container(
                    height: 50,
                    width: 50,
                    child: SvgPicture.asset(kImgPlaceholder, fit: BoxFit.cover),
                  )
              : Container(
                height: 50,
                width: 50,
                child: SvgPicture.asset(kImgPlaceholder, fit: BoxFit.cover),
              ),
    );
  }
}
