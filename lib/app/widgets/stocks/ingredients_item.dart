import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StockOrderItemWidget extends StatelessWidget {
  const StockOrderItemWidget({
    super.key,
    required this.stock,
    required this.name,
    required this.unit,
    required this.qty,
    required this.price,
    required this.delete,
  });

  final String stock, name, unit;
  final int qty, price;
  final VoidCallback delete;

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
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Text(
                      name,
                      style: TextStyle(fontWeight: FontWeight.w500),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),

                  Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          '${NumberFormat("#,##0", "id_ID").format(qty)}${unit == 'weight'
                              ? ' Kg'
                              : unit == 'volume'
                              ? ' Liter'
                              : ' Pcs'}',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: IconButton(
                      padding: EdgeInsets.all(0),
                      onPressed: delete,
                      icon: Icon(
                        Icons.close_rounded,
                        size: 20,
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Harga', style: TextStyle(fontSize: 10)),
                          Text(
                            'IDR ${NumberFormat("#,##0", "id_ID").format(price)}/${unit == 'weight'
                                ? 'Kg'
                                : unit == 'volume'
                                ? 'Liter'
                                : 'Pcs'}',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Expanded(
                    flex: 3,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('Total', style: TextStyle(fontSize: 10)),
                          Text(
                            'IDR ${NumberFormat("#,##0", "id_ID").format(qty * price)}',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(flex: 1, child: SizedBox()),
                ],
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
