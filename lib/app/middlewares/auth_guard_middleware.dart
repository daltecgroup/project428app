import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project428app/app/services/auth_service.dart';

class AuthGuardMiddleware extends GetMiddleware {
  final AuthService _authService = Get.find<AuthService>();
  final List<String> requiredRoles;

  AuthGuardMiddleware({this.requiredRoles = const []});

  @override
  int? get priority => 1; // Lower priority runs first

  @override
  RouteSettings? redirect(String? route) {
    if (!_authService.isLoggedIn.value) {
      // User is not logged in, redirect to login page
      return const RouteSettings(name: '/login');
    }

    if (requiredRoles.isNotEmpty && !_authService.hasAnyRole(requiredRoles)) {
      // User is logged in but doesn't have the required roles, redirect to unauthorized page
      return const RouteSettings(name: '/unauthorized');
    }

    return null; // Allow access
  }
}
