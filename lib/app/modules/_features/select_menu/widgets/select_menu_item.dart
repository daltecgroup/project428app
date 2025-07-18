import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import '../../../../data/models/Menu.dart';
import '../../../../shared/custom_card.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/helpers/number_helper.dart';
import '../../../../utils/helpers/text_helper.dart';
import '../controllers/select_menu_controller.dart';

class SelectMenuItem extends StatelessWidget {
  const SelectMenuItem({
    super.key,
    required this.controller,
    required this.customWidth,
    required this.menu,
  });

  final SelectMenuController controller;
  final double customWidth;
  final Menu menu;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              flex: 3,
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
                        image: Svg(AppConstants.IMG_PLACEHOLDER),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        padding: EdgeInsets.all(2),
                        width: double.infinity,
                        color: Colors.white38,
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
                                style: TextStyle(fontSize: 11),
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
              flex: 2,
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
              onTap: () {
                Get.back(result: menu.id);
              },
            ),
          ),
        ),
      ],
    );
  }
}
