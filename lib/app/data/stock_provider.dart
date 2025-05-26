import 'dart:convert';

import 'package:get/get.dart';
import '../services/auth_service.dart';

class StockProvider extends GetConnect {
  AuthService authS = Get.find<AuthService>();
  String accessToken = '';

  Future<Response> getStocks() {
    return get(
      '${authS.mainServerUrl.value}/api/v1/stocks/',
      headers: {"Authorization": "Bearer $accessToken"},
    );
  }

  Future<Response> getStockById(String stockId) {
    return get(
      '${authS.mainServerUrl.value}/api/v1/stocks/$stockId',
      headers: {"Authorization": "Bearer $accessToken"},
    );
  }

  Future<Response> getStockHistory(String stockId) {
    return get(
      '${authS.mainServerUrl.value}/api/v1/stocks/$stockId/history',
      headers: {"Authorization": "Bearer $accessToken"},
    );
  }

  Future<Response> reactivateStock(String stockId) {
    return put(
      '${authS.mainServerUrl.value}/api/v1/stocks/$stockId/reactivate',
      {},
      headers: {"Authorization": "Bearer $accessToken"},
    );
  }

  Future<Response> deactivateStock(String stockId) {
    return put(
      '${authS.mainServerUrl.value}/api/v1/stocks/$stockId/deactivate',
      {},
      headers: {"Authorization": "Bearer $accessToken"},
    );
  }

  Future<Response> deleteStock(String stockId) {
    return delete(
      '${authS.mainServerUrl.value}/api/v1/stocks/$stockId',
      headers: {"Authorization": "Bearer $accessToken"},
    );
  }

  Future<Response> updateStock(String stockId, String name, int price) {
    final body = json.encode({"name": name, "price": price});
    return put(
      '${authS.mainServerUrl.value}/api/v1/stocks/$stockId',
      body,
      headers: {"Authorization": "Bearer $accessToken"},
    );
  }

  Future<Response> createStock(
    String stockId,
    String name,
    String unit,
    int price,
  ) {
    final body = json.encode({
      "stockId": stockId,
      "name": name,
      "unit": unit,
      "isActive": true,
      "price": price,
    });

    return post(
      '${authS.mainServerUrl.value}/api/v1/stocks/api/v1/stocks/',
      body,
      headers: {"Authorization": "Bearer $accessToken"},
    );
  }
}
