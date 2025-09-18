import 'package:abg_pos_app/app/modules/operator/operator_sale_detail/widgets/custom_card_header.dart';
import 'package:abg_pos_app/app/routes/app_pages.dart';
import 'package:abg_pos_app/app/utils/constants/padding_constants.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../shared/custom_appbar_lite.dart';
import '../../../../shared/custom_card.dart';
import '../../../../shared/pages/failed_page_placeholder.dart';
import '../../../../shared/valid_sign.dart';
import '../../../../shared/vertical_sized_box.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/helpers/number_helper.dart';
import '../../../../utils/helpers/text_helper.dart';
import '../../../../utils/helpers/time_helper.dart';
import '../../../../utils/constants/string_value.dart';
import '../../../../utils/theme/custom_text.dart';
import '../controllers/operator_sale_detail_controller.dart';

class OperatorSaleDetailView extends GetView<OperatorSaleDetailController> {
  const OperatorSaleDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final sale = controller.data.selectedSale.value;
      if (sale == null) return FailedPagePlaceholder();
      return Scaffold(
        appBar: customAppBarLite(
          title: sale.code,
          backRoute: controller.backRoute == Routes.SALE_INPUT
              ? Routes.OPERATOR_SALE
              : controller.backRoute,
          actions: [
            PopupMenuButton(
              color: Colors.white,
              icon: Icon(Icons.more_vert),
              itemBuilder: (context) => <PopupMenuEntry>[
                PopupMenuItem(
                  onTap: () {
                    controller.printInvoice(sale.id);
                  },
                  child: Text('Cetak Nota'),
                ),
                PopupMenuItem(
                  onTap: () {
                    controller.deleteRequest(
                      saleCode: sale.code,
                      saleId: sale.id,
                    );
                  },
                  child: Text(
                    'Minta Hapus',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
          ],
        ),
        body: ListView(
          padding: horizontalPadding,
          children: [
            const VerticalSizedBox(height: 2),
            const CustomCardHeader(title: 'Ikhtisar'),
            CustomCard(
              flatTop: true,
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      customLabelText(text: StringValue.CREATED_AT),
                      customLabelText(text: StringValue.STATUS),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      customCaptionText(
                        text: localDateTimeFormat(sale.createdAt),
                      ),
                      ValidSign(
                        isValid: sale.isValid,
                        size: AppConstants.DEFAULT_FONT_SIZE.toInt(),
                      ),
                    ],
                  ),
                  const VerticalSizedBox(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      customLabelText(text: StringValue.CASHIER),
                      customLabelText(text: StringValue.METHOD),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: customCaptionText(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          text: normalizeName(sale.operator.name),
                        ),
                      ),
                      customCaptionText(
                        text: normalizeName(sale.payment.method),
                      ),
                    ],
                  ),
                  const VerticalSizedBox(),
                  customLabelText(text: StringValue.OUTLET_NAME),
                  customCaptionText(text: normalizeName(sale.outlet.name)),
                ],
              ),
            ),
            const VerticalSizedBox(),
            const CustomCardHeader(title: 'Produk Terjual'),
            CustomCard(
              flatTop: true,
              content: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      customLabelText(text: StringValue.ITEM_QTY),
                      customLabelText(text: StringValue.PROMO),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      customCaptionText(text: '${sale.itemCount} item'),
                      customCaptionText(
                        text: sale.itemPromo.isEmpty
                            ? '-'
                            : sale.itemPromo.length.toString(),
                      ),
                    ],
                  ),

                  // item bundle
                  if (sale.itemBundle.isNotEmpty) ...[
                    const VerticalSizedBox(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        customLabelText(text: StringValue.ITEM_BUNDLE),
                        customLabelText(text: StringValue.PRICE),
                      ],
                    ),
                    const VerticalSizedBox(height: 0.7),
                    ...sale.itemBundle.asMap().entries.map((item) {
                      final bundle = item.value;
                      return Column(
                        children: [
                          CustomCard(
                            padding: 8,
                            content: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      normalizeName(
                                        '${item.key + 1}. ${bundle.name} x${bundle.qty.toInt()}',
                                      ),
                                    ),
                                    Text(inRupiah(bundle.price * bundle.qty)),
                                  ],
                                ),
                                ...bundle.items.asMap().entries.map((
                                  bundleItem,
                                ) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        normalizeName(
                                          '   ${bundleItem.value.name}',
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                              ],
                            ),
                          ),
                        ],
                      );
                    }),
                  ],

                  // item single
                  if (sale.itemSingle.isNotEmpty) ...[
                    const VerticalSizedBox(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        customLabelText(text: StringValue.ITEM_SINGLE),
                        customLabelText(text: StringValue.PRICE),
                      ],
                    ),
                    const VerticalSizedBox(height: 0.7),
                    ...sale.itemSingle.asMap().entries.map((item) {
                      final single = item.value;
                      return Column(
                        children: [
                          CustomCard(
                            padding: 8,
                            content: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      normalizeName(
                                        '${item.key + 1}. ${single.name} x${single.qty.toInt()}',
                                      ),
                                    ),
                                    Text(inRupiah(single.price * single.qty)),
                                  ],
                                ),
                                if (single.addons.isNotEmpty)
                                  ...single.addons.map((addon) {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '   +${normalizeName(addon.name)}',
                                        ),
                                        Text(
                                          '+${inRupiah(addon.price * single.qty)}',
                                        ),
                                      ],
                                    );
                                  }),
                                if (single.discount > 0)
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('   Diskon'),
                                      Text(
                                        '-${inRupiah(single.getDiscount * single.qty)}',
                                      ),
                                    ],
                                  ),
                                if (single.notes != null)
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text('   Note: ${single.notes}'),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                          if (item.key != sale.itemSingle.length - 1)
                            const VerticalSizedBox(height: 0.7),
                        ],
                      );
                    }),
                  ],

                  // item promo
                  if (sale.itemPromo.isNotEmpty) ...[
                    const VerticalSizedBox(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [customLabelText(text: StringValue.ITEM_PROMO)],
                    ),
                    const VerticalSizedBox(height: 0.7),
                    ...sale.itemPromo.map((item) {
                      return CustomCard(
                        padding: 8,
                        content: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [Text(normalizeName(item.name))],
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ],
              ),
            ),
            const VerticalSizedBox(),

            const CustomCardHeader(title: 'Pembayaran'),
            CustomCard(
              flatTop: true,
              content: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      customLabelText(text: StringValue.DISCOUNT),
                      customLabelText(text: StringValue.TOTAL_PRICE),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      customCaptionText(
                        text: sale.totalDiscount > 0
                            ? '-${inRupiah(sale.totalDiscount)}'
                            : '-',
                      ),
                      customCaptionText(text: inRupiah(sale.totalPrice)),
                    ],
                  ),
                  const VerticalSizedBox(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      customLabelText(text: 'Jumlah Bayar'),
                      customLabelText(text: 'Kembalian'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      customCaptionText(text: inRupiah(sale.totalPaid)),
                      customCaptionText(
                        text: sale.totalChange == 0
                            ? '-'
                            : inRupiah(sale.totalChange),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const VerticalSizedBox(),

            // bukti bayar
            if (sale.payment.evidenceUrl != null) ...[
              const CustomCardHeader(title: 'Bukti Bayar'),
              CustomCard(
                flatTop: true,
                padding: 4,
                content: Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        onTap: () {
                          Get.dialog(
                            Stack(
                              children: [
                                Container(
                                  width: Get.width,
                                  height: Get.height,
                                  padding: EdgeInsets.all(
                                    AppConstants.DEFAULT_PADDING * 2,
                                  ),
                                  child: Image.network(
                                    AppConstants.CURRENT_BASE_API_URL_IMAGE +
                                        sale.payment.evidenceUrl!,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: IconButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    icon: Icon(Icons.close),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        title: Text(localDateTimeFormat(sale.createdAt)),
                        leading: Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              AppConstants.DEFAULT_BORDER_RADIUS,
                            ),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                AppConstants.CURRENT_BASE_API_URL_IMAGE +
                                    sale.payment.evidenceUrl!,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const VerticalSizedBox(),
            ],

            // printing history
            CustomCardHeader(
              title: 'Riwayat Cetak',
              isOpen: controller.showPrintHistory.value,
              onTap: () => controller.showPrintHistory.toggle(),
            ),
            if (controller.showPrintHistory.value)
              CustomCard(
                flatTop: true,
                content: Column(
                  children: [
                    if (sale.invoicePrintHistory.isEmpty)
                      Text('Nota belum tercetak'),
                    if (sale.invoicePrintHistory.isNotEmpty)
                      ...sale.invoicePrintHistory.asMap().entries.map((
                        printHistory,
                      ) {
                        int max = 50;
                        if (printHistory.key + 1 > max) return SizedBox();
                        return Column(
                          children: [
                            CustomCard(
                              padding: 8,
                              content: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Cetakan ke-${printHistory.key + 1}',
                                      ),
                                      Expanded(
                                        child: Text(
                                          ' oleh ${normalizeName(controller.getUserName(printHistory.value.userId))}',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  customSmallLabelText(
                                    text: localDateTimeFormat(
                                      printHistory.value.printedAt,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (printHistory.key !=
                                    sale.invoicePrintHistory.length - 1 &&
                                printHistory.key + 1 != max)
                              const VerticalSizedBox(height: 0.7),
                          ],
                        );
                      }),
                  ],
                ),
              ),

            const VerticalSizedBox(height: 5),
          ],
        ),
      );
    });
  }
}
