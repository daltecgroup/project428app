import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:project428app/app/data/providers/auth_provider.dart';

class AuthService extends GetxService {
  // final _secureStorage = const FlutterSecureStorage();
  final box = GetStorage();
  late final AuthProvider _authP;

  List<String> serverList = [
    'http://localhost:8000',
    // 'http://192.168.1.15:8000',
    // 'http://46.202.163.60:8000',
    // 'http://192.168.0.106:8000',
    // 'http://10.0.2.2:8000',
    // 'https://api.aromabisnisgroup.com',
  ];

  // RxString mainServerUrl = 'https://api.aromabisnisgroup.com'.obs;
  // RxString mainServerUrl = 'http://46.202.163.60:8000'.obs;
  RxString mainServerUrl = 'http://localhost:8000'.obs;
  // RxString mainServerUrl = 'http://10.0.2.2:8000'.obs;
  // RxString mainServerUrl = 'http://192.168.0.106:8000'.obs;
  // RxString mainServerUrl = 'http://192.168.1.15:8000'.obs;

  final connectionChecker = InternetConnectionChecker.createInstance(
    addresses: [
      AddressCheckOption(
        uri: Uri.parse('https://api.aromabisnisgroup.com/api/v1/health'),
      ),
      AddressCheckOption(
        uri: Uri.parse('https://46.202.163.60:8000/api/v1/health'),
      ),
      AddressCheckOption(uri: Uri.parse('https://google.com')),
    ],
  );

  RxString accessToken = ''.obs;
  RxString refreshToken = ''.obs;
  RxBool isLoggedIn = false.obs;
  RxBool isConnected = false.obs;
  RxList<String> userRoles = <String>[].obs;

  RxString currentRoleTheme = 'admin'.obs;

  @override
  void onInit() {
    super.onInit();
    _authP = Get.find<AuthProvider>();

    _initAuth();

    if (box.read('currentRole') == null) {
      box.write('currentRole', 'admin');
    } else {
      currentRoleTheme.value = box.read('currentRole');
    }

    getThemeByRole();

    checkInternetConnection();

    connectionChecker.onStatusChange.listen((status) async {
      if (status == InternetConnectionStatus.connected) {
        print('Connected to the internet');
        isConnected.value = true;
        mainServerUrl.value = await getFirstWorkingUrl();
      } else {
        print('No internet connection');
        isConnected.value = false;
      }
    });
  }

  // fuction to check internet connection
  Future<bool> checkInternetConnection() async {
    isConnected.value = await connectionChecker.hasConnection;
    if (isConnected.value) {
      mainServerUrl.value = await getFirstWorkingUrl();
    }
    return isConnected.value;
  }

  Future<void> _initAuth() async {
    await GetStorage.init();
    final storedAccessToken = await box.read('accessToken');
    final storedRefreshToken = await box.read('refreshToken');

    if (storedAccessToken != null && storedRefreshToken != null) {
      accessToken.value = storedAccessToken;
      refreshToken.value = storedRefreshToken;
      // Set the tokens to the ApiClient's httpClient for immediate use
      _authP.httpClient.addRequestModifier<dynamic>((request) async {
        if (!request.url.path.contains('/auth/login') &&
            !request.url.path.contains('/auth/refresh')) {
          request.headers['Authorization'] = 'Bearer ${accessToken.value}';
        }
        return request;
      });
      await checkAndRefreshToken();
    }

    updateLoginStatus();
  }

  Future<void> login(String userId, String pin) async {
    try {
      final response = await _authP.setBaseUrl(mainServerUrl.value).post(
        '/auth/login', // Relative path to baseUrl
        {'userId': userId, 'pin': pin},
      );

      if (response.statusCode == 200) {
        final data = response.body;

        final newAccessToken = data['accessToken'];
        final newRefreshToken = data['refreshToken'];
        final userProfile = data['user'];

        await box.write('accessToken', newAccessToken);
        await box.write('refreshToken', newRefreshToken);
        box.write('userProfile', userProfile);

        accessToken.value = newAccessToken;
        refreshToken.value = newRefreshToken;

        // Immediately update ApiClient's headers with the new token
        _authP.httpClient.addRequestModifier<dynamic>((request) async {
          if (!request.url.path.contains('/auth/login') &&
              !request.url.path.contains('/auth/refresh')) {
            request.headers['Authorization'] = 'Bearer ${accessToken.value}';
          }
          return request;
        });

        updateLoginStatus();
        if (userRoles.length > 1) {
          Get.offAllNamed('/login-as');
        } else {
          switch (userRoles[0]) {
            case 'admin':
              Get.offAllNamed('/beranda-admin');

              break;
            case 'franchisee':
              Get.offAllNamed('/homepage-franchisee');
              break;
            case 'spvarea':
              Get.offAllNamed('/homepage-spvarea');
              break;
            case 'operator':
              Get.offAllNamed('/beranda-operator');
              break;
            default:
              Get.offAllNamed('/login-as');
          }
        }
      } else {
        print(response.body);
        Get.snackbar(
          'Login Failed',
          response.statusText ?? 'Invalid credentials',
        );
      }
    } catch (e) {
      print('Login error: $e');
      Get.snackbar('Login Error', 'An error occurred during login');
    }
  }

  Future<void> logout() async {
    await box.remove('accessToken');
    await box.remove('refreshToken');
    box.remove('userProfile');
    accessToken.value = '';
    refreshToken.value = '';
    userRoles.clear();
    isLoggedIn.value = false;
    Get.offAllNamed('/login');
  }

  Future<bool> checkAndRefreshToken() async {
    if (accessToken.value.isEmpty || refreshToken.value.isEmpty) {
      return false;
    }

    final decodedToken = JwtDecoder.decode(accessToken.value);
    final expirationTime = DateTime.fromMillisecondsSinceEpoch(
      decodedToken['exp'] * 1000,
    );

    if (expirationTime.isBefore(
      DateTime.now().subtract(const Duration(minutes: 5)),
    )) {
      print('Access token expired, attempting to refresh...');
      try {
        final response = await _authP.setBaseUrl(mainServerUrl.value).post(
          '/auth/refresh',
          {'refreshToken': refreshToken.value},
        );

        if (response.statusCode == 200) {
          final data = response.body;
          final newAccessToken = data['accessToken'];
          final newRefreshToken = data['refreshToken'];

          await box.write('accessToken', newAccessToken);
          await box.write('refreshToken', newRefreshToken);
          accessToken.value = newAccessToken;
          refreshToken.value = newRefreshToken;

          // Update ApiClient's headers with the new token after successful refresh
          _authP.httpClient.addRequestModifier<dynamic>((request) async {
            if (!request.url.path.contains('/auth/login') &&
                !request.url.path.contains('/auth/refresh')) {
              request.headers['Authorization'] = 'Bearer ${accessToken.value}';
            }
            return request;
          });

          updateLoginStatus();
          print('Token refreshed successfully!');
          return true;
        } else {
          print(
            'Failed to refresh token: ${response.statusCode}, ${response.statusText}',
          );
          await logout();
          return false;
        }
      } catch (e) {
        print('Error refreshing token: $e');
        await logout();
        return false;
      }
    } else {
      updateLoginStatus();
      return true;
    }
  }

  void updateLoginStatus() {
    if (accessToken.value.isNotEmpty) {
      try {
        final decodedToken = JwtDecoder.decode(accessToken.value);
        final expirationTime = DateTime.fromMillisecondsSinceEpoch(
          decodedToken['exp'] * 1000,
        );

        if (expirationTime.isAfter(DateTime.now())) {
          isLoggedIn.value = true;
          if (decodedToken.containsKey('role')) {
            var rolesData = decodedToken['role'];
            if (rolesData is List) {
              userRoles.value = List<String>.from(rolesData);
            } else if (rolesData is String) {
              userRoles.value =
                  rolesData.split(',').map((e) => e.trim()).toList();
            }
          }
        } else {
          isLoggedIn.value = false;
          userRoles.clear();
        }
      } catch (e) {
        // Handle malformed JWT or other decoding errors
        print('Error decoding access token: $e');
        isLoggedIn.value = false;
        userRoles.clear();
      }
    } else {
      isLoggedIn.value = false;
      userRoles.clear();
    }
  }

  bool hasRole(String role) {
    return userRoles.contains(role);
  }

  bool hasAnyRole(List<String> roles) {
    return roles.any((role) => userRoles.contains(role));
  }

  ThemeData getThemeByRole() {
    var selectedColor = Colors.lightBlueAccent;
    switch (currentRoleTheme.value) {
      case 'admin':
        selectedColor = Colors.lightBlueAccent;
        break;
      case 'franchisee':
        selectedColor = Colors.amberAccent;
        break;
      case 'spvarea':
        selectedColor = Colors.greenAccent;
        break;
      case 'operator':
        selectedColor = Colors.redAccent;
        break;
      default:
        selectedColor = Colors.blueAccent;
    }

    return ThemeData(
      fontFamily: 'Poppins',
      colorScheme: ColorScheme.fromSeed(
        seedColor: selectedColor,
        brightness: Brightness.light,
      ),
    );
  }

  Future<bool> _isUrlLive(
    String url, {
    Duration timeoutDuration = const Duration(seconds: 3),
  }) async {
    try {
      // Using http.head for a lighter check, as we only care about reachability
      final response = await http
          .head(Uri.parse('$url/api/v1/health'))
          .timeout(timeoutDuration);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        debugPrint('URL $url is LIVE. Status: ${response.statusCode}');
        return true;
      } else {
        debugPrint('URL $url responded with status: ${response.statusCode}');
        return false;
      }
    } on http.ClientException catch (e) {
      debugPrint('Client error checking URL $url: ${e.message}');
      return false;
    } on Exception catch (e) {
      debugPrint('Error checking URL $url: $e');
      return false;
    }
  }

  Future<String> getFirstWorkingUrl({
    Duration timeoutPerUrl = const Duration(seconds: 3),
  }) async {
    bool isLive = await _isUrlLive(
      mainServerUrl.value,
      timeoutDuration: timeoutPerUrl,
    );

    if (isLive) return mainServerUrl.value;

    if (serverList.isEmpty) {
      debugPrint('URL list is empty. No working URL can be found.');
      return mainServerUrl.value;
    }

    for (String url in serverList) {
      debugPrint('Attempting to check: $url');
      bool isLive = await _isUrlLive(url, timeoutDuration: timeoutPerUrl);
      if (isLive) {
        debugPrint('Found first working URL: $url');
        return url; // Return the first working URL found
      }
    }

    debugPrint('No working URL found in the provided list.');
    return mainServerUrl.value; // No working URL found in the entire list
  }
}
