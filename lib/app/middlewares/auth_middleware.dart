// app/middleware/auth_middleware.dart
import 'package:abg_pos_app/app/shared/alert_snackbar.dart';
import 'package:abg_pos_app/app/utils/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/app_pages.dart';
import '../utils/services/auth_service.dart'; // Your routes

class AuthMiddleware extends GetMiddleware {
  final AuthService _authService = Get.find<AuthService>();

  final String adm = AppConstants.ROLE_ADMIN;
  final String frc = AppConstants.ROLE_FRANCHISEE;
  final String spv = AppConstants.ROLE_SPVAREA;
  final String opr = AppConstants.ROLE_OPERATOR;

  @override
  RouteSettings? redirect(String? route) {
    final Map<String, List<String>> requiredRoles = {
      Routes.ADMIN_DASHBOARD: [adm],
      Routes.USER_LIST: [adm],
      Routes.ADD_USER: [adm],
      Routes.USER_DETAIL: [adm],
      Routes.EDIT_USER: [adm],
      Routes.OUTLET_LIST: [adm, frc, spv],
      Routes.PRODUCT: [adm],
      // Add other routes and their required roles
    };
    final List<String>? rolesRequiredForRoute = requiredRoles[route];

    if (!_authService.isAuthenticate) {
      if (route == Routes.AUTH || route == Routes.SELECT_ROLE) {
        return null;
      }
      expiredSnackbar();
      return const RouteSettings(name: Routes.AUTH);
    }

    if (rolesRequiredForRoute != null) {
      if (!_authService.hasAnyRole(rolesRequiredForRoute)) {
        unauthorizedSnackbar();
        return const RouteSettings(name: Routes.AUTH);
      }
    }

    return null;
  }
}
