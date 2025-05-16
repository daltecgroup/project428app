import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/stock_data.dart';

Widget StokItem(Stock stock) {
  return Card(
    color: Colors.white,
    margin: const EdgeInsets.only(bottom: 8, left: 12, right: 12),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    child: InkWell(
      onTap: () {
        Get.toNamed('detail-stok', arguments: stock);
      },
      child: Row(
        children: [
          // Container(
          //   padding: EdgeInsets.only(right: 12),
          //   height: 86,
          //   width: 90,
          //   child: ClipRRect(
          //     borderRadius: BorderRadius.only(
          //       topLeft: Radius.circular(8),
          //       bottomLeft: Radius.circular(8),
          //     ),
          //     child: Image.network(
          //       fit: BoxFit.cover,
          //       'https://placebear.com/250/250',
          //       webHtmlElementStrategy: WebHtmlElementStrategy.prefer,
          //     ),
          //   ),
          // ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 12,
                right: 12,
                bottom: 10,
                top: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          stock.name,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                      // PopupMenuButton(
                      //   icon: Icon(Icons.more_horiz),
                      //   itemBuilder:
                      //       (context) => [
                      //         PopupMenuItem(
                      //           child: const Text('Sesuaikan Harga'),
                      //           onTap: () => print('tapOne'),
                      //         ),
                      //         PopupMenuItem(child: Text('Nonaktifkan')),
                      //       ],
                      // ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Kode',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              stock.stockId,
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Harga',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              stock.getPriceWithUnit(),
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Diperbarui',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              stock.getLastUpdateTime(),
                              style: TextStyle(fontWeight: FontWeight.w500),
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
  );
}
