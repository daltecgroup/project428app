import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future CustomAlertDialog(String title, String content) async {
  return Get.defaultDialog(
    title: title,
    titleStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
    radius: 10,
    content: Text(content, style: TextStyle(height: 1.8)),
    cancel: TextButton(
      onPressed: () {
        Get.back();
      },
      child: Text("Tutup"),
    ),
  );
}
