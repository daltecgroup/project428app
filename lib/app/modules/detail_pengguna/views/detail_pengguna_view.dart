import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:project428app/app/widgets/text_header.dart';

import '../controllers/detail_pengguna_controller.dart';

class DetailPenggunaView extends GetView<DetailPenggunaController> {
  const DetailPenggunaView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Pengguna'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              // Save action
              Get.back();
            },
          ),
          SizedBox(width: 10),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40),
              Center(
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(
                    controller.imgUrl.value,
                    webHtmlElementStrategy: WebHtmlElementStrategy.prefer,
                  ),
                ),
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextTitle(text: 'ID'),
                  TextTitle(text: 'Dibuat pada'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(controller.userId.value),
                  Text('12 Mei 2025, 118.10 WIB'),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [TextTitle(text: 'Nama'), TextTitle(text: 'Status')],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(controller.name.value),
                  Text(controller.status.value ? 'Aktif' : 'Nonaktif'),
                ],
              ),
              SizedBox(height: 10),
              TextTitle(text: 'Peran'),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  controller.role.contains('admin')
                      ? Text('Admin')
                      : SizedBox(),
                  controller.role.contains('franchisee')
                      ? Text('Franchisee')
                      : SizedBox(),
                  controller.role.contains('spvarea')
                      ? Text('SPV Area')
                      : SizedBox(),
                  controller.role.contains('operator')
                      ? Text('Operator')
                      : SizedBox(),
                ],
              ),
              SizedBox(height: 10),
              Center(
                child: TextButton(onPressed: () {}, child: Text('Ubah Data')),
              ),
              Center(
                child: Obx(
                  () => TextButton(
                    onPressed: () {
                      if (controller.status.value) {
                        controller.deactiveUser();
                      } else {
                        controller.activateUser();
                      }
                    },
                    child: Text(
                      controller.status.value ? 'Nonaktifkan' : 'Aktifkan',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
