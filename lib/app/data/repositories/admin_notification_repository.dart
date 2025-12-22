import 'package:abg_pos_app/app/data/models/AdminNotification.dart';
import 'package:abg_pos_app/app/data/providers/admin_notification_provider.dart';
import 'package:get/get.dart';
import '../../shared/custom_alert.dart';

class AdminNotificationRepository extends GetxController {
  AdminNotificationRepository({required this.provider});
  final AdminNotificationProvider provider;

  Future<List<AdminNotification>> getAllNotifications() async {
    final Response<List<AdminNotification>> response =
        await provider.getAllNotifications();
    if (response.hasError) {
      throw Exception(
        'Failed to fetch all notifications: ${response.statusCode} - ${response.statusText ?? ''}',
      );
    }
    return response.body ?? [];
  }

  Future<Map<String, dynamic>> markAsOpen(String id) async {
    final Response response = await provider.markAsOpen(id);
    if (response.hasError) {
      customAlertDialog(response.body['message']);
      throw Exception(
        'Failed to mark notification as open: ${response.statusCode} - ${response.statusText ?? ''}',
      );
    }
    return {
      'statusCode': response.statusCode,
      'message': response.body['message'],
    };
  }

  Future<Map<String, dynamic>> destroy(String id) async {
    final Response response = await provider.destroy(id);
    if (response.hasError) {
      customAlertDialog(response.body['message']);
      throw Exception(
        'Failed to delete notification: ${response.statusCode} - ${response.statusText ?? ''}',
      );
    }
    return {
      'statusCode': response.statusCode,
      'message': response.body['message'],
    };
  }
}