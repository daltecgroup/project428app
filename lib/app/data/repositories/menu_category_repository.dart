import 'package:abg_pos_app/app/data/models/MenuCategory.dart';
import 'package:abg_pos_app/app/data/providers/menu_category_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/custom_alert.dart';

class MenuCategoryRepository extends GetxController {
  MenuCategoryRepository({required this.provider});
  final MenuCategoryProvider provider;

  Future<Map<String, dynamic>> createMenuCategory(dynamic data) async {
    final Response response = await provider.createMenuCategory(data);
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
        'Failed to create menu category: ${response.statusCode} - ${response.statusText ?? ''}',
      );
    }
    return {
      'statusCode': response.statusCode,
      'message': response.body['message'],
      'menuCategory': response.body['menuCategory'],
    };
  }

  Future<List<MenuCategory>> getMenuCategories() async {
    final Response response = await provider.getMenuCategories();
    if (response.hasError) {
      throw Exception(
        'Failed to fetch menu categories: ${response.statusCode} - ${response.statusText ?? ''}',
      );
    }
    return response.body ?? [];
  }

  Future<Map<String, dynamic>> updateMenuCategory(
    String id,
    dynamic data,
  ) async {
    final Response response = await provider.updateMenuCategory(id, data);
    if (response.hasError) {
      customAlertDialog(response.body['message']);
      throw Exception(
        'Failed to update menu category: ${response.statusCode} - ${response.statusText ?? ''}',
      );
    }
    return {
      'statusCode': response.statusCode,
      'message': response.body['message'],
      'menuCategory': response.body['menuCategory'],
    };
  }

  Future<Map<String, dynamic>> deleteMenuCategory(String id) async {
    final Response response = await provider.deleteMenuCategory(id);
    if (response.hasError) {
      customAlertDialog(response.body['message']);
      throw Exception(
        'Failed to delete menu category: ${response.statusCode} - ${response.statusText ?? ''}',
      );
    }
    return {
      'statusCode': response.statusCode,
      'message': response.body['message'],
    };
  }
}
