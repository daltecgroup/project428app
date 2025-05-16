import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project428app/app/modules/produk/views/view_menu_detail_view.dart';

import '../../../widgets/status_sign.dart';
import '../controllers/produk_controller.dart';

class MenuItemWidget extends StatelessWidget {
  const MenuItemWidget({super.key, required this.c});
  final ProdukController c;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      child: Stack(
        children: [
          Column(
            children: [
              Card(
                color: Colors.white,
                margin: const EdgeInsets.only(bottom: 0, left: 0, right: 0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.only(right: 12),
                      height: 100,
                      width: 110,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          bottomLeft: Radius.circular(0),
                        ),
                        child: Image.network(
                          fit: BoxFit.cover,
                          'https://placebear.com/250/250',
                          webHtmlElementStrategy: WebHtmlElementStrategy.prefer,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 8,
                          bottom: 8,
                          right: 12,
                          left: 0,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Coklat Keju",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text("P011", style: TextStyle(fontSize: 12)),
                            SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Diskon",
                                        style: TextStyle(fontSize: 10),
                                      ),
                                      Text(
                                        "10%",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.redAccent,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Harga Awal",
                                        style: TextStyle(fontSize: 10),
                                      ),
                                      RichText(
                                        textAlign: TextAlign.start,
                                        text: TextSpan(
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: 'IDR 17.000',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black,
                                                decoration:
                                                    TextDecoration.lineThrough,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Harga Akhir",
                                        style: TextStyle(fontSize: 10),
                                      ),
                                      RichText(
                                        textAlign: TextAlign.start,
                                        text: TextSpan(
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: 'IDR 15.300',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                color: Colors.grey[200],
                margin: EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(0),
                    topRight: Radius.circular(0),
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 8,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      StatusSign(status: true, size: 14),
                      Text(
                        'Diperbarui pada 12 Mei 2025 15.02 WIB',
                        style: TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                onTap: () {
                  Get.to(ViewMenuDetailView(c: c));
                },
                onLongPress: () {
                  Get.defaultDialog();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
