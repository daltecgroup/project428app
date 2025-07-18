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

class SaleSingleItem extends StatelessWidget {
  const SaleSingleItem({
    super.key,
    required this.controller,
    required this.item,
    required this.index,
    required this.lastItem,
  });

  final SaleInputController controller;
  final PendingSaleItemSingle item;
  final int index;
  final bool lastItem;

  @override
  Widget build(BuildContext context) {
    final menu = controller.menuData.getMenu(item.menuId);
    final selectedPendingSale = controller.service.selectedPendingSale;
    if (menu == null) return SizedBox();

    final addonOnlyTotalPrice =
        item.qty.toDouble() *
        item.addons.fold<double>(0, (previousValue, element) {
          final addon = controller.addonData.getAddon(element.addonId);
          if (addon != null) {
            return previousValue + addon.price;
          }
          return previousValue;
        });

    final menuOnlyTotalPrice = menu.priceAfterDiscount * item.qty;

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
                                        '${index + 1}. ${normalizeName(menu.name)}',
                                  ),
                                  customSmallLabelText(
                                    text: 'Harga: ${inRupiah(menu.price)}',
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
                                      addonOnlyTotalPrice + menuOnlyTotalPrice,
                                    ),
                                  ),
                                  if (menu.discount > 0)
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text:
                                                'Diskon ${inLocalNumber(menu.discount)}%',
                                            style: TextStyle(
                                              color: Colors.red[700],
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          TextSpan(text: ' '),
                                          TextSpan(
                                            text: inRupiah(
                                              menu.price * item.qty,
                                            ),
                                            style: TextStyle(
                                              color: Colors.grey[700],
                                              decoration:
                                                  TextDecoration.lineThrough,
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
                      ),
                    ],
                  ),
                  if (item.notes != null && item.notes != '') ...[
                    VerticalSizedBox(height: 0.7),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [customSmallLabelText(text: item.notes!)],
                    ),
                  ],
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CustomSmallTextButton(
                            title: '+ Addon',
                            onPressed: () async {
                              String? addonId = await controller.addAddon();
                              if (addonId != null) {
                                item.addAddon(addonId);
                                selectedPendingSale.refresh();
                              }
                            },
                          ),
                          const HorizontalSizedBox(width: 0.5),
                          CustomSmallTextButton(
                            title: '+ Notes',
                            onPressed: () async {
                              await controller.addNotes(item);
                              selectedPendingSale.refresh();
                            },
                          ),
                          const HorizontalSizedBox(width: 0.5),
                          CustomSmallTextButton(
                            title: 'Hapus',
                            onPressed: () async {
                              await selectedPendingSale.value!.removeItemSingle(
                                index,
                              );
                              selectedPendingSale.refresh();
                            },
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () async {
                              if (item.qty > 1) {
                                item.removeQty();
                                selectedPendingSale.refresh();
                              } else {
                                await selectedPendingSale.value!
                                    .removeItemSingle(index);
                                selectedPendingSale.refresh();
                              }
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
                              controller.service.selectedPendingSale.refresh();
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
                  if (item.addons.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(
                        right: AppConstants.DEFAULT_PADDING,
                        bottom: AppConstants.DEFAULT_PADDING,
                      ),
                      child: Column(
                        children: item.addons.asMap().entries.map((value) {
                          final addon = controller.addonData.getAddon(
                            value.value.addonId,
                          );
                          if (addon == null) return SizedBox();
                          return Column(
                            children: [
                              CustomCard(
                                padding: 8,
                                content: Row(
                                  children: [
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,

                                        children: [
                                          Text(
                                            '+ ${normalizeName(addon.name)}',
                                          ),
                                          Text(inRupiah(addon.price)),
                                        ],
                                      ),
                                    ),
                                    const HorizontalSizedBox(),
                                    GestureDetector(
                                      onTap: () {
                                        item.removeAddon(value.key);
                                        selectedPendingSale.refresh();
                                      },
                                      child: Icon(
                                        Icons.close,
                                        color: Colors.red,
                                        size: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (value.value != item.addons.last)
                                const VerticalSizedBox(),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                ],
              ),
            ),
            if (!lastItem) const VerticalSizedBox(),
          ],
        );
      },
    );
  }
}
