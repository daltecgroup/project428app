import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:project428app/app/modules/produk/controllers/produk_controller.dart';

class AddCategoryPageView extends GetView {
  const AddCategoryPageView({super.key, required this.c});

  final ProdukController c;
  @override
  Widget build(BuildContext context) {
    c.isCategoryNameError.value = false;
    c.categoryNameC.clear();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Kategori'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.close_rounded),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 50, left: 12, right: 12),
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(
                    () => TextField(
                      controller: c.categoryNameC,
                      decoration: InputDecoration(
                        labelText: 'Nama Kategori',
                        border: OutlineInputBorder(),
                        error:
                            c.isCategoryNameError.value
                                ? Text(
                                  c.categoryNameErrorText.value,
                                  style: TextStyle(color: Colors.red),
                                )
                                : null,
                      ),
                      onChanged: (value) {
                        c.isCategoryNameError.value = false;
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              height: 50,
              padding: EdgeInsets.only(bottom: 20),
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
                        c.categoryNameC.clear();
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
                        c.createProductCategory();
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
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
