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
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';

class SaleBundleItem extends StatelessWidget {
  const SaleBundleItem({
    super.key,
    required this.controller,
    required this.item,
    required this.index,
    required this.lastItem,
  });

  final SaleInputController controller;
  final PendingSaleItemBundle item;
  final int index;
  final bool lastItem;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final bundle = controller.bundleData.getBundle(item.bundleId);
      final selectedPendingSale = controller.service.selectedPendingSale;

      if (bundle == null) return SizedBox();
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
                                      '${index + 1}. ${normalizeName(bundle.name)}',
                                ),
                                customSmallLabelText(
                                  maxLines: 2,
                                  text: normalizeName(
                                    bundle.description ??
                                        'Harga: ${inRupiah(bundle.price)}',
                                  ),
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
                                  text: inRupiah(bundle.price * item.qty),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CustomSmallTextButton(
                          title: 'Hapus',
                          onPressed: () async {
                            await selectedPendingSale.value!.removeItemBundle(
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
                              await selectedPendingSale.value!.removeItemBundle(
                                index,
                              );
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
                            selectedPendingSale.refresh();
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

                // bundle menu items
                Padding(
                  padding: const EdgeInsets.only(
                    right: AppConstants.DEFAULT_PADDING,
                    bottom: AppConstants.DEFAULT_PADDING,
                  ),
                  child: Column(
                    children: [
                      ...item.items.asMap().entries.map((slot) {
                        final categoryName = controller.menuCategoryData
                            .getCategoryName(slot.value.menuCategoryId);

                        // if menu not yed added
                        if (slot.value.menuId == null) {
                          return Column(
                            children: [
                              InkWell(
                                borderRadius: BorderRadius.circular(
                                  AppConstants.DEFAULT_BORDER_RADIUS,
                                ),
                                onTap: () async {
                                  final menuId = await Get.toNamed(
                                    Routes.SELECT_MENU,
                                    arguments: {
                                      'categoryId': slot.value.menuCategoryId,
                                    },
                                  );
                                  if (menuId == null || menuId is! String)
                                    return;
                                  slot.value.setMenuId(menuId);
                                  controller.service.selectedPendingSale
                                      .refresh();
                                },
                                child: DottedBorder(
                                  options: RoundedRectDottedBorderOptions(
                                    radius: Radius.circular(
                                      AppConstants.DEFAULT_BORDER_RADIUS,
                                    ),
                                    dashPattern: [6, 4],
                                    color: Colors.grey[400]!,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(6),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            normalizeName(categoryName),
                                            style: TextStyle(
                                              color: Colors.blueGrey,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        const HorizontalSizedBox(),
                                        Icon(
                                          Icons.add_circle_outline_rounded,
                                          color: Colors.blueGrey,
                                          size: 16,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              if (slot.key != item.items.length - 1)
                                const VerticalSizedBox(),
                            ],
                          );
                        }

                        final slotMenu = controller.menuData.getMenu(
                          slot.value.menuId!,
                        );

                        // if menu added
                        return Column(
                          children: [
                            CustomCard(
                              padding: 8,
                              content: Row(
                                children: [
                                  Expanded(
                                    child: Text(normalizeName(slotMenu!.name)),
                                  ),
                                  const HorizontalSizedBox(),
                                  GestureDetector(
                                    onTap: () {
                                      slot.value.removeMenuId();
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
                            if (slot.key != item.items.length - 1)
                              const VerticalSizedBox(),
                          ],
                        );
                      }),
                      // const VerticalSizedBox(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (!lastItem) const VerticalSizedBox(),
        ],
      );
    });
  }
}
