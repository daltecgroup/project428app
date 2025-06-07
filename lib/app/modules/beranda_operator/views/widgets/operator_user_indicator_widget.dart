import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:project428app/app/core/constants/constants.dart';
import 'package:project428app/app/modules/beranda_operator/controllers/beranda_operator_controller.dart';
import 'package:project428app/app/services/auth_service.dart';

class OperatorUserIndicatorWidget extends StatelessWidget {
  const OperatorUserIndicatorWidget({super.key, required this.controller});

  final BerandaOperatorController controller;

  @override
  Widget build(BuildContext context) {
    AuthService internetC = Get.find<AuthService>();

    return Material(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 1,
      child: ListTile(
        selected: true,
        selectedTileColor: Colors.grey[50],
        contentPadding: EdgeInsets.only(left: 10),
        dense: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        leading: Obx(
          () => Container(
            height: 30,
            width: 30,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              child:
                  internetC.isConnected.value
                      ? FadeInImage.assetNetwork(
                        placeholder: kAssetLoading,
                        image:
                            controller.AuthS.box.read('userProfile')['imgUrl'],
                        // webHtmlElementStrategy: WebHtmlElementStrategy.prefer,
                      )
                      : CircleAvatar(
                        child: SvgPicture.asset(
                          kImgPlaceholder,
                          fit: BoxFit.cover,
                        ),
                      ),
            ),
          ),
        ),
        title: Text(
          controller.AuthS.box.read('userProfile')['name'],
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
        ),
        // subtitle: Text(
        //   'ID ${controller.AuthS.box.read('userProfile')['userId']}',
        //   style: TextStyle(fontSize: 14),
        // ),
        trailing: TextButton(
          style: ButtonStyle(
            padding: WidgetStatePropertyAll(EdgeInsets.all(10)),
          ),
          onPressed: () {
            Get.offNamed('/login-as');
          },
          child: Icon(Icons.logout),
        ),
      ),
    );
  }
}
