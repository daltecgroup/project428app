import 'package:abg_pos_app/app/utils/constants/app_constants.dart';
import 'package:flutter/material.dart';

class OrderItemStatus extends StatelessWidget {
  const OrderItemStatus({super.key, required this.isAccepted});

  final bool isAccepted;

  @override
  Widget build(BuildContext context) {
    final statusData = _statusDisplay(isAccepted);

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

  Map<String, Object> _statusDisplay(bool status) {
    switch (status) {
      case true:
        return {
          'label': 'Diterima',
          'icon': Icons.check_circle,
          'color': Colors.green[600]!,
        };

      default:
        return {
          'label': 'Belum Diterima',
          'icon': Icons.radio_button_unchecked,
          'color': Colors.grey,
        };
    }
  }
}
