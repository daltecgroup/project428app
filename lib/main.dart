import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project428app/app/constants.dart';
import 'package:project428app/app/data/auth_provider.dart';
import 'package:project428app/app/services/operator_service.dart';
import 'app/routes/app_pages.dart';
import 'app/services/auth_service.dart';

void main() async {
  await GetStorage.init();
  Get.put(AuthProvider());
  AuthService authC = Get.put(AuthService(), permanent: true);
  Get.put(OperatorService(), permanent: true);
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    Container(
      color: Colors.black,
      child: Center(
        child: SizedBox(
          width: kMobileWidth,
          child: Obx(
            () => GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: kMainTitle,
              initialRoute: AppPages.INITIAL,
              getPages: AppPages.routes,
              defaultTransition: Transition.noTransition,
              transitionDuration: Duration(milliseconds: 300),
              theme: authC.getThemeByRole(),
            ),
          ),
        ),
      ),
    ),
  );
}
