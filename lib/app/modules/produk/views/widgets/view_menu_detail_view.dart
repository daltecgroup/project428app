import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:project428app/app/models/product.dart';
import 'package:project428app/app/models/stock.dart';
import 'package:project428app/app/widgets/status_sign.dart';

import '../../../../constants.dart';
import '../../../../style.dart';
import '../../../../widgets/text_header.dart';
import '../../controllers/produk_controller.dart';
import 'ingredients_item.dart';

class MenuDetailView extends GetView {
  const MenuDetailView({super.key, required this.c, required this.product});

  final ProdukController c;
  final Product product;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail Produk',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () {
            // Save action
            Get.back();
          },
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await c.ProductP.getProductById('P01').then((res) {
                Product product = Product.fromJson(res.body);
                print((product.ingredients[0]['stock'] as Stock).name);
              });
            },
            icon: Icon(Icons.refresh_rounded),
          ),
          IconButton(
            onPressed: () async {
              c.deleteProduct(product.code, product.name);
            },
            icon: Icon(Icons.delete, color: Colors.red[900]),
          ),
          // IconButton(
          //   onPressed: () {
          //     c.resetAddMenuField();
          //     Get.back();
          //   },
          //   icon: Icon(Icons.close_rounded),
          // ),
          SizedBox(width: 10),
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              SizedBox(height: 20),

              // product image
              Material(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                ),
                elevation: 2,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    topLeft: Radius.circular(10),
                  ),
                  child: Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.only(),
                        height: Get.width - 30,
                        width: double.infinity,
                        child: Image.network(
                          fit: BoxFit.cover,
                          '$kServerUrl/api/v1/${product.imgUrl}',
                          webHtmlElementStrategy: WebHtmlElementStrategy.prefer,
                        ),
                      ),
                      Positioned(
                        right: 5,
                        top: 5,
                        child: IconButton(
                          tooltip: 'Ubah Gambar',
                          style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(
                              Colors.black12,
                            ),
                            iconColor: WidgetStatePropertyAll(Colors.black87),
                          ),
                          onPressed: () {},
                          icon: Icon(Icons.edit),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // product data
              Card(
                color: Colors.white,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                margin: EdgeInsets.all(0),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextTitle(text: 'Kode'),
                              Text(product.code),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              TextTitle(text: 'Diperbarui'),
                              Text(
                                '${product.getUpdateDate()} ${product.getUpdateTime()}',
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextTitle(text: 'Nama'),
                              Text(product.name),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              TextTitle(text: 'Harga Awal'),
                              Text(product.getPriceInRupiah()),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextTitle(text: 'Kategori'),
                              Text(product.category.name),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              TextTitle(text: 'Diskon'),
                              Text(
                                product.discount > 0
                                    ? '${product.discount.toString()}%'
                                    : '-',
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextTitle(text: 'Status'),
                              StatusSign(status: product.isActive, size: 16),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              TextTitle(text: 'Harga Akhir'),
                              Text(product.getPriceInRupiahAfterDiscount()),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextTitle(text: 'Deskripsi '),
                                Text(
                                  product.description,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: TextButton(
                              onPressed: () {
                                Get.defaultDialog(
                                  title: 'Peringatan',
                                  titleStyle: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  content: Text(
                                    'Fitur ubah belum terhubung dengan server',
                                  ),
                                  radius: 10,
                                );
                              },
                              style: PrimaryButtonStyle(Colors.blue),
                              child: Text('Ubah Data'),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: TextButton(
                              onPressed: () {},
                              style: PrimaryButtonStyle(Colors.red[400]!),
                              child: Text('Nonaktifkan'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20),

              // product ingredients
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextTitle(text: 'Komposisi Bahan'),
                          TextButton(onPressed: () {}, child: Text('Tambah')),
                        ],
                      ),
                      Column(
                        children: List.generate(
                          product.ingredients.length,
                          (index) => IngredientsItem(
                            c: c,
                            stock:
                                (product.ingredients[index]['stock'] as Stock)
                                    .id,
                            name:
                                (product.ingredients[index]['stock'] as Stock)
                                    .name,
                            qty: product.ingredients[index]['qty'],
                            unit:
                                (product.ingredients[index]['stock'] as Stock)
                                    .unit,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
