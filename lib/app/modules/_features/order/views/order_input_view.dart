import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../data/models/OrderItem.dart';
import '../../../../shared/buttons/bottom_nav_button.dart';
import '../../../../shared/buttons/custom_text_button.dart';
import '../../../../shared/custom_appbar_lite.dart';
import '../../../../shared/custom_card.dart';
import '../../../../shared/vertical_sized_box.dart';
import '../../../../utils/constants/padding_constants.dart';
import '../../../../utils/helpers/number_helper.dart';
import '../../../../utils/theme/custom_text.dart';
import '../widgets/order_item_widget.dart';
import '../widgets/ourder_input_outlet_selection.dart';
import '../controllers/order_input_controller.dart';

class OrderInputView extends GetView<OrderInputController> {
  const OrderInputView({super.key});
  @override
  Widget build(BuildContext context) {
    final c = controller;
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (controller.selectedRecipes.isNotEmpty) {
          await controller.backConfirmation();
        } else {
          Get.back();
        }
      },
      child: Scaffold(
        appBar: customAppBarLite(
          title: 'Tambah Pesanan',
          backRoute: c.backRoute,
        ),
        body: Obx(() {
          if (c.outletData.outlets.isEmpty)
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Daftar gerai tujuan kosong'),
                  CustomTextButton(
                    title: 'Kembali',
                    onPressed: () => Get.back(),
                  ),
                ],
              ),
            );
          return Stack(
            children: [
              ListView(
                padding: horizontalPadding,
                children: [
                  const VerticalSizedBox(height: 2),
                  OurderInputOutletSelection(c: c),
                  const VerticalSizedBox(height: 2),
                  CustomCard(
                    content: Column(
                      children: [
                        Row(
                          mainAxisAlignment: c.selectedRecipes.isNotEmpty
                              ? MainAxisAlignment.spaceBetween
                              : MainAxisAlignment.center,
                          children: [
                            if (c.selectedRecipes.isNotEmpty)
                              customInputTitleText(text: 'Pesanan'),
                            CustomTextButton(
                              title: c.selectedRecipes.isEmpty
                                  ? 'Tambah Pesanan'
                                  : 'Ubah Pesanan',
                              onPressed: () {
                                c.addIngredients();
                              },
                            ),
                          ],
                        ),
                        if (c.selectedRecipes.isNotEmpty)
                          ...c.selectedRecipes.map((recipe) {
                            final item = OrderItem(
                              ingredientId: recipe.ingredient.id,
                              name: recipe.ingredient.name,
                              unit: recipe.ingredient.unit,
                              price: recipe.ingredient.price,
                              qty: recipe.qty,
                              notes: null,
                              isAccepted: false,
                              outletInventoryTransactionId: null,
                            );

                            return Column(
                              children: [
                                OrderItemWidget(
                                  showStatus: false,
                                  item: item,
                                  onTap: () {
                                    item.changeStatus(!item.isAccepted);
                                  },
                                ),
                                if (c.selectedRecipes.indexOf(recipe) !=
                                    c.selectedRecipes.length - 1)
                                  const VerticalSizedBox(),
                              ],
                            );
                          }),
                        if (c.selectedRecipes.isNotEmpty) ...[
                          const VerticalSizedBox(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              customSmallLabelText(text: 'Total Harga'),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              customInputTitleText(
                                text: inRupiah(c.totalOrderPrice()),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                  const VerticalSizedBox(height: 10),
                ],
              ),
              // nav button
              SafeArea(
                child: BottomNavButton(
                  nextBtn: 'Simpan',
                  nextCb: () => controller.submit(),
                  backCb: () async {
                    if (controller.selectedRecipes.isNotEmpty) {
                      await controller.backConfirmation();
                    } else {
                      Get.back();
                    }
                  },
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
