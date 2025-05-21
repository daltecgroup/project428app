import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project428app/app/controllers/image_picker_controller.dart';
import 'package:project428app/app/controllers/user_data_controller.dart';
import 'package:project428app/app/data/outlet_provider.dart';
import 'package:project428app/app/modules/gerai/controllers/gerai_controller.dart';
import 'package:project428app/app/modules/gerai/models/outlet_list_item.dart';

import '../../../models/outlet.dart';
import '../../../models/user.dart';
import '../../../style.dart';
import '../../../widgets/text_header.dart';

class OutletDetailController extends GetxController {
  OutletProvider OutletP = OutletProvider();
  ImagePickerController imagePickerC = Get.put(ImagePickerController());
  UserDataController UserDataC = Get.put(UserDataController());
  GeraiController GeraiC = Get.find<GeraiController>();
  RxInt selectedIndex = 0.obs;

  RxBool isOwnerEditable = false.obs;
  RxBool isOperatorEditable = false.obs;

  Rx<Outlet> outlet =
      Outlet(
        '-',
        '-',
        false,
        '',
        {
          'street': '-',
          'village': '',
          'district': '',
          'regency': '',
          'province': '',
        },
        [],
        [],
        DateTime.now(),
        DateTime.now(),
        DateTime.now(),
      ).obs;

  @override
  Future<void> onInit() async {
    await OutletP.getOutletById((Get.arguments as OutletListItem).code).then((
      res,
    ) {
      outlet.value = Outlet.fromJson(res.body);
    });
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getOutlet() {
    OutletP.getOutletById(outlet.value.code).then((res) {
      outlet.value = Outlet.fromJson(res.body);
    });
  }

  void toggleStatus() {
    if (outlet.value.isActive) {
      OutletP.deactivateOutlet(outlet.value.code).then((res) {
        getOutlet();
        GeraiC.getOutletList();
      });
    } else {
      OutletP.reactivateOutlet(outlet.value.code).then((res) {
        getOutlet();
        GeraiC.getOutletList();
      });
    }
  }

  Future<void> updateOwnership(List newOwners, bool back) async {
    await OutletP.updateOutlet(outlet.value.code, {'owner': newOwners}).then((
      res,
    ) {
      outlet.value = Outlet.fromJson(res.body);
      if (back) {
        Get.back();
      }
    });
  }

  Future<void> updateOperator(List newOperator, bool back) async {
    await OutletP.updateOutlet(outlet.value.code, {
      'operator': newOperator,
    }).then((res) {
      outlet.value = Outlet.fromJson(res.body);
      if (back) {
        Get.back();
      }
    });
  }

  Future<void> updateImage() async {
    if (imagePickerC.selectedImage.value != null) {
      await OutletP.updateOutletImage(
        outlet.value.code,
        imagePickerC.selectedImage.value!,
      ).then((res) {
        print(res.body);
        outlet.value = Outlet.fromJson(res.body);
        GeraiC.getOutletList();
      });
    } else {
      Get.defaultDialog(
        backgroundColor: Colors.white,
        title: "Peringatan",
        titleStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        radius: 8,
        content: Text('Gambar belum dipilih'),
      );
    }
  }

  void deletePersonFromOutlet(String role, String id) {
    List newList = [];

    switch (role) {
      case 'franchisee':
        for (var e in outlet.value.owner) {
          if (e['_id'] != id) {
            newList.add(e['_id']);
          }
        }
        updateOwnership(newList, false);
        break;
      default:
        for (var e in outlet.value.operator) {
          if (e['_id'] != id) {
            newList.add(e['_id']);
          }
        }
        updateOperator(newList, false);
    }
  }

  void addPersonToOutlet(String role) {
    var exceptions = [];
    var title = "";

    switch (role) {
      case 'franchisee':
        for (var e in outlet.value.owner) {
          exceptions.add(e['_id'].toString());
        }
        title = 'Tambah Pemilik';
        break;
      default:
        for (var e in outlet.value.operator) {
          exceptions.add(e['_id'].toString());
        }
        title = 'Tambah Operator';
    }

    List<User> userList = UserDataC.getUserByRole(role, exceptions);
    exceptions = exceptions.toSet().toList();

    if (userList.isNotEmpty) {
      String selectedUserId = userList.first.id;
      Get.defaultDialog(
        backgroundColor: Colors.white,
        title: title,
        titleStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        radius: 8,
        content: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextTitle(
                text: role == 'spvarea' ? 'SPV Area' : role.capitalize!,
              ),
              SizedBox(height: 5),
              Material(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: DropdownButtonFormField<String>(
                  value: userList.first.id,
                  decoration: TextFieldDecoration1(),
                  items: [
                    ...List.generate(
                      userList.length,
                      (index) => DropdownMenuItem(
                        value: userList[index].id,
                        child: Text(userList[index].name),
                        onTap:
                            () =>
                                selectedUserId =
                                    UserDataC.getUserByRole(
                                      role,
                                      exceptions,
                                    )[index].id,
                      ),
                    ),
                  ],
                  onChanged: (value) {
                    selectedUserId = value!;
                  },
                ),
              ),
            ],
          ),
        ),
        confirm: TextButton(
          onPressed: () async {
            exceptions.add(selectedUserId);
            switch (role) {
              case 'franchisee':
                await updateOwnership(exceptions, true);

                break;
              default:
                await updateOperator(exceptions, true);
            }
          },
          child: Text("Simpan"),
        ),
        cancel: TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text("Batal"),
        ),
      );
    } else {
      Get.defaultDialog(
        backgroundColor: Colors.white,
        title: "Peringatan",
        titleStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        radius: 8,
        content: Text(
          '${role == 'spvarea' ? 'SPV Area' : role.capitalize!} lain tidak ditemukan',
        ),
      );
    }
  }

  Future<void> deleteOutlet() async {
    Get.defaultDialog(
      title: "Konfirmasi",
      content: Text("Yakin menghapus ${outlet.value.name}?"),
      confirm: TextButton(
        onPressed: () async {
          await OutletP.deleteOutlet(outlet.value.code).then((res) {
            GeraiC.getOutletList();
            Get.back();
            Get.offNamed('/gerai');
          });
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
}
