import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:project428app/app/data/auth_provider.dart';

class AuthService extends GetxService {
  // final _secureStorage = const FlutterSecureStorage();
  final box = GetStorage();
  late final AuthProvider _authP; // Will be initialized in onInit

  RxString accessToken = ''.obs;
  RxString refreshToken = ''.obs;
  RxBool isLoggedIn = false.obs;
  RxList<String> userRoles = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    _authP = Get.find<AuthProvider>(); // Get the ApiClient instance
    _initAuth();
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
      final response = await _authP.post(
        '/auth/login', // Relative path to baseUrl
        {'userId': userId, 'pin': pin},
      );

      print(response.statusText);

      if (response.statusCode == 200) {
        final data =
            response.body; // GetConnect response.body is already parsed
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
        final response = await _authP.post('/auth/refresh', {
          'refreshToken': refreshToken.value,
        });

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
}
