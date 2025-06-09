import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project428app/app/core/constants/constants.dart';
import 'package:project428app/app/data/providers/auth_provider.dart';
import 'package:project428app/app/services/attendance_service.dart';
import 'package:project428app/app/services/operator_service.dart';
import 'package:project428app/app/services/order_service.dart';
import 'package:project428app/app/services/outlet_service.dart';
import 'package:project428app/app/services/user_service.dart';
import 'package:window_manager/window_manager.dart';
import 'app/routes/app_pages.dart';
import 'app/services/auth_service.dart';
import 'app/services/stock_service.dart';

void main() async {
  await GetStorage.init();
  Get.put(AuthProvider());
  AuthService authC = Get.put(AuthService(), permanent: true);
  Get.put(StockService(), permanent: true);
  Get.put(UserService(), permanent: true);
  Get.put(OutletService(), permanent: true);
  Get.put(OrderService(), permanent: true);
  Get.put(OperatorService(), permanent: true);
  Get.put(AttendanceService(), permanent: true);
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    WindowOptions windowOptions = WindowOptions(
      size: Size(kMobileWidth, 800), // Initial window size
      minimumSize: Size(
        kMobileWidth,
        800,
      ), // Set your desired minimum width and height
      maximumSize: Size(kMobileWidth, 800),
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      titleBarStyle:
          TitleBarStyle
              .normal, // Or TitleBarStyle.hidden for a custom title bar
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    await windowManager.ensureInitialized();
    });
  }

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
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('en', ''),
                Locale('id', ''),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
