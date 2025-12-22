import 'package:abg_pos_app/app/data/models/Request.dart';
import 'package:abg_pos_app/app/data/providers/request_provider.dart';
import 'package:get/get.dart';
import '../../shared/custom_alert.dart';

class RequestRepository extends GetxController {
  RequestRepository({required this.provider});
  final RequestProvider provider;

  Future<Map<String, dynamic>> createRequest(dynamic data) async {
    final Response response = await provider.createRequest(data);
    if (response.hasError) {
      String message = response.body['message'] as String;
      
        customAlertDialog(message);
      
      throw Exception(
        'Failed to create request: ${response.statusCode} - ${response.statusText ?? ''}',
      );
    }
    return {
      'statusCode': response.statusCode,
      'message': response.body['message'],
    };
  }

  Future<List<Request>> getAllRequest(String filter) async {
    final Response response = await provider.getAllRequest(filter);
    if (response.hasError) {
      throw Exception(
        'Failed to fetch all request: ${response.statusCode} - ${response.statusText ?? ''}',
      );
    }
    return response.body ?? [];
  }

  Future<Map<String, dynamic>> processRequest(String id, dynamic data) async {
    final Response response = await provider.processRequest(id, data);
    if (response.hasError) {
      customAlertDialog(response.body['message']);
      throw Exception(
        'Failed to process request: ${response.statusCode} - ${response.statusText ?? ''}',
      );
    }
    return {
      'statusCode': response.statusCode,
      'message': response.body['message'],
      // 'request': response.body['request'],
    };
  }

  Future<Map<String, dynamic>> deleteRequest(String id) async {
    final Response response = await provider.deleteRequest(id);
    if (response.hasError) {
      customAlertDialog(response.body['message']);
      throw Exception(
        'Failed to delete request: ${response.statusCode} - ${response.statusText ?? ''}',
      );
    }
    return {
      'statusCode': response.statusCode,
      'message': response.body['message'],
    };
  }
}
