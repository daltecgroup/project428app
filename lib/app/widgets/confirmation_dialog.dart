import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future ConfirmationDialog(
  String title,
  String content,
  VoidCallback? confirm,
) async {
  return Get.defaultDialog(
    title: title,
    titleStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
    radius: 10,
    content: Text(
      content,
      style: TextStyle(height: 1.8),
      textAlign: TextAlign.center,
    ),
    confirm: TextButton(
      onPressed:
          confirm ??
          () {
            Get.back();
          },
      child: Text("Yakin"),
    ),
    cancel: TextButton(
      onPressed: () {
        Get.back();
      },
      child: Text("Batal"),
    ),
  );
}
