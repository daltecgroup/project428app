import 'package:abg_pos_app/app/utils/helpers/logger_helper.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'app/routes/app_pages.dart';
import 'app/utils/services/notification_service.dart';
import 'app/utils/services/setting_service.dart';
import 'app/utils/services/connectivity_service.dart';
import 'app/utils/helpers/get_storage_helper.dart';
import 'app/utils/services/auth_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) => LoggerHelper.logInfo('Firebase Initialized'))
      .onError((error, stackTrace) {
        LoggerHelper.logError('Firebase Error: ${error.toString()}');
      });
  await BoxHelper().init();
  await Get.putAsync(() async => SettingService(), permanent: true);
  await Get.putAsync(() async => ConnectivityService(), permanent: true);
  await Get.putAsync(() async => AuthService(), permanent: true);

  // Inisialisasi Service Notifikasi
  final notificationService = NotificationService();
  await notificationService.init();
  Get.put(notificationService); // Masukkan ke memori GetX
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final setting = Get.find<SettingService>();
    return Obx(
      () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Application",
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        defaultTransition: Transition.noTransition,
        theme: setting.currentTheme,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('id')],
      ),
    );
  }
}

//
