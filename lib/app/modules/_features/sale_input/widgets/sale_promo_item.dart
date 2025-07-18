import 'package:abg_pos_app/app/utils/constants/app_constants.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class SalePromoItem extends StatelessWidget {
  const SalePromoItem({
    super.key,
    required this.available,
    required this.title,
    required this.onTap,
  });
  final bool available;
  final String title;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    final radius = AppConstants.DEFAULT_BORDER_RADIUS;
    return DottedBorder(
      options: RoundedRectDottedBorderOptions(
        radius: Radius.circular(10),
        dashPattern: [6, 4],
        color: available ? Colors.red[900]! : Colors.grey[400]!,
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: available ? Colors.red[100] : Colors.grey[100],
              borderRadius: BorderRadius.circular(radius),
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.DEFAULT_PADDING),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      available ? 'PROMO TERSEDIA!' : 'PROMO BELUM TERSEDIA',
                      style: TextStyle(
                        color: available ? Colors.red[800] : Colors.grey,

                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: available ? Colors.red[900] : Colors.grey,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Material(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius),
              ),
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(radius),
                onTap: onTap,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
