import 'package:abg_pos_app/app/shared/horizontal_sized_box.dart';
import 'package:abg_pos_app/app/utils/constants/app_constants.dart';
import 'package:flutter/material.dart';

class StockInventoryStatus extends StatelessWidget {
  const StockInventoryStatus({
    super.key,
    required this.currentQty,
    this.minimumTreshold,
  });

  final double currentQty;
  final double? minimumTreshold;

  @override
  Widget build(BuildContext context) {
    String text = 'Aman';
    Color colors = Colors.green[800]!;
    IconData icon = Icons.check_circle;

    if (currentQty <= (minimumTreshold ?? 500)) {
      text = 'Sedikit';
      colors = Colors.amber[800]!;
      icon = Icons.warning;
    }
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Row(
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: AppConstants.DEFAULT_FONT_SIZE - 2,
              fontWeight: FontWeight.bold,
              color: colors,
            ),
          ),
          const HorizontalSizedBox(width: 0.2),
          Icon(icon, size: AppConstants.DEFAULT_FONT_SIZE - 2, color: colors),
        ],
      ),
    );
  }
}
