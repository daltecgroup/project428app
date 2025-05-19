import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:project428app/app/constants.dart';
import 'package:project428app/app/widgets/format_waktu.dart';
import 'package:project428app/app/widgets/status_sign.dart';
import 'package:project428app/app/widgets/text_header.dart';
import 'package:project428app/app/widgets/user_roles.dart';

import '../../../style.dart';
import '../controllers/detail_pengguna_controller.dart';

class DetailPenggunaView extends GetView<DetailPenggunaController> {
  const DetailPenggunaView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail Pengguna',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () {
            // Save action
            Get.offNamed('/pengguna');
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              controller.myOwn.value
                  ? Get.defaultDialog(
                    title: "Peringatan",
                    content: Text("Tidak dapat menghapus diri sendiri"),

                    cancel: TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text("Batal"),
                    ),
                  )
                  : Get.defaultDialog(
                    title: "Konfirmasi",
                    content: Text("Yakin menghapus pengguna?"),
                    confirm: TextButton(
                      onPressed: () {
                        controller.deleteUser();
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
            },
            icon: Obx(
              () => Icon(
                Icons.delete,
                color: controller.myOwn.value ? Colors.grey : Colors.red[900],
              ),
            ),
          ),
        ],
      ),
      body: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40),
            Center(
              child: Container(
                height: Get.width * 0.2,
                width: Get.width * 0.2,
                child: Material(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  elevation: 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    child: FadeInImage.assetNetwork(
                      placeholder: kAssetLoading,
                      image: controller.imgUrl.value,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              alignment: Alignment.center,
              child: UserRoles(
                role: controller.role,
                status: true,
                alignment: MainAxisAlignment.center,
              ),
            ),
            SizedBox(height: 20),
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextTitle(text: 'ID'),
                        TextTitle(text: 'Dibuat'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SelectableText(
                          '${controller.userId.value} ${controller.myOwn.value ? '(Saya Sendiri)' : ''}',
                        ),
                        Text(FormatToLocalDate(controller.createdAt.value)),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextTitle(text: 'Nama'),
                        TextTitle(text: 'Status'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(controller.name.value),
                        StatusSign(status: controller.status.value, size: 16),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              Get.toNamed('/ubah-pengguna');
                            },
                            style: PrimaryButtonStyle(Colors.blue),
                            child: Text('Ubah Data'),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              if (controller.myOwn.value) {
                                Get.defaultDialog(
                                  title: "Peringatan",
                                  content: Text(
                                    "Tidak dapat menonaktifkan diri sendiri",
                                  ),

                                  cancel: TextButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: Text("Batal"),
                                  ),
                                );
                              } else {
                                if (controller.status.value) {
                                  controller.deactiveUser();
                                } else {
                                  controller.activateUser();
                                }
                              }
                            },
                            style: PrimaryButtonStyle(
                              controller.status.value
                                  ? controller.myOwn.value
                                      ? Colors.grey
                                      : Colors.red[400]!
                                  : Colors.blue,
                            ),
                            child:
                                controller.status.value
                                    ? Text('Nonaktifkan')
                                    : Text('Aktifkan'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Buttons
          ],
        ),
      ),
    );
  }
}
