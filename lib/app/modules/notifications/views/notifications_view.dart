import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:project428app/app/shared/widgets/text_header.dart';

import '../controllers/notifications_controller.dart';

class NotificationsView extends GetView<NotificationsController> {
  const NotificationsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: TextHeader(text: 'Notifikasi'), centerTitle: true),
      body: const Center(
        child: Text('Notifikasi kosong', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
