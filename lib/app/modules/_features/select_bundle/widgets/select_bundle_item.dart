import 'package:abg_pos_app/app/data/models/Bundle.dart';
import 'package:abg_pos_app/app/modules/_features/select_bundle/controllers/select_bundle_controller.dart';
import 'package:abg_pos_app/app/shared/custom_card.dart';
import 'package:abg_pos_app/app/utils/constants/app_constants.dart';
import 'package:abg_pos_app/app/utils/helpers/number_helper.dart';
import 'package:abg_pos_app/app/utils/helpers/text_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';

class SelectBundleItem extends StatelessWidget {
  const SelectBundleItem({
    super.key,
    required this.controller,
    required this.customWidth,
    required this.bundle,
  });

  final SelectBundleController controller;
  final double customWidth;
  final Bundle bundle;

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
                        child: Text(
                          inRupiah(bundle.price),
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 10),
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
                            normalizeName(bundle.name),
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
                Get.back(result: bundle.id);
              },
            ),
          ),
        ),
      ],
    );
  }
}
