import 'package:abg_pos_app/app/data/models/Menu.dart';
import 'package:abg_pos_app/app/data/providers/menu_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../shared/custom_alert.dart';

class MenuRepository extends GetxController {
  MenuRepository({required this.provider});
  final MenuProvider provider;

  Future<Map<String, dynamic>> createMenu(dynamic data) async {
    final Response response = await provider.createMenu(data);
    if (response.hasError) {
      String message = response.body['message'] as String;
      List<dynamic>? errors = response.body['errors'] as List<dynamic>? ?? [];
      if (errors.isNotEmpty) {
        customAlertDialogWithTitle(
          title: message,
          content: Column(
            children: List.generate(
              errors.length,
              (index) => Text(errors[index].toString()),
            ),
          ),
        );
      } else {
        customAlertDialog(message);
      }
      throw Exception(
        'Failed to create menu: ${response.statusCode} - ${response.statusText ?? ''}',
      );
    }
    return {
      'statusCode': response.statusCode,
      'message': response.body['message'],
    };
  }

  Future<List<Menu>> getMenu() async {
    final Response response = await provider.getMenus();
    if (response.hasError) {
      throw Exception(
        'Failed to fetch menu: ${response.statusCode} - ${response.statusText ?? ''}',
      );
    }
    return response.body ?? [];
  }

  Future<Map<String, dynamic>> updateMenu(String id, dynamic data) async {
    final Response response = await provider.updateMenu(id, data);
    if (response.hasError) {
      customAlertDialog(response.body['message']);
      throw Exception(
        'Failed to update menu: ${response.statusCode} - ${response.statusText ?? ''}',
      );
    }
    return {
      'statusCode': response.statusCode,
      'message': response.body['message'],
      'menu': response.body['menu'],
    };
  }

  Future<Map<String, dynamic>> updateMenuImage(String id, dynamic data) async {
    final Response response = await provider.updateMenuImage(id, data);
    if (response.hasError) {
      customAlertDialog(response.body['message']);
      throw Exception(
        'Failed to update menu image: ${response.statusCode} - ${response.statusText ?? ''}',
      );
    }
    return {
      'statusCode': response.statusCode,
      'message': response.body['message'],
      'menu': response.body['menu'],
    };
  }

  Future<Map<String, dynamic>> deleteMenu(String id) async {
    final Response response = await provider.deleteMenu(id);
    if (response.hasError) {
      customAlertDialog(response.body['message']);
      throw Exception(
        'Failed to delete menu: ${response.statusCode} - ${response.statusText ?? ''}',
      );
    }
    return {
      'statusCode': response.statusCode,
      'message': response.body['message'],
    };
  }
}
