import 'package:abg_pos_app/app/data/models/PendingSale.dart';
import 'package:abg_pos_app/app/modules/_features/sale_input/controllers/sale_input_controller.dart';
import 'package:abg_pos_app/app/shared/buttons/custom_small_text_button.dart';
import 'package:abg_pos_app/app/shared/custom_card.dart';
import 'package:abg_pos_app/app/shared/horizontal_sized_box.dart';
import 'package:abg_pos_app/app/shared/vertical_sized_box.dart';
import 'package:abg_pos_app/app/utils/constants/app_constants.dart';
import 'package:abg_pos_app/app/utils/helpers/number_helper.dart';
import 'package:abg_pos_app/app/utils/helpers/text_helper.dart';
import 'package:abg_pos_app/app/utils/theme/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class SaleAddonItem extends StatelessWidget {
  const SaleAddonItem({
    super.key,
    required this.controller,
    required this.item,
    required this.index,
  });

  final SaleInputController controller;
  final PendingSaleItemAddon item;
  final int index;


  @override
  Widget build(BuildContext context) {

    final addon = controller.addonData.getAddon(item.addonId);
    if (addon == null) return SizedBox();

    return Builder(
      builder: (context) {
        return Column(
          children: [
            CustomCard(
              customPadding: EdgeInsets.only(
                left: AppConstants.DEFAULT_PADDING,
                top: AppConstants.DEFAULT_PADDING,
                right: 0,
                bottom: 0,
              ),
              content: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            AppConstants.DEFAULT_BORDER_RADIUS,
                          ),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: Svg(AppConstants.IMG_PLACEHOLDER),
                          ),
                        ),
                      ),
                      const HorizontalSizedBox(),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  customCardTitleText(
                                    text:
                                        normalizeName("${index+1}. ${addon.name}"),
                                  ),
                                  customSmallLabelText(
                                    text: 'Harga: ${inRupiah(addon.price)}',
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                right: AppConstants.DEFAULT_PADDING,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  customCardTitleText(
                                    text: inRupiah(
                                      addon.price * item.qty,
                                    ),
                                  ),
                                  
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          
                          CustomSmallTextButton(
                            title: 'Hapus',
                            onPressed: () async {
                              await controller.currentPendingSale!.removeItemAddon(index);
                              controller.service.selectedPendingSale.refresh();
                            },
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () async {
                              if(item.qty <= 1){
                                await controller.currentPendingSale!.removeItemAddon(index);
                              controller.service.selectedPendingSale.refresh();
                              return;
                              }
                              item.removeQty();
                              controller.refreshPendingSale();
                            },
                            icon: Icon(
                              Icons.remove_circle_rounded,
                              color: Colors.red,
                            ),
                          ),
                          SizedBox(
                            width: 30,
                            child: Align(
                              alignment: Alignment.center,
                              child: customLabelText(text: item.qty.toString()),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              item.addQty();
                              controller.refreshPendingSale();
                            },
                            icon: Icon(
                              Icons.add_circle_rounded,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const VerticalSizedBox(),
          ],
        );
      },
    );
  }
}
