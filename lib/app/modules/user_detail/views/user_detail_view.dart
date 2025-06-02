import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project428app/app/constants.dart';
import 'package:project428app/app/services/auth_service.dart';
import 'package:project428app/app/services/user_service.dart';
import 'package:project428app/app/widgets/alert_dialog.dart';
import 'package:project428app/app/widgets/confirmation_dialog.dart';
import 'package:project428app/app/widgets/status_sign.dart';
import 'package:project428app/app/widgets/text_header.dart';
import 'package:project428app/app/widgets/user_roles.dart';

import '../../../style.dart';
import '../controllers/user_detail_controller.dart';

class UserDetailView extends GetView<DetailPenggunaController> {
  const UserDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    AuthService internetC = Get.find<AuthService>();
    UserService UserS = Get.find<UserService>();
    GetStorage box = GetStorage();

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
            Get.offNamed('/user');
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              box.read('userProfile')['userId'] ==
                      UserS.currentUser.value!.userId
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
                  : ConfirmationDialog(
                    'Konfirmasi',
                    'Yakin menghapus pengguna ${UserS.currentUser.value!.name}',
                    () {
                      UserS.deleteUser(
                        UserS.currentUser.value!.userId,
                        UserS.currentUser.value!.name,
                      ).then((success) {
                        if (success) {
                          controller.UserC.getUsers();
                          UserS.users.refresh();
                          Get.back();
                          Get.toNamed('/user');
                        } else {
                          Get.back();
                          CustomAlertDialog(
                            'Gagal',
                            'Pengguna ${UserS.currentUser.value!.name} gagal dihapus.',
                          );
                        }
                      });
                    },
                  );
            },
            icon: Obx(
              () => Icon(
                Icons.delete,
                color:
                    box.read('userProfile')['userId'] ==
                            UserS.currentUser.value!.userId
                        ? Colors.grey
                        : Colors.red[900],
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
                height: kMobileWidth * 0.2,
                width: kMobileWidth * 0.2,
                child: Material(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  elevation: 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    child:
                        internetC.isConnected.value? UserS.currentUser.value!.imgUrl != null? 
                             FadeInImage.assetNetwork(
                              placeholder: kAssetLoading,
                              image: UserS.currentUser.value!.imgUrl!,
                            )
                            : CircleAvatar(
                              child: SvgPicture.asset(
                                kImgPlaceholder,
                                fit: BoxFit.cover,
                              ),
                            ): CircleAvatar(
                              child: SvgPicture.asset(
                                kImgPlaceholder,
                                fit: BoxFit.cover,
                              ),)
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              alignment: Alignment.center,
              child: UserRoles(
                role: UserS.currentUser.value!.role,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: SelectableText(
                            '${UserS.currentUser.value!.userId} ${box.read('userProfile')['userId'] == UserS.currentUser.value!.userId ? '(Saya Sendiri)' : ''}',
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(UserS.currentUser.value!.getCreateTime(), overflow: TextOverflow.ellipsis, maxLines: 2, textAlign: TextAlign.end,)),
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
                        Text(UserS.currentUser.value!.name),
                        StatusSign(
                          status: UserS.currentUser.value!.isActive,
                          size: 16,
                        ),
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
                              if (box.read('userProfile')['userId'] ==
                                  UserS.currentUser.value!.userId) {
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
                                if (UserS.currentUser.value != null) {
                                  UserS.currentUser.value!.changeStatus().then((
                                    success,
                                  ) {
                                    if (success) {
                                      UserS.currentUser.refresh();
                                      UserS.getUsers();
                                    }
                                  });
                                }
                              }
                            },
                            style: PrimaryButtonStyle(
                              UserS.currentUser.value!.isActive
                                  ? box.read('userProfile')['userId'] ==
                                          UserS.currentUser.value!.userId
                                      ? Colors.grey
                                      : Colors.red[400]!
                                  : Colors.blue,
                            ),
                            child:
                                UserS.currentUser.value!.isActive
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
