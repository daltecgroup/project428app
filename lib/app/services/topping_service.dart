import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../data/models/topping.dart';
import '../data/providers/topping_provider.dart';
import '../shared/widgets/alert_dialog.dart';

class ToppingService extends GetxService {
  ToppingProvider ToppingP = ToppingProvider();
  RxList<Topping> toppings = <Topping>[].obs;

  RxBool isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
    getAllToppings();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> createTopping(
    String code,
    String name,
    int price,
    List ingredients,
    VoidCallback? callback,
  ) async {
    var data = json.encode({
      'code': code,
      'name': name,
      'price': price,
      'ingredients':
          ingredients
              .map(
                (e) => {
                  'stock': e['stock'],
                  'name': e['name'],
                  'unit': e['unit'],
                  'price': e['price'],
                  'qty': e['qty'],
                },
              )
              .toList(),
    });
    Response res = await ToppingP.createTopping(data);

    if (res.statusCode == 201) {
      await getAllToppings();
      if (callback != null) {
        callback();
      }
    } else {
      CustomAlertDialog('Gagal Menambahkan Topping', res.body['message']);
    }
  }

  Future<void> getAllToppings() async {
    try {
      isLoading.value = true;
      Response res = await ToppingP.getAllToppings();
      if (res.statusCode == 200) {
        toppings.clear();
        for (var e in res.body) {
          toppings.add(Topping.fromJson(e));
        }
      } else {
        CustomAlertDialog('Peringatan', res.body['message']);
      }
    } catch (e) {
      CustomAlertDialog('Peringatan', e.toString());
    }
    toppings.value = toppings.reversed.toList();
    Future.delayed(
      Duration(milliseconds: 500),
    ).then((_) => isLoading.value = false);
  }

  List<Topping> get activeTopping {
    List<Topping> list = [];

    if (toppings.isNotEmpty) {
      list = toppings.where((topping) => topping.isActive == true).toList();
    }
    return list;
  }

  List<Topping> get deactiveTopping {
    List<Topping> list = [];

    if (toppings.isNotEmpty) {
      list = toppings.where((topping) => topping.isActive == false).toList();
    }
    return list;
  }
}
