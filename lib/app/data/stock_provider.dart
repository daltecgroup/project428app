import 'dart:convert';

import 'package:get/get.dart';

import '../constants.dart';

class StockProvider extends GetConnect {
  String accessToken = '';
  String url = '$kServerUrl/api/v1/stocks';
  @override
  void onInit() {}

  Future<Response> getStocks() {
    return get('$url/', headers: {"Authorization": "Bearer $accessToken"});
  }

  Future<Response> getStockById(String stockId) {
    return get(
      '$url/$stockId',
      headers: {"Authorization": "Bearer $accessToken"},
    );
  }

  Future<Response> getStockHistory(String stockId) {
    return get(
      '$url/$stockId/history',
      headers: {"Authorization": "Bearer $accessToken"},
    );
  }

  Future<Response> reactivateStock(String stockId) {
    return patch(
      '$url/$stockId/reactivate',
      {},
      headers: {"Authorization": "Bearer $accessToken"},
    );
  }

  Future<Response> deactivateStock(String stockId) {
    return patch(
      '$url/$stockId/deactivate',
      {},
      headers: {"Authorization": "Bearer $accessToken"},
    );
  }

  Future<Response> deleteStock(String stockId) {
    return delete(
      '$url/$stockId',
      headers: {"Authorization": "Bearer $accessToken"},
    );
  }

  Future<Response> updateStock(String stockId, String name, int price) {
    final body = json.encode({"name": name, "price": price});
    return put(
      '$url/$stockId',
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
      '$kServerUrl/api/v1/stocks/',
      body,
      headers: {"Authorization": "Bearer $accessToken"},
    );
  }
}
