import 'package:abg_pos_app/app/data/models/OutletInventoryTransaction.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../shared/custom_alert.dart';
import '../providers/outlet_inventory_transaction_provider.dart';

class OutletInventoryTransactionRepository extends GetxController {
  OutletInventoryTransactionRepository({required this.provider});
  final OutletInventoryTransactionProvider provider;

  Future<Map<String, dynamic>> createOutletInventoryTransaction(
    dynamic data,
  ) async {
    final Response response = await provider.createOutletInventoryTransaction(
      data,
    );
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

  Future<Map<String, dynamic>> createMultipleOutletInventoryTransaction(
    dynamic data,
  ) async {
    final Response response = await provider
        .createMultipleOutletInventoryTransaction(data);
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

  Future<List<OutletinventoryTransaction>> getOutletInventoryTransactions({
    String? query,
  }) async {
    final Response response = await provider.getOutletInventoryTransactions(
      query: query,
    );
    if (response.hasError) {
      throw Exception(
        'Failed to fetch outlet inventory transactions: ${response.statusCode} - ${response.statusText ?? ''}',
      );
    }
    return response.body ?? [];
  }
}
