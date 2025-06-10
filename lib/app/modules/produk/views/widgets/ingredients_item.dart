import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project428app/app/modules/produk/controllers/produk_controller.dart';

class IngredientsItem extends StatelessWidget {
  const IngredientsItem({
    super.key,
    required this.list,
    required this.stock,
    required this.name,
    required this.unit,
    required this.qty,
  });

  final List list;
  final String stock;
  final String name;
  final String unit;
  final int qty;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 10),
      color: Colors.grey[50],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Container(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  name,
                  style: TextStyle(fontWeight: FontWeight.w500),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  '${NumberFormat("#,##0", "id_ID").format(qty)}${unit == 'weight'
                      ? 'g'
                      : unit == 'volume'
                      ? 'ml'
                      : 'pcs'}',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
              IconButton(
                padding: EdgeInsets.all(0),
                onPressed: () {
                  list.removeWhere((e) => e['stock'] == stock);
                },
                icon: Icon(
                  Icons.close_rounded,
                  size: 20,
                  color: Colors.redAccent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
