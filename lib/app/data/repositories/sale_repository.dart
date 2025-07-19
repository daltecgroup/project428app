import 'package:abg_pos_app/app/data/models/Sale.dart';
import 'package:abg_pos_app/app/data/providers/sale_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../shared/custom_alert.dart';

class SaleRepository extends GetxController {
  SaleRepository({required this.provider});
  final SaleProvider provider;

  Future<Map<String, dynamic>> createSale(dynamic data) async {
    final Response response = await provider.createSale(data);
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
        'Failed to create sale: ${response.statusCode} - ${response.statusText ?? ''}',
      );
    }
    return {
      'statusCode': response.statusCode,
      'message': response.body['message'],
      'sale': response.body['sale'],
    };
  }

  Future<List<Sale>> getSales({String? query}) async {
    final Response response = await provider.getSales(query: query);
    if (response.hasError) {
      throw Exception(
        'Failed to fetch sales: ${response.statusCode} - ${response.statusText ?? ''}',
      );
    }
    return response.body ?? [];
  }

  Future<Map<String, dynamic>> updateSale(String id, dynamic data) async {
    final Response response = await provider.updateSale(id, data);
    if (response.hasError) {
      customAlertDialog(response.body['message']);
      throw Exception(
        'Failed to update sale: ${response.statusCode} - ${response.statusText ?? ''}',
      );
    }
    return {
      'statusCode': response.statusCode,
      'message': response.body['message'],
      'sale': response.body['sale'],
    };
  }

  Future<Map<String, dynamic>> deleteSale(String id) async {
    final Response response = await provider.deleteSale(id);
    if (response.hasError) {
      customAlertDialog(response.body['message']);
      throw Exception(
        'Failed to delete sale: ${response.statusCode} - ${response.statusText ?? ''}',
      );
    }
    return {
      'statusCode': response.statusCode,
      'message': response.body['message'],
    };
  }
}
