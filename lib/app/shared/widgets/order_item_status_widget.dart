import 'package:flutter/material.dart';

Widget OrderItemStatusWidget(String status, bool badge) {
  String title = status;
  Color color = Colors.blue;

  // 'ordered', 'processed', 'ontheway', 'accepted', 'returned', 'failed'
  switch (status) {
    case 'ordered':
      title = 'Dipesan';
      color = Colors.amber;
      break;
    case 'processed':
      title = 'Diproses';
      color = Colors.orange;
      break;
    case 'ontheway':
      title = 'Dalam Perjalanan';
      color = Colors.blue;
      break;
    case 'accepted':
      title = 'Diterima';
      color = Colors.green;
      break;
    case 'returned':
      title = 'Dikembalikan';
      color = Colors.red;
      break;
    case 'failed':
      title = 'Gagal';
      color = Colors.redAccent;
      break;
    default:
  }

  return badge
      ? Badge(
        backgroundColor: color,
        padding: EdgeInsets.symmetric(vertical: 2, horizontal: 6),
        label: Text(
          title,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 10),
        ),
      )
      : Wrap(
        children: [
          Badge(
            backgroundColor: color,
            padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
            label: Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
            ),
          ),
        ],
      );
}
