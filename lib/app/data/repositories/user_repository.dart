import 'package:abg_pos_app/app/shared/custom_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../models/User.dart';
import '../providers/user_provider.dart';

class UserRepository extends GetxController {
  UserRepository({required this.userProvider});
  final UserProvider userProvider;

  Future<List<User>> getUsers() async {
    final Response response = await userProvider.getUsers();
    if (response.hasError) {
      throw Exception(
        'Failed to fetch users: ${response.statusCode} - ${response.statusText ?? ''}',
      );
    }
    return response.body ?? [];
  }

  Future<Map<String, dynamic>> createUser(dynamic data) async {
    final Response response = await userProvider.createUser(data);
    if (response.statusCode == 400) {
      String message = response.body['message'] as String;
      List<dynamic>? errors = response.body['errors'] as List<dynamic>? ?? [];

      customAlertDialogWithTitle(
        title: message,
        content: Column(
          children: List.generate(
            errors.length,
            (index) => Text(errors[index].toString()),
          ),
        ),
      );
      throw Exception(
        'Failed to create user: ${response.statusCode} - ${response.statusText ?? ''}',
      );
    }
    return {
      'statusCode': response.statusCode,
      'message': response.body['message'],
      'error': response.body['error'],
    };
  }

  Future<Map<String, dynamic>> updateUser(String id, dynamic data) async {
    final Response response = await userProvider.updateUser(id, data);
    if (response.hasError) {
      customAlertDialog(response.body['message']);
      throw Exception(
        'Failed to update user: ${response.statusCode} - ${response.statusText ?? ''}',
      );
    }
    return {
      'statusCode': response.statusCode,
      'message': response.body['message'],
      'user': response.body['user'],
    };
  }

  Future<Map<String, dynamic>> softDeleteUser(String id) async {
    final Response response = await userProvider.softDeleteUser(id);
    if (response.hasError) {
      customAlertDialog(response.body['message']);
      throw Exception(
        'Failed to delete user: ${response.statusCode} - ${response.statusText ?? ''}',
      );
    }
    return {
      'statusCode': response.statusCode,
      'message': response.body['message'],
    };
  }

  Future<Map<String, List<User>>> syncUsers(
    int latest,
    List<String> idList,
  ) async {
    final Response<Map<String, List<User>>> response = await userProvider
        .syncUsers(latest, idList);
    if (response.hasError) {
      throw Exception(
        'Failed to sync users: ${response.statusCode} - ${response.statusText ?? ''}',
      );
    }
    return response.body ?? {};
  }
}
