import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project428app/app/constants.dart';
import 'package:project428app/app/services/personalization_service.dart';
import 'app/routes/app_pages.dart';

void main() async {
  await GetStorage.init();
  Personalization c = Get.put(Personalization());
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    Container(
      color: Colors.black,
      child: Center(
        child: SizedBox(
          width: kMobileWidth,
          child: Obx(
            () =>
                c.isConnected.value
                    ? GetMaterialApp(
                      debugShowCheckedModeBanner: false,
                      title: kMainTitle,
                      initialRoute: AppPages.INITIAL,
                      getPages: AppPages.routes,
                      defaultTransition: Transition.noTransition,
                      theme:
                          c.isDarkMode.value
                              ? ThemeData(
                                colorScheme: ColorScheme.fromSeed(
                                  seedColor: Colors.lightBlueAccent,
                                  brightness: Brightness.dark,
                                ),
                              )
                              : c.getThemeByRole(c.currentRoleTheme.string),
                    )
                    : MaterialApp(
                      debugShowCheckedModeBanner: false,
                      title: kMainTitle,
                      theme: ThemeData(
                        colorScheme: ColorScheme.fromSeed(
                          seedColor: Colors.lightBlueAccent,
                          brightness: Brightness.light,
                        ),
                      ),
                      home: Scaffold(
                        body: Center(child: Text('No Internet Connection')),
                      ),
                    ),
          ),
        ),
      ),
    ),
  );
}
