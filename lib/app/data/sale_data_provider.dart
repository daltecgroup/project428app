import 'dart:convert';

import 'package:get/get.dart';
import 'package:project428app/app/models/new_sales_item.dart';

import '../services/auth_service.dart';

class SaleDataProvider extends GetConnect {
  AuthService authS = Get.find<AuthService>();
  @override
  void onInit() {}

  Future<Response> createSale(
    String code,
    List<NewSalesItem> items,
    int finalPrice,
    int basePrice,
    int saving,
    int paid,
    int change,
    String outlet,
    String cashier,
    String paymentMethod,
    int promoUsed,
  ) {
    final body = json.encode({
      'code': code,
      'items':
          items.map((item) {
            return {
              'product': item.product.id,
              'type': item.type,
              'name': item.product.name,
              'qty': item.qty.value,
              'price': item.product.price,
              'finalPrice': item.getPriceAfterDiscount(),
              'totalFinalPrice': item.getTotalPriceAfterDiscount(),
              'discount': item.product.discount,
              'saving': item.getSaving(),
              'totalSaving': item.getTotalSaving(),
            };
          }).toList(),
      'finalPrice': finalPrice,
      'basePrice': basePrice,
      'saving': saving,
      'paid': paid,
      'change': change,
      'outlet': outlet,
      'cashier': cashier,
      'paymentMethod': paymentMethod,
      'promoUsed': promoUsed,
    });
    return post('${authS.mainServerUrl.value}/api/v1/sales/', body);
  }

  Future<Response> getSales() {
    return get('${authS.mainServerUrl.value}/api/v1/sales/');
  }

  Future<Response> getSaleById(String id) {
    return get('${authS.mainServerUrl.value}/api/v1/sales/$id');
  }

  Future<Response> getSalesByOutlet(String outlet) {
    return get('${authS.mainServerUrl.value}/api/v1/sales/outlet/$outlet');
  }

  Future<Response> getTodaySalesByOutlet(String outlet) {
    return get(
      '${authS.mainServerUrl.value}/api/v1/sales/outlet/$outlet/today',
    );
  }
}
