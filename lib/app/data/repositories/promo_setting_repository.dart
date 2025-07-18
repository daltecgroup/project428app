import 'package:abg_pos_app/app/data/models/PromoSetting.dart';
import 'package:get/get.dart';
import '../../data/providers/promo_setting_provider.dart';
import '../../shared/custom_alert.dart';

class PromoSettingRepository extends GetxController {
  PromoSettingRepository({required this.provider});
  final PromoSettingProvider provider;

  Future<List<PromoSetting>> getPromoSettings() async {
    final Response response = await provider.getPromoSettings();
    if (response.hasError) {
      throw Exception(
        'Failed to fetch promo settings: ${response.statusCode} - ${response.statusText ?? ''}',
      );
    }
    return response.body ?? [];
  }

  Future<Map<String, dynamic>> updatePromoSetting(
    String id,
    dynamic data,
  ) async {
    final Response response = await provider.updatePromoSetting(id, data);
    if (response.hasError) {
      customAlertDialog(response.body['message']);
      throw Exception(
        'Failed to update promo setting: ${response.statusCode} - ${response.statusText ?? ''}',
      );
    }
    return {
      'statusCode': response.statusCode,
      'message': response.body['message'],
      'promoSetting': response.body['promoSetting'],
    };
  }
}
