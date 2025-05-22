import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:project428app/app/constants.dart';
import 'package:project428app/app/services/personalization_service.dart';
import 'package:project428app/app/style.dart';
import 'package:project428app/app/widgets/app_logo_title_widget.dart';

import '../controllers/login_as_controller.dart';

class LoginAsView extends GetView<LoginAsController> {
  const LoginAsView({super.key});

  @override
  Widget build(BuildContext context) {
    Personalization c = Get.find<Personalization>();
    return Scaffold(
      body: Stack(
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
                              leading: ClipRRect(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30),
                                ),
                                child: FadeInImage.assetNetwork(
                                  placeholder: kAssetLoading,
                                  image: controller.userdata.imgUrl,
                                  // webHtmlElementStrategy: WebHtmlElementStrategy.prefer,
                                ),
                              ),
                              title: Text(
                                controller.userdata.name,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                ),
                              ),
                              subtitle: Text(
                                'ID ${controller.userdata.userId}',
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
                          controller.userdata.role.contains('admin')
                              ? Container(
                                width: double.infinity,
                                height: 40,
                                margin: EdgeInsets.only(bottom: 10),
                                child: TextButton(
                                  onPressed: () {
                                    // Get.offNamed('/beranda-admin');
                                    c.currentRoleTheme.value = 'admin';
                                    Get.offNamed('/beranda-admin');
                                  },
                                  style: LoginAsButtonStyle(Colors.blueAccent),
                                  child: Text("Admin"),
                                ),
                              )
                              : SizedBox(),
                          controller.userdata.role.contains('franchisee')
                              ? Container(
                                width: double.infinity,
                                height: 40,
                                margin: EdgeInsets.only(bottom: 10),
                                child: TextButton(
                                  onPressed: () {
                                    c.currentRoleTheme.value = 'franchisee';
                                    // Get.offNamed('/beranda-admin');
                                  },
                                  style: LoginAsButtonStyle(Colors.amber[800]!),
                                  child: Text("Franchisee"),
                                ),
                              )
                              : SizedBox(),
                          controller.userdata.role.contains('spvarea')
                              ? Container(
                                width: double.infinity,
                                height: 40,
                                margin: EdgeInsets.only(bottom: 10),
                                child: TextButton(
                                  onPressed: () {
                                    c.currentRoleTheme.value = 'spvarea';
                                    // Get.offNamed('/beranda-admin');
                                  },
                                  style: LoginAsButtonStyle(Colors.green),
                                  child: Text("SPV Area"),
                                ),
                              )
                              : SizedBox(),
                          controller.userdata.role.contains('operator')
                              ? Container(
                                width: double.infinity,
                                height: 40,
                                margin: EdgeInsets.only(bottom: 10),
                                child: TextButton(
                                  onPressed: () {
                                    c.currentRoleTheme.value = 'operator';
                                    Get.offNamed('/beranda-operator');
                                  },
                                  style: LoginAsButtonStyle(Colors.redAccent),
                                  child: Text("Operator"),
                                ),
                              )
                              : SizedBox(),
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
    );
  }

  ButtonStyle roleButtonStyle() {
    return ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50));
  }
}
