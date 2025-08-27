import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:collection/collection.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import '../../routes/app_pages.dart';
import '../../controllers/outlet_data_controller.dart';
import '../../utils/helpers/sync_helper.dart';
import '../../utils/helpers/text_helper.dart';
import '../../utils/services/setting_service.dart';
import '../../utils/constants/app_constants.dart';
import '../../utils/helpers/get_storage_helper.dart';
import '../../utils/helpers/logger_helper.dart';
import '../../data/providers/outlet_provider.dart';
import '../../data/repositories/outlet_repository.dart';
import '../../data/models/Outlet.dart';
import '../../data/providers/auth_provider.dart';
import '../../data/models/User.dart';
import '../../shared/custom_alert.dart';

class AuthService extends GetxService {
  final AuthProvider _authProvider = Get.put(AuthProvider());
  final SettingService _settingService = Get.find<SettingService>();
  // final UserOutletDataController userOutletData = Get.put(
  //   UserOutletDataController(
  //     repository: Get.put(
  //       UserOutletRepository(provider: Get.put(UserOutletProvider())),
  //     ),
  //   ),
  // );
  final outletData = Get.put(
    OutletDataController(
      repository: Get.put(
        OutletRepository(provider: Get.put(OutletProvider())),
      ),
    ),
  );

  RxBool isLoggedIn = false.obs;
  Rx<User?> currentUser = (null as User?).obs;

  late StreamSubscription<bool> streamLoggedIn;

  @override
  void onInit() {
    super.onInit();
    streamLoggedIn = isLoggedIn.listen((event) {
      if (!event) {
        LoggerHelper.logInfo('Log In Status Change: Logged out');
        Get.offAllNamed(Routes.AUTH);
      }
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
      LoggerHelper.logInfo(
        'INIT AUTH SERVICE: User is logged in, route to Landing Page.',
      );
      isLoggedIn.value = box.getValue(AppConstants.KEY_IS_LOGGED_IN);
      currentUser.value = User.fromJson(
        json.decode(box.getValue(AppConstants.KEY_CURRENT_USER_DATA)),
      );

      if (getRoles.isNotEmpty) {
        if (getRoles.length > 1) {
          if (!box.isNull(AppConstants.KEY_CURRENT_ROLE)) {
            LoggerHelper.logInfo(
              'ROLE BASED FORWARDER: User has multiple role, already select a role before',
            );
            roleBasedForwarder(box.getValue(AppConstants.KEY_CURRENT_ROLE));
          } else {
            LoggerHelper.logInfo(
              'ROLE BASED FORWARDER: User has multiple role but no current role, route to Select Role Page',
            );
            Get.offAllNamed(Routes.SELECT_ROLE);
          }
        } else {
          LoggerHelper.logInfo('ROLE BASED FORWARDER: User has single role');
          roleBasedForwarder(getRoles.first);
        }
      } else {
        LoggerHelper.logInfo(
          'ROLE BASED FORWARDER: User has no role, route to Login Page',
        );
        Get.offAllNamed(Routes.AUTH);
      }
    } else {
      LoggerHelper.logInfo(
        'INIT AUTH SERVICE: User is not logged in, route to Login Page.',
      );
      Get.offAllNamed(Routes.AUTH);
    }
  }

  Future<void> roleBasedForwarder(String role) async {
    switch (role) {
      case AppConstants.ROLE_ADMIN:
        _settingService.currentRole.value = AppConstants.ROLE_ADMIN;
        LoggerHelper.logInfo('ROLE BASED FORWARDER: Route to Admin Dashboard');
        Get.offAllNamed(Routes.ADMIN_DASHBOARD);
        break;
      case AppConstants.ROLE_FRANCHISEE:
        _settingService.currentRole.value = AppConstants.ROLE_FRANCHISEE;
        LoggerHelper.logInfo(
          'ROLE BASED FORWARDER: Route to Franchisee Dashboard',
        );
        Get.offAllNamed(Routes.FRANCHISEE_DASHBOARD);
        break;
      case AppConstants.ROLE_SPVAREA:
        _settingService.currentRole.value = AppConstants.ROLE_SPVAREA;
        LoggerHelper.logInfo(
          'ROLE BASED FORWARDER: Route to SPV Area Dashboard',
        );
        Get.offAllNamed(Routes.SPVAREA_DASHBOARD);
        break;
      case AppConstants.ROLE_OPERATOR:
        _settingService.currentRole.value = AppConstants.ROLE_OPERATOR;
        LoggerHelper.logInfo(
          'ROLE BASED FORWARDER: Route to Operator Dashboard',
        );
        if (currentUser.value == null) {
          LoggerHelper.logInfo(
            'ROLE BASED FORWARDER: Current User is not found. Logging out...',
          );
          return logout();
        }

        await outletData.syncData();
        final outlets = outletData.getOutletByOperatorId(currentUser.value!.id);
        if (outletData.outlets.isEmpty) {
          customAlertDialog('Data gerai gagal dimuat!');
          return logout();
        }
        if (outlets.isEmpty) {
          customAlertDialog('Anda belum ditugaskan di Gerai manapun');
          return logout();
        }

        if (!box.isNull(AppConstants.KEY_CURRENT_OUTLET)) {
          LoggerHelper.logInfo(
            'ROLE BASED FORWARDER: Current Outlet found. Countinue routing...',
          );
          final selectedOutletFromStorage = outlets.lastWhereOrNull(
            (outlet) =>
                outlet.id == box.getValue(AppConstants.KEY_CURRENT_OUTLET),
          );

          if (selectedOutletFromStorage == null) {
            customAlertDialog(
              'ROLE BASE FORWARDER: Fail to get current outlet data. Logging out',
            );
            return logout();
          }

          await _setOperatorSession(selectedOutletFromStorage);
          Get.toNamed(Routes.OPERATOR_DASHBOARD);
          break;
        }

        if (outlets.length == 1)
          LoggerHelper.logInfo(
            'ROLE BASED FORWARDER: Operator only assign to one outlet',
          );
        if (outlets.length > 1)
          LoggerHelper.logInfo(
            'ROLE BASED FORWARDER: Operator is assign to more than one outlet. Route to Select Outlet Page',
          );

        final Outlet? selectedOutlet = outlets.length == 1
            ? outlets.first
            : await Get.toNamed(Routes.SELECT_OUTLET) as Outlet?;

        if (selectedOutlet == null) {
          LoggerHelper.logInfo(
            'ROLE BASED FORWARDER: No outlet selected. Logging out...',
          );
          return logout();
        }

        await _setOperatorSession(selectedOutlet);
        Get.toNamed(Routes.OPERATOR_DASHBOARD);
        break;
      default:
        Get.offAllNamed(Routes.AUTH);
    }
  }

  Future<void> _setOperatorSession(Outlet outlet) async {
    _settingService.currentRole.value = AppConstants.ROLE_OPERATOR;
    await box.setValue(
      AppConstants.KEY_CURRENT_ROLE,
      AppConstants.ROLE_OPERATOR,
    );
    await box.setValue(AppConstants.KEY_CURRENT_OUTLET, outlet.id);
    LoggerHelper.logInfo(
      'ROLE BASE FORWARDER: Operator login ke gerai ${normalizeName(outlet.name)}',
    );
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
          if (getRoles.length == 1) {
            roleBasedForwarder(getRoles.first);
          } else {
            Get.offNamed(Routes.SELECT_ROLE);
          }
          break;
        case 410:
          customAlertDialog(
            'Pengguna telah terhapus atau tidak pernah terdaftar',
          );
          break;
        case 404:
          customAlertDialog('Server mengalami gangguan');
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
    LoggerHelper.logInfo('LOGGED OUT: Routing to Login Page');
    isLoggedIn.value = false;
    currentUser.value = null as User?;
    await box.removeValue(AppConstants.KEY_IS_LOGGED_IN);
    await box.removeValue(AppConstants.KEY_USER_TOKEN);
    await box.removeValue(AppConstants.KEY_CURRENT_USER_DATA);
    await box.removeValue(AppConstants.KEY_CURRENT_ROLE);
    await box.removeValue(AppConstants.KEY_CURRENT_OUTLET);
    stopAllAutoSync();
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

  User? get currentUserFromStorage {
    final userString = box.getValue(AppConstants.KEY_CURRENT_USER_DATA);
    if (userString == null) return null as User?;
    return User.fromJson(json.decode(userString));
  }
}
