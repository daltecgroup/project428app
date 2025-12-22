import 'package:flutter/material.dart';

class RequestSubtitle extends StatelessWidget {
  const RequestSubtitle({
    super.key,
    required this.type,
    this.targetCode
  });

  final String type;
  final String? targetCode;

  @override
  Widget build(BuildContext context) {

    switch (type) {
      case 'delete_order':
      return Text('Hapus Pesanan ${targetCode ?? ''}');
      default:
    return Text('Hapus Penjualan ${targetCode ??''}');
    }


  }
}
