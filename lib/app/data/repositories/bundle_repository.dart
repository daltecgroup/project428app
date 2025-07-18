import 'package:abg_pos_app/app/data/models/Bundle.dart';
import 'package:abg_pos_app/app/data/providers/bundle_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../shared/custom_alert.dart';

class BundleRepository extends GetxController {
  BundleRepository({required this.provider});
  final BundleProvider provider;

  Future<Map<String, dynamic>> createBundle(dynamic data) async {
    final Response response = await provider.createBundle(data);
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
        'Failed to create bundle: ${response.statusCode} - ${response.statusText ?? ''}',
      );
    }
    return {
      'statusCode': response.statusCode,
      'message': response.body['message'],
    };
  }

  Future<List<Bundle>> getBundles() async {
    final Response response = await provider.getBundles();
    if (response.hasError) {
      throw Exception(
        'Failed to fetch bundles: ${response.statusCode} - ${response.statusText ?? ''}',
      );
    }
    return response.body ?? [];
  }

  Future<Map<String, dynamic>> updateBundle(String id, dynamic data) async {
    final Response response = await provider.updateBundle(id, data);
    if (response.hasError) {
      customAlertDialog(response.body['message']);
      throw Exception(
        'Failed to update bundle: ${response.statusCode} - ${response.statusText ?? ''}',
      );
    }
    return {
      'statusCode': response.statusCode,
      'message': response.body['message'],
      'bundle': response.body['bundle'],
    };
  }

  Future<Map<String, dynamic>> deleteBundle(String id) async {
    final Response response = await provider.deleteBundle(id);
    if (response.hasError) {
      customAlertDialog(response.body['message']);
      throw Exception(
        'Failed to delete bundle: ${response.statusCode} - ${response.statusText ?? ''}',
      );
    }
    return {
      'statusCode': response.statusCode,
      'message': response.body['message'],
    };
  }
}
