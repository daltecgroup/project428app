import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future CustomAlertDialogWithWidget(String title, Widget content) async {
  return Get.defaultDialog(
    title: title,
    titleStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
    radius: 10,
    content: content,
    cancel: TextButton(
      onPressed: () {
        Get.back();
      },
      child: Text("Tutup"),
    ),
  );
}
