import 'dart:async';
import 'dart:convert';
import 'package:abg_pos_app/app/routes/app_pages.dart';
import 'package:abg_pos_app/app/utils/services/setting_service.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import '../../data/providers/auth_provider.dart';
import '../../utils/constants/app_constants.dart';
import '../../utils/helpers/get_storage_helper.dart';
import '../../utils/helpers/logger_helper.dart';

import '../../data/models/User.dart';
import '../../shared/custom_alert.dart';

class AuthService extends GetxService {
  BoxHelper box = BoxHelper();
  final AuthProvider _authProvider = Get.put(AuthProvider());
  final SettingService _settingService = Get.find<SettingService>();
  RxBool isLoggedIn = false.obs;
  Rx<User?> currentUser = (null as User?).obs;

  late StreamSubscription<bool> streamLoggedIn;

  @override
  void onInit() {
    super.onInit();
    streamLoggedIn = isLoggedIn.listen((event) {
      if (!event) Get.offAllNamed(Routes.AUTH);
    });
  }

  @override
  void onReady() {
    super.onReady();
    _initAuth();
  }

  @override
  void onClose() {
    super.onClose();
    streamLoggedIn.cancel();
  }

  void _initAuth() {
    if (!box.isNull(AppConstants.KEY_IS_LOGGED_IN) &&
        !box.isNull(AppConstants.KEY_CURRENT_USER_DATA) &&
        !box.isNull(AppConstants.KEY_USER_TOKEN)) {
      isLoggedIn.value = box.getValue(AppConstants.KEY_IS_LOGGED_IN);
      currentUser.value = User.fromJson(
        json.decode(box.getValue(AppConstants.KEY_CURRENT_USER_DATA)),
      );

      if (getRoles.isNotEmpty) {
        if (getRoles.length > 1) {
          Get.offAllNamed(Routes.SELECT_ROLE);
        } else {
          switch (getRoles.first) {
            case AppConstants.ROLE_ADMIN:
              _settingService.currentRole.value = AppConstants.ROLE_ADMIN;
              Get.offAllNamed(Routes.ADMIN_DASHBOARD);
              break;
            case AppConstants.ROLE_FRANCHISEE:
              _settingService.currentRole.value = AppConstants.ROLE_FRANCHISEE;
              Get.offAllNamed(Routes.FRANCHISEE_DASHBOARD);
              break;
            case AppConstants.ROLE_SPVAREA:
              _settingService.currentRole.value = AppConstants.ROLE_SPVAREA;
              Get.offAllNamed(Routes.SPVAREA_DASHBOARD);
              break;
            case AppConstants.ROLE_OPERATOR:
              _settingService.currentRole.value = AppConstants.ROLE_OPERATOR;
              Get.offAllNamed(Routes.OPERATOR_DASHBOARD);
              break;
            default:
              Get.offAllNamed(Routes.AUTH);
          }
        }
      } else {
        Get.offAllNamed(Routes.AUTH);
      }
    } else {
      Get.offAllNamed(Routes.AUTH);
    }
  }

  List<dynamic> get getRoles {
    List roles = [];

    if (!box.isNull(AppConstants.KEY_USER_TOKEN)) {
      roles = JwtDecoder.decode(
        box.getValue(AppConstants.KEY_USER_TOKEN),
      )['roles'];
    } else {
      logout();
    }

    return roles;
  }

  bool hasAnyRole(List<String> roles) {
    return roles.any((role) => getRoles.contains(role));
  }

  void logout() async {
    isLoggedIn.value = false;
    currentUser.value = null as User?;
    await box.removeValue(AppConstants.KEY_IS_LOGGED_IN);
    await box.removeValue(AppConstants.KEY_USER_TOKEN);
    await box.removeValue(AppConstants.KEY_CURRENT_USER_DATA);
    await box.removeValue(AppConstants.KEY_CURRENT_ROLE);
  }

  String get getCurrentRole {
    return box.getValue(AppConstants.KEY_CURRENT_ROLE) ?? '';
  }

  bool get isAuthenticate {
    if (!box.isNull(AppConstants.KEY_USER_TOKEN)) {
      return DateTime.fromMillisecondsSinceEpoch(
        JwtDecoder.decode(box.getValue(AppConstants.KEY_USER_TOKEN))['exp'] *
            1000,
      ).isAfter(DateTime.now());
    }
    return false;
  }

  Future<void> login(String id, String password) async {
    try {
      Response response = await _authProvider.login(id, password);
      switch (response.statusCode) {
        case 200:
          currentUser.value = User.fromJson(response.body['data']);
          isLoggedIn.value = true;
          box.setValue(AppConstants.KEY_IS_LOGGED_IN, true);
          box.setValue(AppConstants.KEY_USER_TOKEN, response.body['token']);
          box.setValue(
            AppConstants.KEY_CURRENT_USER_DATA,
            json.encode(currentUser.toJson()),
          );
          Get.offNamed(Routes.SELECT_ROLE);
          break;
        case 410:
          customAlertDialog(
            'Pengguna telah terhapus atau tidak pernah terdaftar',
          );
          break;
        case 404:
          customAlertDialog('Akun sedang dinonaktifkan');
          break;
        case 401:
          customAlertDialog('PIN salah');
          break;
        default:
          customAlertDialog('Server mengalami gangguan');
      }
    } catch (e) {
      customAlertDialog('Server mengalami gangguan');
      LoggerHelper.logError(e.toString());
    }
  }

  User? get currentUserFromStorage {
    final userString = box.getValue(AppConstants.KEY_CURRENT_USER_DATA);
    if (userString == null) return null as User?;
    return User.fromJson(json.decode(userString));
  }
}
