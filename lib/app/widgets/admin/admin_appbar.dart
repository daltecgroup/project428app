import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project428app/app/widgets/text_header.dart';

PreferredSizeWidget AdminAppBar(BuildContext context, String title) {
  return AppBar(
    title: TextHeader(text: title),
    centerTitle: true,
    automaticallyImplyLeading: false,
    leading: Builder(
      builder: (context) {
        return IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        );
      },
    ),
    actions: [
      IconButton(
        icon: Stack(
          children: <Widget>[
            Icon(Icons.notifications),
            Positioned(top: 0.0, right: 0.0, child: Badge(label: Text("1"))),
          ],
        ),
        onPressed: () {
          Get.toNamed('/notifications');
        },
      ),
    ],
  );
}
