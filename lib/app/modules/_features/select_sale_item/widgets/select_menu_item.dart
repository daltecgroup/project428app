import 'package:abg_pos_app/app/data/models/Menu.dart';
import 'package:abg_pos_app/app/modules/_features/select_sale_item/controllers/select_sale_item_controller.dart';
import 'package:abg_pos_app/app/shared/custom_card.dart';
import 'package:abg_pos_app/app/utils/constants/app_constants.dart';
import 'package:abg_pos_app/app/utils/helpers/number_helper.dart';
import 'package:abg_pos_app/app/utils/helpers/text_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';

class SelectMenuItem extends StatelessWidget {
  const SelectMenuItem({
    super.key,
    required this.controller,
    required this.customWidth,
    required this.menu,
  });

  final SelectSaleItemController controller;
  final double customWidth;
  final Menu menu;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Stack(
        children: [
          Column(
            children: [
              Expanded(
                flex: 4,
                child: Stack(
                  children: [
                    Container(
                      width: customWidth,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                            AppConstants.DEFAULT_BORDER_RADIUS,
                          ),
                          topRight: Radius.circular(
                            AppConstants.DEFAULT_BORDER_RADIUS,
                          ),
                        ),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: menu.image == null
                              ? Svg(AppConstants.IMG_PLACEHOLDER)
                              : NetworkImage(
                                  AppConstants.CURRENT_BASE_API_URL_IMAGE +
                                      menu.image!,
                                ),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          padding: EdgeInsets.all(2),
                          width: double.infinity,
                          color: Colors.white60,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (menu.discount.isGreaterThan(0))
                                Text(
                                  '${inLocalNumber(menu.discount)}% ',
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.redAccent,
                                  ),
                                ),
                              Expanded(
                                child: Text(
                                  inRupiah(menu.priceAfterDiscount),
                                  textAlign: menu.discount.isGreaterThan(0)
                                      ? TextAlign.right
                                      : TextAlign.center,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: CustomCard(
                  flatTop: true,
                  padding: 8,
                  content: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              normalizeName(menu.name),
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.all(
                  Radius.circular(AppConstants.DEFAULT_BORDER_RADIUS),
                ),
                onTap: () => controller.addMenuQty(menu.id),
                onLongPress: () => controller.resetMenuQty(menu.id),
              ),
            ),
          ),
          if (controller.menuCount(menu.id) > 0)
            Positioned(
              right: 0,
              child: GestureDetector(
                onTap: () => controller.substractMenuQty(menu.id),
                onLongPress: () => controller.resetMenuQty(menu.id),
                child: Badge(
                  padding: EdgeInsets.all(4),
                  backgroundColor: Colors.redAccent[300],
                  label: Text(
                    controller.menuCount(menu.id).toString(),
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
        ],
      );
    });
  }
}
