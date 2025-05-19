import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project428app/app/constants.dart';
import 'package:project428app/app/services/personalization_service.dart';
import 'app/routes/app_pages.dart';

void main() async {
  await GetStorage.init();
  Personalization c = Get.put(Personalization(), permanent: true);
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
                    ? ConnectedPage(c: c)
                    : NotConnectedPage(c: c),
          ),
        ),
      ),
    ),
  );
}

class NotConnectedPage extends StatelessWidget {
  const NotConnectedPage({super.key, required this.c});

  final Personalization c;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: kMainTitle,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.lightBlueAccent,
          brightness: Brightness.light,
        ),
      ),
      home: Scaffold(
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
                Text('No Internet Connection', style: TextStyle(fontSize: 20)),
                const SizedBox(height: 20),
                Text(
                  'Please check your internet connection and try again.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    c.checkConnection();
                  },
                  child: Text('Retry'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ConnectedPage extends StatelessWidget {
  const ConnectedPage({super.key, required this.c});

  final Personalization c;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: kMainTitle,
      initialRoute: c.isLogin.value ? getCurrentRolePage : AppPages.INITIAL,
      getPages: AppPages.routes,
      defaultTransition: Transition.noTransition,
      transitionDuration: Duration(milliseconds: 150),
      theme:
          c.isDarkMode.value
              ? ThemeData(
                colorScheme: ColorScheme.fromSeed(
                  seedColor: Colors.lightBlueAccent,
                  brightness: Brightness.dark,
                ),
              )
              : c.getThemeByRole(c.currentRoleTheme.string),
    );
  }

  String get getCurrentRolePage {
    String routes = Routes.LOGIN_AS;

    switch (c.currentRoleTheme.value) {
      case 'admin':
        routes = Routes.BERANDA_ADMIN;
        break;
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
}
