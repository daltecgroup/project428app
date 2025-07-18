import 'package:abg_pos_app/app/data/models/Ingredient.dart';
import 'package:abg_pos_app/app/data/models/IngredientHistory.dart';
import 'package:abg_pos_app/app/data/providers/ingredient_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/custom_alert.dart';

class IngredientRepository extends GetxController {
  IngredientRepository({required this.provider});
  final IngredientProvider provider;

  Future<Map<String, dynamic>> createIngredient(dynamic data) async {
    final Response response = await provider.createIngredient(data);
    if (response.hasError) {
      String message = response.body['message'] as String;
      List<dynamic>? errors = response.body['errors'] as List<dynamic>? ?? [];
      if (errors.isNotEmpty) {
        customAlertDialogWithTitle(
          title: message,
          content: Column(children: List.generate(errors.length, (index) => Text(errors[index].toString()))),
        );
      } else {
        customAlertDialog(message);
      }
      throw Exception('Failed to create ingredient: ${response.statusCode} - ${response.statusText ?? ''}');
    }
    return {
      'statusCode': response.statusCode,
      'message': response.body['message'],
      'ingredient': response.body['ingredient'],
    };
  }

  Future<List<Ingredient>> getIngredients() async {
    final Response response = await provider.getIngredients();
    if (response.hasError) {
      throw Exception('Failed to fetch ingredients: ${response.statusCode} - ${response.statusText ?? ''}');
    }
    return response.body ?? [];
  }

  Future<List<IngredientHistory>> getIngredientHistory(String id) async {
    final Response response = await provider.getIngredientHistory(id);
    if (response.hasError) {
      throw Exception('Failed to fetch ingredients: ${response.statusCode} - ${response.statusText ?? ''}');
    }
    return response.body ?? [];
  }

  Future<Map<String, dynamic>> updateIngredient(String id, dynamic data) async {
    final Response response = await provider.updateIngredient(id, data);
    if (response.hasError) {
      customAlertDialog(response.body['message']);
      throw Exception('Failed to update user: ${response.statusCode} - ${response.statusText ?? ''}');
    }
    return {
      'statusCode': response.statusCode,
      'message': response.body['message'],
      'ingredient': response.body['ingredient'],
    };
  }

  Future<Map<String, dynamic>> deleteIngredient(String id) async {
    final Response response = await provider.deleteIngredient(id);
    if (response.hasError) {
      customAlertDialog(response.body['message']);
      throw Exception('Failed to update user: ${response.statusCode} - ${response.statusText ?? ''}');
    }
    return {'statusCode': response.statusCode, 'message': response.body['message']};
  }
}
