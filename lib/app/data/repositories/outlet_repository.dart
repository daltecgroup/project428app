import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../data/models/Outlet.dart';
import '../../data/providers/outlet_provider.dart';
import '../../shared/custom_alert.dart';

class OutletRepository extends GetxController {
  OutletRepository({required this.provider});
  final OutletProvider provider;

  Future<Map<String, dynamic>> createOutlet(dynamic data) async {
    final Response response = await provider.createOutlet(data);
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
        'Failed to create outlet: ${response.statusCode} - ${response.statusText ?? ''}',
      );
    }
    return {
      'statusCode': response.statusCode,
      'message': response.body['message'],
    };
  }

  Future<List<Outlet>> getOutlets() async {
    final Response response = await provider.getOutlets();
    if (response.hasError) {
      throw Exception(
        'Failed to fetch outlets: ${response.statusCode} - ${response.statusText ?? ''}',
      );
    }
    return response.body ?? [];
  }

  Future<Map<String, dynamic>> updateOutlet(String id, dynamic data) async {
    final Response response = await provider.updateOutlet(id, data);
    if (response.hasError) {
      customAlertDialog(response.body['message']);
      throw Exception(
        'Failed to update outlet: ${response.statusCode} - ${response.statusText ?? ''}',
      );
    }
    return {
      'statusCode': response.statusCode,
      'message': response.body['message'],
      'outlet': response.body['outlet'],
    };
  }

  Future<Map<String, dynamic>> deleteOutlet(String id) async {
    final Response response = await provider.deleteOutlet(id);
    if (response.hasError) {
      customAlertDialog(response.body['message']);
      throw Exception(
        'Failed to delete outlet: ${response.statusCode} - ${response.statusText ?? ''}',
      );
    }
    return {
      'statusCode': response.statusCode,
      'message': response.body['message'],
    };
  }
}
