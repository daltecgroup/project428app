import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:project428app/app/widgets/custom_textfield_with_error.dart';
import 'package:project428app/app/widgets/text_header.dart';
import '../controllers/user_add_controller.dart';

class UserAddView extends GetView<UserAddController> {
  const UserAddView({super.key});
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
        leading: IconButton(
          onPressed: () {
            Get.offNamed('/user');
          },
          icon: Icon(Icons.arrow_back_rounded),
        ),
      ),
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.symmetric(horizontal: 15),
            children: [
              SizedBox(height: 20),
              Obx(
                () => Card(
                  color: Colors.white,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  margin: EdgeInsets.all(0),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextfieldWithError(
                          title: 'ID Pengguna',
                          controller: controller.idController,
                          suffixIcon: IconButton(
                            icon: Icon(Icons.refresh),
                            onPressed: () {
                              controller.generateId();
                            },
                          ),
                          error: controller.errUserId.value,
                          errorText: 'ID Pengguna tidak boleh kosong',
                          onChanged: (value) => controller.checkId(),
                        ),
                        SizedBox(height: 10),
                        CustomTextfieldWithError(
                          inputFormatter: <TextInputFormatter>[
                            LengthLimitingTextInputFormatter(50),
                            FilteringTextInputFormatter.allow(
                              RegExp("[a-zA-Z ]"),
                            ),
                          ],
                          controller: controller.nameController,
                          title: 'Nama Lengkap',
                          error: controller.errName.value,
                          errorText: 'Nama tidak boleh kosong',
                          onChanged: (value) => controller.checkName(),
                        ),
                        SizedBox(height: 10),
                        CustomTextfieldWithError(
                          controller: controller.pinController,
                          title: 'PIN (4 digit)',
                          error: controller.errPin.value,
                          errorText: 'PIN tidak boleh kosong',
                          inputType: TextInputType.number,
                          inputFormatter: <TextInputFormatter>[
                            LengthLimitingTextInputFormatter(4),
                            FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                          ],
                          suffixIcon: IconButton(
                            icon: Icon(Icons.refresh),
                            onPressed: () {
                              controller.generatePin();
                            },
                          ),
                          onChanged: (value) => controller.checkPin(),
                        ),
                        SizedBox(height: 10),
                        CustomTextfieldWithError(
                          controller: controller.phoneController,
                          title: 'No. Telepon',
                          error: false,
                          errorText: '',
                          inputType: TextInputType.number,
                          inputFormatter: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                            LengthLimitingTextInputFormatter(15),
                          ],
                        ),
                        SizedBox(height: 20),
                        TextTitle(text: 'Peran'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Checkbox(
                                      visualDensity: VisualDensity.compact,
                                      value: controller.isAdmin.value,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
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
                                      visualDensity: VisualDensity.compact,
                                      value: controller.isFranchisee.value,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      onChanged: (value) {
                                        controller.isFranchisee.value = value!;
                                        controller.checkPeran();
                                      },
                                    ),
                                    Text('Franchisee'),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(width: 20),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Checkbox(
                                      visualDensity: VisualDensity.compact,
                                      value: controller.isSVPArea.value,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
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
                                      visualDensity: VisualDensity.compact,
                                      value: controller.isOperator.value,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      onChanged: (value) {
                                        controller.isOperator.value = value!;
                                        controller.checkPeran();
                                      },
                                    ),
                                    Text('Operator'),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        controller.errPeran.value
                            ? Text(
                              'Pilih salah satu peran',
                              style: TextStyle(color: Colors.red),
                            )
                            : SizedBox(),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 100),
            ],
          ),
          Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.only(bottom: 20, left: 15, right: 15),
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
                      backgroundColor: MaterialStateProperty.all(
                        Colors.grey[300],
                      ),
                    ),
                    onPressed: () {
                      Get.offNamed('/user');
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
