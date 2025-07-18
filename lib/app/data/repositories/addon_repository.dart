import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/Addon.dart';
import '../../data/providers/addon_provider.dart';
import '../../shared/custom_alert.dart';

class AddonRepository extends GetxController {
  AddonRepository({required this.provider});
  final AddonProvider provider;

  Future<Map<String, dynamic>> createAddon(dynamic data) async {
    final Response response = await provider.createAddon(data);
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
        'Failed to create addon: ${response.statusCode} - ${response.statusText ?? ''}',
      );
    }
    return {
      'statusCode': response.statusCode,
      'message': response.body['message'],
    };
  }

  Future<List<Addon>> getAddons() async {
    final Response response = await provider.getAddons();
    if (response.hasError) {
      throw Exception(
        'Failed to fetch addons: ${response.statusCode} - ${response.statusText ?? ''}',
      );
    }
    return response.body ?? [];
  }

  Future<Map<String, dynamic>> updateAddon(String id, dynamic data) async {
    final Response response = await provider.updateAddon(id, data);
    if (response.hasError) {
      customAlertDialog(response.body['message']);
      throw Exception(
        'Failed to update addon: ${response.statusCode} - ${response.statusText ?? ''}',
      );
    }
    return {
      'statusCode': response.statusCode,
      'message': response.body['message'],
      'addon': response.body['addon'],
    };
  }

  Future<Map<String, dynamic>> deleteAddon(String id) async {
    final Response response = await provider.deleteAddon(id);
    if (response.hasError) {
      customAlertDialog(response.body['message']);
      throw Exception(
        'Failed to delete addon: ${response.statusCode} - ${response.statusText ?? ''}',
      );
    }
    return {
      'statusCode': response.statusCode,
      'message': response.body['message'],
    };
  }
}
