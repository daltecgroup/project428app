import 'package:abg_pos_app/app/data/models/Order.dart';
import 'package:abg_pos_app/app/data/providers/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../shared/custom_alert.dart';

class OrderRepository extends GetxController {
  OrderRepository({required this.provider});
  final OrderProvider provider;

  Future<Map<String, dynamic>> createOrder(dynamic data) async {
    final Response response = await provider.createOrder(data);
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
        'Failed to create order: ${response.statusCode} - ${response.statusText ?? ''}',
      );
    }
    return {
      'statusCode': response.statusCode,
      'message': response.body['message'],
    };
  }

  Future<List<Order>> getOrders() async {
    final Response response = await provider.getOrders();
    if (response.hasError) {
      throw Exception(
        'Failed to fetch orders: ${response.statusCode} - ${response.statusText ?? ''}',
      );
    }
    return response.body ?? [];
  }

  Future<Map<String, dynamic>> updateOrder(String id, dynamic data) async {
    final Response response = await provider.updateOrder(id, data);
    if (response.hasError) {
      customAlertDialog(response.body['message']);
      throw Exception(
        'Failed to update order: ${response.statusCode} - ${response.statusText ?? ''}',
      );
    }
    return {
      'statusCode': response.statusCode,
      'message': response.body['message'],
      'order': response.body['order'],
    };
  }

  Future<Map<String, dynamic>> deleteOrder(String id) async {
    final Response response = await provider.deleteOrder(id);
    if (response.hasError) {
      customAlertDialog(response.body['message']);
      throw Exception(
        'Failed to delete order: ${response.statusCode} - ${response.statusText ?? ''}',
      );
    }
    return {
      'statusCode': response.statusCode,
      'message': response.body['message'],
    };
  }
}
