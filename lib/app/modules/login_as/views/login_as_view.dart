import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:project428app/app/constants.dart';
import 'package:project428app/app/style.dart';
import 'package:project428app/app/widgets/app_logo_title_widget.dart';
import 'package:project428app/app/widgets/text_header.dart';

import '../controllers/login_as_controller.dart';

class LoginAsView extends GetView<LoginAsController> {
  const LoginAsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: primaryYellow,
        child: Stack(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 100),
                child: AppLogoTitleWidget(),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 100),
                Hero(
                  tag: 'login-to-select-role',
                  child: Card(
                    color: Colors.white,
                    elevation: 1,
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 15,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Material(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              elevation: 1,
                              child: ListTile(
                                selected: true,
                                selectedTileColor: Colors.grey[50],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                leading:
                                    GetPlatform.isWeb
                                        ? CircleAvatar()
                                        : ClipRRect(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(30),
                                          ),
                                          child:
                                              controller.AuthS.isConnected.value
                                                  ? FadeInImage.assetNetwork(
                                                    placeholder: kAssetLoading,
                                                    image:
                                                        controller.AuthS.box
                                                            .read(
                                                              'userProfile',
                                                            )['imgUrl'],
                                                    // webHtmlElementStrategy: WebHtmlElementStrategy.prefer,
                                                  )
                                                  : CircleAvatar(
                                                    child: SvgPicture.asset(
                                                      kImgPlaceholder,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                        ),
                                title: Text(
                                  controller.AuthS.box.read(
                                    'userProfile',
                                  )['name'],
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                                subtitle: Text(
                                  'ID ${controller.AuthS.box.read('userProfile')['userId']}',
                                  style: TextStyle(fontSize: 14),
                                ),
                                // trailing: IconButton(
                                //   color: Colors.blue[700],
                                //   style: ButtonStyle(
                                //     padding: WidgetStatePropertyAll(
                                //       EdgeInsets.all(10),
                                //     ),
                                //     backgroundColor: WidgetStatePropertyAll(
                                //       Colors.blue[50],
                                //     ),
                                //   ),
                                //   onPressed: () {
                                //     Get.offNamed('/login');
                                //   },
                                //   icon: Icon(Icons.logout_rounded),
                                // ),
                              ),
                            ),

                            const SizedBox(height: 20),
                            TextTitle(text: 'Masuk sebagai:'),
                            const SizedBox(height: 5),
                            controller.AuthS.userRoles.contains('admin')
                                ? Container(
                                  width: double.infinity,
                                  height: 40,
                                  margin: EdgeInsets.only(bottom: 10),
                                  child: TextButton(
                                    onPressed: () {
                                      // Get.offNamed('/beranda-admin');
                                      controller.AuthS.currentRoleTheme.value =
                                          'admin';
                                      Get.offNamed('/beranda-admin');
                                    },
                                    style: LoginAsButtonStyle(
                                      Colors.blueAccent,
                                    ),
                                    child: Text("Admin"),
                                  ),
                                )
                                : SizedBox(),
                            controller.AuthS.userRoles.contains('franchisee')
                                ? Container(
                                  width: double.infinity,
                                  height: 40,
                                  margin: EdgeInsets.only(bottom: 10),
                                  child: TextButton(
                                    onPressed: () {
                                      controller.AuthS.currentRoleTheme.value =
                                          'franchisee';
                                      Get.offNamed('/homepage-franchisee');
                                    },
                                    style: LoginAsButtonStyle(
                                      Colors.amber[800]!,
                                    ),
                                    child: Text("Franchisee"),
                                  ),
                                )
                                : SizedBox(),
                            controller.AuthS.userRoles.contains('spvarea')
                                ? Container(
                                  width: double.infinity,
                                  height: 40,
                                  margin: EdgeInsets.only(bottom: 10),
                                  child: TextButton(
                                    onPressed: () {
                                      controller.AuthS.currentRoleTheme.value =
                                          'spvarea';
                                      Get.offNamed('/homepage-spvarea');
                                      // Get.offNamed('/beranda-admin');
                                    },
                                    style: LoginAsButtonStyle(Colors.green),
                                    child: Text("SPV Area"),
                                  ),
                                )
                                : SizedBox(),
                            controller.AuthS.userRoles.contains('operator')
                                ? Container(
                                  width: double.infinity,
                                  height: 40,
                                  margin: EdgeInsets.only(bottom: 10),
                                  child: TextButton(
                                    onPressed: () {
                                      controller.loginAsOperator();
                                    },
                                    style: LoginAsButtonStyle(Colors.redAccent),
                                    child: Text("Operator"),
                                  ),
                                )
                                : SizedBox(),
                            TextButton(
                              onPressed: () {
                                controller.AuthS.currentRoleTheme.value =
                                    'operator';
                                controller.AuthS.logout();
                              },
                              child: Text("Logout"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                // SizedBox(height: 200),
              ],
            ),
          ],
        ),
      ),
    );
  }

  ButtonStyle roleButtonStyle() {
    return ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50));
  }
}
