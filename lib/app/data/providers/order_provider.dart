import 'dart:convert';

import 'package:get/get.dart';

import '../../services/auth_service.dart';

class OrderProvider extends GetConnect {
  AuthService authS = Get.find<AuthService>();

  Future<Response> createOrder(String outlet, List items, int total) {
    final body = json.encode({
      'outlet': outlet,
      'items':
          items.map((item) {
            return {
              'stock': item['stock'],
              'name': item['name'],
              'qty': item['qty'],
              'price': item['price'],
            };
          }).toList(),
      'total': total,
    });
    return post('${authS.mainServerUrl.value}/api/v1/orders/', body);
  }

  Future<Response> getOrders() {
    return get('${authS.mainServerUrl.value}/api/v1/orders/');
  }

  Future<Response> geOrderById(String id) {
    return get('${authS.mainServerUrl.value}/api/v1/orders/$id');
  }

  Future<Response> getOrdersByOutlet(String outlet) {
    return get('${authS.mainServerUrl.value}/api/v1/orders/outlet/$outlet');
  }

  Future<Response> getTodayOrdersByOutlet(String outlet) {
    return get(
      '${authS.mainServerUrl.value}/api/v1/orders/outlet/$outlet/today',
    );
  }

  Future<Response> updateOrderById(String code, dynamic body) {
    return put('${authS.mainServerUrl.value}/api/v1/orders/$code', body);
  }

  Future<Response> deleteOrderById(String code) {
    return delete('${authS.mainServerUrl.value}/api/v1/orders/$code');
  }
}
