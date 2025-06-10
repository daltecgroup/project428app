import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:project428app/app/services/stock_service.dart';
import 'package:project428app/app/services/topping_service.dart';

import '../../../data/models/stock.dart';
import '../../../shared/widgets/text_header.dart';
import '../../../style.dart';

class AddToppingController extends GetxController {
  StockService StockS = Get.find<StockService>();
  ToppingService ToppingS = Get.find<ToppingService>();
  late TextEditingController codeC;
  late TextEditingController nameC;
  late TextEditingController priceC;

  RxList ingredients = [].obs;

  RxBool codeErr = false.obs;
  RxBool nameErr = false.obs;
  RxBool priceErr = false.obs;
  RxBool ingredientsErr = false.obs;

  RxString codeErrorText = ''.obs;

  RxBool status = true.obs;

  @override
  void onInit() {
    super.onInit();
    codeC = TextEditingController();
    nameC = TextEditingController();
    priceC = TextEditingController();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    codeC.dispose();
    nameC.dispose();
    priceC.dispose();
  }

  void codeCheck() {
    if (codeC.text.isEmpty) {
      codeErr.value = true;
      codeErrorText.value = 'Kode tidak boleh kosong';
    } else {
      codeErr.value = false;
    }
  }

  void nameCheck() {
    if (nameC.text.isEmpty) {
      nameErr.value = true;
    } else {
      nameErr.value = false;
    }
  }

  void ingredientsCheck() {
    if (ingredients.isEmpty) {
      ingredientsErr.value = true;
    } else {
      ingredientsErr.value = false;
    }
  }

  void submitCheck() {
    codeCheck();
    nameCheck();
    ingredientsCheck();
    if (codeErr.isFalse &&
        nameErr.isFalse &&
        priceErr.isFalse &&
        ingredientsErr.isFalse) {
      ToppingS.createTopping(
        codeC.text.trim().toUpperCase(),
        nameC.text.trim().capitalize!,
        int.parse(priceC.text.isEmpty ? '0' : priceC.text),
        ingredients,
        () {
          print('this');
          Get.offNamed('/produk');
        },
      );
    }
  }

  void addIngredients() {
    TextEditingController qtyC = TextEditingController();

    var list =
        StockS.stocks.where((e) {
          if (e.isActive == false) {
            return false;
          } else {
            if (ingredients.isEmpty) {
              return true;
            } else {
              for (var el in ingredients) {
                if (e.id == el['stock']) {
                  return false;
                }
              }
              return true;
            }
          }
        }).toList();
    if (list.isEmpty) {
      Get.defaultDialog(
        title: 'Peringatan',
        titleStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        content: Text('Semua bahan telah ditambahkan'),
        radius: 12,
      );
    } else {
      Rx<Stock> selected = list.first.obs;
      Get.defaultDialog(
        backgroundColor: Colors.white,
        title: "Tambah Bahan",
        titleStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        radius: 8,
        content: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextTitle(text: 'Bahan'),
              SizedBox(height: 5),
              Material(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: DropdownButtonFormField<String>(
                  value: selected.value.id,
                  decoration: TextFieldDecoration1(),
                  items: [
                    ...List.generate(
                      list.length,
                      (index) => DropdownMenuItem(
                        value: list[index].id,
                        child: Text(list[index].name),
                      ),
                    ),
                  ],
                  onChanged: (value) {
                    selected.value = StockS.stocks.firstWhere(
                      (e) => e.id == value,
                    );
                  },
                ),
              ),
              SizedBox(height: 10),
              Obx(
                () => TextTitle(
                  text:
                      'Komposisi (${StockS.stocks.firstWhere((e) => e.id == selected.value.id).unit == 'weight'
                          ? 'gram'
                          : StockS.stocks.firstWhere((e) => e.id == selected.value.id).unit == 'volume'
                          ? 'mililiter'
                          : 'pcs'})',
                ),
              ),
              SizedBox(height: 5),
              Material(
                elevation: 2,
                borderRadius: BorderRadius.circular(8),
                child: TextField(
                  controller: qtyC,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                  ],
                  onChanged: (value) {
                    if (int.parse(value) > 9999) {
                      Get.defaultDialog(
                        title: 'Peringatan',
                        titleStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                        content: Text('Kuantitas terlalu besar'),
                        radius: 12,
                      );
                    }
                  },
                  decoration: TextFieldDecoration1(),
                ),
              ),
            ],
          ),
        ),
        confirm: TextButton(
          onPressed: () async {
            if (qtyC.text.isNotEmpty) {
              ingredients.add({
                'stock': selected.value.id,
                'name': selected.value.name,
                'unit': selected.value.unit,
                'price': selected.value.price,
                'qty': int.parse(qtyC.text),
              });
              if (ingredients.isNotEmpty) {
                ingredientsErr.value = false;
              }
              qtyC.dispose();
              Get.back();
            } else {
              Get.back();
              if (ingredients.isNotEmpty) {
                ingredientsErr.value = false;
              }
            }
          },
          child: Text("Simpan"),
        ),
        cancel: TextButton(
          onPressed: () {
            qtyC.dispose();
            Get.back();
          },
          child: Text("Batal"),
        ),
      );
    }
  }
}
