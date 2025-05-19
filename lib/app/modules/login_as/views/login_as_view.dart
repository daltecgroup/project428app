import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:project428app/app/constants.dart';
import 'package:project428app/app/services/personalization_service.dart';
import 'package:project428app/app/style.dart';

import '../controllers/login_as_controller.dart';

class LoginAsView extends GetView<LoginAsController> {
  const LoginAsView({super.key});

  @override
  Widget build(BuildContext context) {
    Personalization c = Get.find<Personalization>();
    return Scaffold(
      body: Center(
        child: Container(
          width: kMobileWidth * 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                kMainTitle,
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 100),
              Text(
                'Selamat datang, ${controller.userdata.name}',
                style: TextStyle(fontSize: 20),
              ),

              const SizedBox(height: 20),
              controller.userdata.role.contains('admin')
                  ? Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: 10),
                    child: ElevatedButton(
                      onPressed: () {
                        // Get.offNamed('/beranda-admin');
                        c.currentRoleTheme.value = 'admin';
                        Get.offNamed('/beranda-admin');
                      },
                      style: PrimaryButtonStyle(Colors.blueAccent),
                      child: Text("Admin"),
                    ),
                  )
                  : SizedBox(),
              controller.userdata.role.contains('franchisee')
                  ? Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: 10),
                    child: ElevatedButton(
                      onPressed: () {
                        c.currentRoleTheme.value = 'franchisee';
                        // Get.offNamed('/beranda-admin');
                      },
                      style: PrimaryButtonStyle(Colors.amber),
                      child: Text("Franchisee"),
                    ),
                  )
                  : SizedBox(),
              controller.userdata.role.contains('spvarea')
                  ? Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: 10),
                    child: ElevatedButton(
                      onPressed: () {
                        c.currentRoleTheme.value = 'spvarea';
                        // Get.offNamed('/beranda-admin');
                      },
                      style: PrimaryButtonStyle(Colors.green),
                      child: Text("SPV Area"),
                    ),
                  )
                  : SizedBox(),
              controller.userdata.role.contains('operator')
                  ? Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: 10),
                    child: ElevatedButton(
                      onPressed: () {
                        c.currentRoleTheme.value = 'operator';
                        Get.offNamed('/beranda-operator');
                      },
                      style: PrimaryButtonStyle(Colors.redAccent),
                      child: Text("Operator"),
                    ),
                  )
                  : SizedBox(),

              TextButton(
                onPressed: () {
                  Get.offNamed('/login');
                },
                child: const Text('Keluar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ButtonStyle roleButtonStyle() {
    return ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50));
  }
}
