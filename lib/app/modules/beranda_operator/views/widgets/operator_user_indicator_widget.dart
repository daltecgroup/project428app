import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project428app/app/constants.dart';
import 'package:project428app/app/modules/beranda_operator/controllers/beranda_operator_controller.dart';

class OperatorUserIndicatorWidget extends StatelessWidget {
  const OperatorUserIndicatorWidget({super.key, required this.controller});

  final BerandaOperatorController controller;

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 1,
      child: ListTile(
        selected: true,
        selectedTileColor: Colors.grey[50],
        contentPadding: EdgeInsets.only(left: 10),
        dense: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        leading: Container(
          height: 30,
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            child: FadeInImage.assetNetwork(
              placeholder: kAssetLoading,
              image: controller.AuthS.box.read('userProfile')['imgUrl'],
              // webHtmlElementStrategy: WebHtmlElementStrategy.prefer,
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
