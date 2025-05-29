import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:project428app/app/widgets/text_header.dart';

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
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              // Save action
              controller.resetField();
              Get.offNamed('/stok');
            },
          ),
          SizedBox(width: 10),
        ],
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
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                            controller: controller.stockIdC,
                            decoration: InputDecoration(
                              labelText: 'Kode Stok',
                              border: OutlineInputBorder(),
                              error:
                                  controller.isStockIdError.value
                                      ? Text(
                                        controller.stockIdErrorText.value,
                                        style: TextStyle(color: Colors.red),
                                      )
                                      : null,
                            ),
                            onChanged: (value) {
                              controller.isStockIdError.value = false;
                              if (value.length > 1 && value[0] == '0') {
                                controller.stockIdC.text = controller
                                    .stockIdC
                                    .text
                                    .substring(1);
                              }
                            },
                          ),
                          SizedBox(height: 20),
                          TextField(
                            controller: controller.nameC,
                            decoration: InputDecoration(
                              labelText: 'Nama',
                              border: OutlineInputBorder(),
                              error:
                                  controller.isNameError.value
                                      ? Text(
                                        'Nama tidak boleh kosong',
                                        style: TextStyle(color: Colors.red),
                                      )
                                      : null,
                            ),
                            onChanged: (value) {
                              controller.isNameError.value = false;
                            },
                          ),
                          SizedBox(height: 20),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: DropdownButtonFormField<String>(
                                  value: controller.unit.value,
                                  alignment: AlignmentDirectional.centerStart,
                                  decoration: InputDecoration(
                                    labelText: 'Satuan Ukur',
                                    border: OutlineInputBorder(),
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
                              SizedBox(width: 10),
                              Expanded(
                                child: TextField(
                                  controller: controller.priceC,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                      RegExp("[0-9]"),
                                    ),
                                  ],
                                  decoration: InputDecoration(
                                    labelText:
                                        controller.unit.value == 'weight'
                                            ? 'Harga 1000g/1kg'
                                            : controller.unit.value == 'volume'
                                            ? 'Harga 1000ml/1 Liter'
                                            : 'Harga satuan',
                                    border: OutlineInputBorder(),
                                    error:
                                        controller.isPriceError.value
                                            ? Text(
                                              'Harga harus diisi',
                                              style: TextStyle(
                                                color: Colors.red,
                                              ),
                                            )
                                            : null,
                                  ),
                                  onChanged: (value) {
                                    controller.isPriceError.value = false;
                                    if (value.isNotEmpty) {
                                      controller.price.value = double.parse(
                                        value,
                                      );
                                    } else {
                                      controller.price.value = 0.0;
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          controller.unit.value == 'weight'
                              ? PriceInfoWeight(controller: controller)
                              : controller.unit.value == 'volume'
                              ? PriceInfoVolume(controller: controller)
                              : PriceInfoPcs(controller: controller),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  Container(
                    alignment: Alignment.bottomCenter,
                    height: 50,
                    padding: EdgeInsets.only(bottom: 20, left: 15, right: 15),
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
