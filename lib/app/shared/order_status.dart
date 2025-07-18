import 'package:flutter/material.dart';
import '../utils/constants/app_constants.dart';
import '../utils/constants/order_constants.dart';

class OrderStatus extends StatelessWidget {
  const OrderStatus({super.key, required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    final statusData = _statusDisplay(status);

    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            statusData['label'].toString(),
            style: TextStyle(
              fontSize: AppConstants.DEFAULT_FONT_SIZE - 2,
              fontWeight: FontWeight.bold,
              color: statusData['color'] as Color,
            ),
          ),
          const SizedBox(width: 4),
          Icon(
            statusData['icon'] as IconData,
            size: AppConstants.DEFAULT_FONT_SIZE - 2,
            color: statusData['color'] as Color,
          ),
        ],
      ),
    );
  }

  Map<String, Object> _statusDisplay(String status) {
    switch (status) {
      case OrderConstants.ORDERED:
        return {
          'label': 'Dipesan',
          'icon': Icons.shopping_cart,
          'color': Colors.orange,
        };
      case OrderConstants.PROCESSED:
        return {'label': 'Diproses', 'icon': Icons.sync, 'color': Colors.blue};
      case OrderConstants.ON_THE_WAY:
        return {
          'label': 'Dalam Perjalanan',
          'icon': Icons.local_shipping,
          'color': Colors.teal,
        };
      case OrderConstants.ACCEPTED:
        return {
          'label': 'Diterima',
          'icon': Icons.check_circle,
          'color': Colors.green,
        };
      case OrderConstants.RETURNED:
        return {
          'label': 'Dikembalikan',
          'icon': Icons.undo,
          'color': Colors.deepPurple,
        };
      case OrderConstants.FAILED:
        return {'label': 'Gagal', 'icon': Icons.cancel, 'color': Colors.red};
      default:
        return {
          'label': 'Tidak Diketahui',
          'icon': Icons.help_outline,
          'color': Colors.grey,
        };
    }
  }
}
