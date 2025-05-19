import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:project428app/app/constants.dart';
import 'package:project428app/app/widgets/text_header.dart';

import '../controllers/tambah_pengguna_controller.dart';

class TambahPenggunaView extends GetView<TambahPenggunaController> {
  const TambahPenggunaView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tambah Pengguna',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.close_rounded),
            onPressed: () {
              // Save action
              Get.offNamed('/pengguna');
            },
          ),
          SizedBox(width: 10),
        ],
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Center(child: CircleAvatar(radius: 40)),
                      SizedBox(height: 10),
                      Center(
                        child: TextButton(
                          onPressed: () {
                            // Open file picker
                          },
                          child: Text('Ubah Foto'),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: controller.idController,
                        readOnly: false,
                        decoration: InputDecoration(
                          labelText: 'ID (6 digit  angka)',
                          border: OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.refresh),
                            onPressed: () {
                              controller.generateId();
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextField(
                        controller: controller.nameController,
                        maxLength: 50,
                        inputFormatters: <TextInputFormatter>[
                          LengthLimitingTextInputFormatter(50),
                          FilteringTextInputFormatter.allow(
                            RegExp("[a-zA-Z ]"),
                          ),
                        ],
                        decoration: InputDecoration(
                          labelText: 'Nama Lengkap',
                          border: OutlineInputBorder(),
                          error:
                              controller.errName.value
                                  ? Text(
                                    'Nama tidak boleh kosong',
                                    style: TextStyle(color: Colors.red),
                                  )
                                  : null,
                        ),
                        onChanged: (value) => controller.checkName(),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: controller.pinController,
                              inputFormatters: <TextInputFormatter>[
                                LengthLimitingTextInputFormatter(4),
                                FilteringTextInputFormatter.allow(
                                  RegExp("[0-9]"),
                                ),
                              ],

                              decoration: InputDecoration(
                                labelText: 'PIN (4 digit angka)',
                                border: OutlineInputBorder(),
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.refresh),
                                  onPressed: () {
                                    controller.generatePin();
                                  },
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              value:
                                  controller.status.value ? kAktif : kNonaktif,
                              decoration: InputDecoration(
                                labelText: 'Status',
                                border: OutlineInputBorder(),
                              ),
                              items: [
                                DropdownMenuItem(
                                  value: kAktif,
                                  child: Text('Aktif'),
                                ),
                                DropdownMenuItem(
                                  value: kNonaktif,
                                  child: Text('Non Aktif'),
                                ),
                              ],
                              onChanged: (value) {
                                if (value == kAktif) {
                                  controller.status.value = true;
                                } else {
                                  controller.status.value = false;
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      TextField(
                        controller: controller.phoneController,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                          LengthLimitingTextInputFormatter(15),
                        ],
                        decoration: InputDecoration(
                          labelText: 'No. Telepon',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextTitle(text: 'Peran'),
                      Row(
                        children: [
                          Checkbox(
                            value: controller.isAdmin.value,
                            onChanged: (value) {
                              controller.isAdmin.value = value!;
                              controller.checkPeran();
                            },
                          ),
                          Text('Admin'),
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: controller.isFranchisee.value,
                            onChanged: (value) {
                              controller.isFranchisee.value = value!;
                              controller.checkPeran();
                            },
                          ),
                          Text('Franchisee'),
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: controller.isSVPArea.value,
                            onChanged: (value) {
                              controller.isSVPArea.value = value!;
                              controller.checkPeran();
                            },
                          ),
                          Text('SPV Area'),
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: controller.isOperator.value,
                            onChanged: (value) {
                              controller.isOperator.value = value!;
                              controller.checkPeran();
                            },
                          ),
                          Text('Operator'),
                        ],
                      ),
                      controller.errPeran.value
                          ? Text(
                            'Pilih salah satu peran',
                            style: TextStyle(color: Colors.red),
                          )
                          : SizedBox(),
                      SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.only(
              top: 12,
              left: 12,
              right: 12,
              bottom: 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: TextButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    onPressed: () {
                      Get.offNamed('/pengguna');
                    },
                    child: Text('Kembali', style: TextStyle(fontSize: 16)),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                    ),
                    onPressed: () {
                      // Get.snackbar(
                      //   'Gagal Menyimpan Data',
                      //   "Server tidak merespon",
                      //   margin: EdgeInsets.all(20),
                      //   duration: Duration(seconds: 2),
                      // );
                      controller.submit();
                    },
                    child: Text(
                      'Simpan',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
