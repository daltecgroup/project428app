import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:project428app/app/shared/widgets/custom_textfield_with_error.dart';
import 'package:project428app/app/shared/widgets/text_header.dart';

import '../controllers/tambah_stok_controller.dart';

class TambahStokView extends GetView<TambahStokController> {
  const TambahStokView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tambah Stok',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            controller.resetField();
            Get.back();
          },
          icon: Icon(Icons.arrow_back_rounded),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 50, left: 15, right: 15),
        height: double.infinity,
        child: Obx(
          () => Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Card(
                color: Colors.white,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                margin: EdgeInsets.all(0),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextfieldWithError(
                        controller: controller.stockIdC,
                        title: 'Kode Stok',
                        error: controller.isStockIdError.value,
                        errorText: controller.stockIdErrorText.value,
                        onChanged: (value) {
                          controller.isStockIdError.value = false;
                          if (value.length > 1 && value[0] == '0') {
                            controller.stockIdC.text = controller.stockIdC.text
                                .substring(1);
                          }
                        },
                      ),
                      SizedBox(height: 10),
                      CustomTextfieldWithError(
                        controller: controller.nameC,
                        title: 'Nama',
                        error: controller.isNameError.value,
                        errorText: 'Nama tidak boleh kosong',
                        onChanged: (value) {
                          controller.isNameError.value = false;
                        },
                      ),
                      SizedBox(height: 10),
                      TextTitle(text: 'Satuan Ukur'),
                      SizedBox(height: 5),
                      Material(
                        elevation: 1,
                        borderRadius: BorderRadius.circular(8),
                        child: DropdownButtonFormField<String>(
                          value: controller.unit.value,
                          alignment: AlignmentDirectional.centerStart,
                          decoration: InputDecoration(
                            isDense: true,
                            filled: true,
                            fillColor: Colors.grey[50],
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                style: BorderStyle.solid,
                                color: Colors.transparent,
                              ),
                            ),
                          ),
                          items: [
                            DropdownMenuItem(
                              value: 'weight',
                              child: Text('Berat (gram)'),
                            ),
                            DropdownMenuItem(
                              value: 'volume',
                              child: Text('Volume (ml)'),
                            ),
                            DropdownMenuItem(
                              value: 'pcs',
                              child: Text('Pcs (Satuan)'),
                            ),
                          ],
                          onChanged: (value) {
                            controller.unit.value = value!;
                          },
                        ),
                      ),
                      SizedBox(height: 10),
                      CustomTextfieldWithError(
                        controller: controller.priceC, 
                        title: controller.unit.value == 'weight'
                                  ? 'Harga 1000g/1kg'
                                  : controller.unit.value == 'volume'
                                  ? 'Harga 1000ml/1 Liter'
                                  : 'Harga satuan', 
                        error: controller.isPriceError.value, 
                        errorText: 'Harga harus diisi',
                        inputFormatter: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                        ],
                        onChanged: (value) {
                          controller.isPriceError.value = false;
                          if (value.isNotEmpty) {
                            controller.price.value = double.parse(value);
                          } else {
                            controller.price.value = 0.0;
                          }
                        },
                        ),
                      SizedBox(height: 10),
                      controller.unit.value == 'weight'
                          ? PriceInfoWeight(controller: controller)
                          : controller.unit.value == 'volume'
                          ? PriceInfoVolume(controller: controller)
                          : PriceInfoPcs(controller: controller),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  Container(
                    alignment: Alignment.bottomCenter,
                    height: 100,
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
                              controller.resetField();
                              Get.offNamed('/stok');
                            },
                            child: Text(
                              'Kembali',
                              style: TextStyle(fontSize: 16),
                            ),
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
                              backgroundColor: MaterialStateProperty.all(
                                Colors.blue,
                              ),
                            ),
                            onPressed: () {
                              controller.createStock();
                            },
                            child: Text(
                              'Simpan',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PriceInfoWeight extends StatelessWidget {
  const PriceInfoWeight({super.key, required this.controller});

  final TambahStokController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextTitle(text: 'Harga 1 g'),
              Text(
                'IDR ${NumberFormat("#,##0.00", "id_ID").format(controller.price / 1000)}',
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextTitle(text: 'Harga 100 g'),
              Text(
                'IDR ${NumberFormat("#,##0.0", "id_ID").format(controller.price / 10)}',
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextTitle(text: 'Harga 1000g/1Kg'),
              Text(
                'IDR ${NumberFormat("#,##0", "id_ID").format(controller.price / 1)}',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PriceInfoVolume extends StatelessWidget {
  const PriceInfoVolume({super.key, required this.controller});

  final TambahStokController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextTitle(text: 'Harga 1 ml'),
              Text(
                'IDR ${NumberFormat("#,##0.00", "id_ID").format(controller.price / 1000)}',
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextTitle(text: 'Harga 100 ml'),
              Text(
                'IDR ${NumberFormat("#,##0.0", "id_ID").format(controller.price / 10)}',
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextTitle(text: 'Harga 1000ml/1L'),
              Text(
                'IDR ${NumberFormat("#,##0", "id_ID").format(controller.price / 1)}',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PriceInfoPcs extends StatelessWidget {
  const PriceInfoPcs({super.key, required this.controller});

  final TambahStokController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextTitle(text: 'Harga 1 pcs'),
          Text(
            'IDR ${NumberFormat("#,##0", "id_ID").format(controller.price / 1)}',
          ),
        ],
      ),
    );
  }
}
