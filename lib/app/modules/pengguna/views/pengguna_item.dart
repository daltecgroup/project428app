import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:project428app/app/constants.dart';
import 'package:project428app/app/modules/pengguna/controllers/pengguna_controller.dart';
import 'package:project428app/app/services/auth_service.dart';
import 'package:project428app/app/widgets/status_sign.dart';

import '../../../widgets/user_roles.dart';

Widget PenggunaItem(
  String userId,
  String name,
  List role,
  bool status,
  String imgUrl,
  int index,
  String createdAt,
) {
  // imgUrl = "https://i.pravatar.cc/150?img=${index + 1}";
  PenggunaController userC = Get.find<PenggunaController>();
  AuthService internetC = Get.find<AuthService>();

  return Card(
    color: status ? Colors.white : Colors.grey[200],
    margin: const EdgeInsets.only(bottom: 10, left: 15, right: 15),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    child: InkWell(
      onTap: () {
        userC.setCurrentUserDetail(userId);
        Get.toNamed('/detail-pengguna');
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
                  : ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    child:
                        internetC.isConnected.value
                            ? FadeInImage.assetNetwork(
                              placeholder: kAssetLoading,
                              image: imgUrl,
                              // webHtmlElementStrategy: WebHtmlElementStrategy.prefer,
                            )
                            : CircleAvatar(
                              child: SvgPicture.asset(
                                kImgPlaceholder,
                                fit: BoxFit.cover,
                              ),
                            ),
                  ),
          title: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Text(
                    name,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
                StatusSign(status: status, size: 12),
              ],
            ),
          ),
          subtitle: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: UserRoles(
              role: role,
              status: status,
              alignment: MainAxisAlignment.start,
            ),
          ),
        ),
      ),
    ),
  );
}
