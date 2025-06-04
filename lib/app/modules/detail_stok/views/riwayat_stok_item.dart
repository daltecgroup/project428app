import 'package:flutter/material.dart';

import '../../../models/stock_history.dart';

Widget RiwayatStokItem(StockHistory stockHistory, bool last, bool first) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          first
              ? SizedBox(height: 5)
              : Container(width: 1, height: 5, color: Colors.grey),
          // SizedBox(height: 4),
          Icon(Icons.circle_rounded, size: 12, color: Colors.grey),
          // Text("|"),
          last
              ? SizedBox()
              : Container(width: 1, height: 50, color: Colors.grey),
        ],
      ),
      SizedBox(width: 10),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              stockHistory.getCreateTime(),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(stockHistory.content, overflow: TextOverflow.clip),
          ],
        ),
      ),
    ],
  );
}
