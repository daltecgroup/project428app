import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project428app/app/constants.dart';
import 'package:project428app/app/data/auth_provider.dart';
import 'package:project428app/app/services/personalization_service.dart';
import 'app/routes/app_pages.dart';
import 'app/services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  Personalization c = Get.put(Personalization(), permanent: true);
  Get.put(AuthProvider());
  Get.put(AuthService());
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
              initialRoute:
                  c.isLogin.value
                      ? getCurrentRolePage(c.currentRoleTheme.value)
                      : AppPages.INITIAL,
              getPages: AppPages.routes,
              defaultTransition: Transition.noTransition,
              transitionDuration: Duration(milliseconds: 300),
              theme:
                  c.isDarkMode.value
                      ? ThemeData(
                        fontFamily: 'Poppins',
                        colorScheme: ColorScheme.fromSeed(
                          seedColor: Colors.lightBlueAccent,
                          brightness: Brightness.dark,
                        ),
                      )
                      : c.getThemeByRole(c.currentRoleTheme.string),
            ),
          ),
        ),
      ),
    ),
  );
}

String getCurrentRolePage(String value) {
  String routes = Routes.LOGIN_AS;

  switch (value) {
    case 'franchisee':
      break;
    case 'spvarea':
      break;
    case 'operator':
      routes = Routes.BERANDA_OPERATOR;
      break;
    default:
      routes = Routes.BERANDA_ADMIN;
  }
  return routes;
}
