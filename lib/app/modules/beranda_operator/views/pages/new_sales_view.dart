import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:project428app/app/constants.dart';
import 'package:project428app/app/modules/beranda_operator/views/pages/select_menu_view.dart';

class NewSalesView extends GetView {
  const NewSalesView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'TRX25040013',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              // Get.offNamed('/beranda-operator');
            },
            icon: Icon(Icons.delete, color: Colors.red[700]),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 15, right: 15, top: 15),
        child: Column(
          children: [
            // new transactions indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Card(
                    color: Colors.white,
                    elevation: 1,
                    margin: EdgeInsets.symmetric(horizontal: 0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 5,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Item', style: TextStyle(fontSize: 10)),
                              Text(
                                '3',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Promo', style: TextStyle(fontSize: 10)),
                              Text(
                                '1',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Hemat', style: TextStyle(fontSize: 10)),
                              Text(
                                'IDR 5.100',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Total', style: TextStyle(fontSize: 10)),
                              Text(
                                'IDR 45.000',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            // sales item
            SalesItemWidget(),
            SalesItemWidget(),
            SalesItemWidget(),
            SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 40,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      onPressed: () {
                        Get.off(() => SelectMenuView());
                      },
                      child: Text('+ Tambah Item'),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            // promo available
            PromoItemWidget(available: true, title: 'Beli 2 Gratis 1'),
            PromoItemWidget(
              available: false,
              title: 'Belanja Minimal 50rb gratis 1 item max 15rb',
            ),
            SizedBox(height: 20),
            Container(
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.only(bottom: 20, left: 0, right: 0),
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
                        Get.offNamed('/beranda-operator');
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
                      ),
                      onPressed: () {},
                      child: Text('Pembayaran', style: TextStyle(fontSize: 16)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      //   onPressed: () {
      //     Get.off(() => SelectMenuView());
      //   },
      //   child: Icon(Icons.add),
      // ),
    );
  }
}

class PromoItemWidget extends StatelessWidget {
  const PromoItemWidget({
    super.key,
    required this.available,
    required this.title,
  });

  final bool available;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: DottedBorder(
              options: RoundedRectDottedBorderOptions(
                radius: Radius.circular(10),
                dashPattern: [6, 4],
                color: available ? Colors.teal[900]! : Colors.grey[400]!,
              ),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: available ? Colors.teal[50] : Colors.grey[100],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              available
                                  ? 'PROMO TERSEDIA!'
                                  : 'PROMO BELUM TERSEDIA',
                              style: TextStyle(
                                color:
                                    available ? Colors.teal[800] : Colors.grey,
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              title,
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color:
                                    available ? Colors.teal[900] : Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Material(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () {},
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SalesItemWidget extends StatelessWidget {
  const SalesItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Card(
            color: Colors.white,
            elevation: 1,
            margin: EdgeInsets.only(bottom: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 15, right: 5, top: 15, bottom: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Sales item image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                          height: 45,
                          width: 45,
                          child: SvgPicture.asset(
                            kImgPlaceholder,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Coklat Keju',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            Text('+ Abon Ayam', style: TextStyle(fontSize: 12)),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    '10%',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                    ),
                                  ),
                                  SizedBox(width: 3),
                                  Text(
                                    '4.500',
                                    style: TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                '4.300',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  // SizedBox(height: 5),
                  // Text('"Less Sugar"', style: TextStyle(fontSize: 14)),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          TextButton(
                            style: ButtonStyle(
                              padding: WidgetStatePropertyAll(
                                EdgeInsets.all(5),
                              ),
                            ),
                            onPressed: () {},
                            child: Text(
                              '+ Topping',
                              style: TextStyle(fontSize: 10),
                            ),
                          ),
                          TextButton(
                            style: ButtonStyle(
                              padding: WidgetStatePropertyAll(
                                EdgeInsets.all(5),
                              ),
                            ),
                            onPressed: () {},
                            child: Text(
                              '+ Catatan',
                              style: TextStyle(fontSize: 10),
                            ),
                          ),
                          TextButton(
                            style: ButtonStyle(
                              padding: WidgetStatePropertyAll(
                                EdgeInsets.all(5),
                              ),
                            ),
                            onPressed: () {},
                            child: Text(
                              '+ Hapus',
                              style: TextStyle(fontSize: 10),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            color: Colors.red[700],
                            onPressed: () {},
                            icon: Icon(Icons.remove_circle),
                          ),
                          SizedBox(width: 5),
                          Text('2'),
                          SizedBox(width: 5),
                          IconButton(
                            color: Colors.green,
                            onPressed: () {},
                            icon: Icon(Icons.add_circle),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
