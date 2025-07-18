import 'package:abg_pos_app/app/shared/custom_card.dart';
import 'package:abg_pos_app/app/shared/vertical_sized_box.dart';
import 'package:abg_pos_app/app/utils/constants/app_constants.dart';
import 'package:flutter/material.dart';

class OutletOverviewNavItem extends StatelessWidget {
  const OutletOverviewNavItem({super.key, required this.item});
  final dynamic item;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            CustomCard(
              color: Colors.grey[100],
              content: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Icon(
                      item['icon'] as IconData,
                      size: 26,
                      color: const Color.fromARGB(255, 28, 58, 109),
                    ),
                  ),
                ],
              ),
            ),
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(
                    AppConstants.DEFAULT_BORDER_RADIUS,
                  ),
                  onTap: item['onTap'],
                ),
              ),
            ),
            if (item['indicator'] != null)
              Positioned(
                top: 0,
                right: 0,
                child: Badge(label: Text(item['indicator'].toString())),
              ),
          ],
        ),
        const VerticalSizedBox(height: 0.7),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            item['label'] as String,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 10),
          ),
        ),
      ],
    );
  }
}
