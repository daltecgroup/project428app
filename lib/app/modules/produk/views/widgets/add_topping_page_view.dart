import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:project428app/app/modules/produk/controllers/add_topping_controller.dart';

import '../../../../shared/widgets/custom_textfield_with_error.dart';
import '../../../../shared/widgets/field_error_widget.dart';
import '../../../../shared/widgets/text_header.dart';
import 'ingredients_item.dart';

class AddToppingPageView extends GetView<AddToppingController> {
  const AddToppingPageView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tambah Topping',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back_rounded),
        ),
      ),
      body: Stack(
        children: [
          Obx(
            () => ListView(
              padding: EdgeInsets.symmetric(horizontal: 15),
              children: [
                SizedBox(height: 20),
                Card(
                  color: Colors.white,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  margin: EdgeInsets.all(0),
                  child: Padding(
                    padding: EdgeInsetsGeometry.all(15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomTextfieldWithError(
                          title: 'Kode',
                          controller: controller.codeC,
                          error: controller.codeErr.value,
                          errorText: controller.codeErrorText.value,
                          onChanged: (value) => controller.codeCheck(),
                        ),
                        SizedBox(height: 10),
                        CustomTextfieldWithError(
                          title: 'Nama',
                          controller: controller.nameC,
                          error: controller.nameErr.value,
                          errorText: 'Nama tidak boleh kosong',
                          onChanged: (value) => controller.nameCheck(),
                        ),
                        SizedBox(height: 10),
                        CustomTextfieldWithError(
                          title: 'Harga',
                          controller: controller.priceC,
                          error: controller.priceErr.value,
                          errorText: 'Harga tidak boleh kosong',
                          inputFormatter: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                            LengthLimitingTextInputFormatter(15),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30),

                // Komposisi bahan
                Card(
                  color: Colors.white,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  margin: EdgeInsets.all(0),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Container(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextTitle(text: 'Komposisi Bahan'),
                              TextButton(
                                onPressed: () {
                                  controller.addIngredients();
                                },
                                child: Text('Tambah'),
                              ),
                            ],
                          ),
                          controller.ingredients.isEmpty
                              ? SizedBox()
                              : SizedBox(height: 5),
                          controller.ingredients.isEmpty
                              ? SizedBox()
                              : Column(
                                children: List.generate(
                                  controller.ingredients.length,
                                  (index) => IngredientsItem(
                                    list: controller.ingredients,
                                    stock:
                                        controller.ingredients[index]['stock'],
                                    name: controller.ingredients[index]['name'],
                                    qty: controller.ingredients[index]['qty'],
                                    unit: controller.ingredients[index]['unit'],
                                  ),
                                ),
                              ),
                          FieldErrorWidget(
                            isError: controller.ingredientsErr.value,
                            text: 'Bahan tidak boleh kosong',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50),
              ],
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.only(bottom: 20, left: 15, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: TextButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all(
                        Colors.grey[300],
                      ),
                    ),
                    onPressed: () {
                      Get.back();
                    },
                    child: Text('Kembali', style: TextStyle(fontSize: 16)),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                    ),
                    onPressed: () {
                      controller.submitCheck();
                    },
                    child: Text(
                      'Simpan',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
