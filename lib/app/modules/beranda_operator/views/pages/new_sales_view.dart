import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:project428app/app/constants.dart';
import 'package:project428app/app/modules/beranda_operator/views/pages/select_menu_view.dart';
import 'package:project428app/app/modules/beranda_operator/views/pages/select_payment_method_view.dart';
import 'package:project428app/app/services/auth_service.dart';
import 'package:project428app/app/services/operator_service.dart';

class NewSalesView extends GetView {
  const NewSalesView({super.key});
  @override
  Widget build(BuildContext context) {
    OperatorService OperatorS = Get.find<OperatorService>();
    OperatorS.pendingSales
        .firstWhere(
          (sales) => sales.trxCode == OperatorS.currentPendingTrxCode.value,
        )
        .updateIndicators();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          OperatorS.currentPendingTrxCode.value,
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            OperatorS.currentPendingTrxCode.value = '';
            Get.offNamed('/beranda-operator');
          },
          icon: Icon(Icons.arrow_back_rounded),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.offNamed('/beranda-operator');

              OperatorS.pendingSales.removeWhere(
                (sale) => sale.trxCode == OperatorS.currentPendingTrxCode.value,
              );
              OperatorS.currentPendingTrxCode.value = '';
            },
            icon: Icon(Icons.delete, color: Colors.red[700]),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 15, right: 15, top: 15),
        child: Column(
          children: [
            // new transactions indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Card(
                    color: Colors.white,
                    elevation: 1,
                    margin: EdgeInsets.symmetric(horizontal: 0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 5,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Item', style: TextStyle(fontSize: 10)),
                                Obx(() {
                                  final salesItem = OperatorS.pendingSales
                                      .firstWhereOrNull(
                                        (sales) =>
                                            sales.trxCode ==
                                            OperatorS
                                                .currentPendingTrxCode
                                                .value,
                                      );

                                  // Now, salesItem can be null if no match was found
                                  final textContent =
                                      salesItem != null
                                          ? salesItem.itemCount.value
                                              .toString() // Access .value only if not null
                                          : '0'; // Provide a default if no matching sales item is found

                                  return Text(
                                    textContent,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  );
                                }),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Promo', style: TextStyle(fontSize: 10)),
                                Text(
                                  '0',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Hemat', style: TextStyle(fontSize: 10)),
                                Obx(() {
                                  final salesItem = OperatorS.pendingSales
                                      .firstWhereOrNull(
                                        (sales) =>
                                            sales.trxCode ==
                                            OperatorS
                                                .currentPendingTrxCode
                                                .value,
                                      );

                                  final textContent =
                                      salesItem != null
                                          ? salesItem.getSavingsInRupiah()
                                          : 'IDR 0';

                                  return Text(
                                    textContent,
                                    style: const TextStyle(
                                      // Added const for performance if style doesn't change
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  );
                                }),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Total', style: TextStyle(fontSize: 10)),
                                Obx(() {
                                  final salesItem = OperatorS.pendingSales
                                      .firstWhereOrNull(
                                        (sales) =>
                                            sales.trxCode ==
                                            OperatorS
                                                .currentPendingTrxCode
                                                .value,
                                      );
                                  final String textContent;
                                  if (salesItem != null) {
                                    textContent =
                                        salesItem.getTotalInRupiah().toString();
                                  } else {
                                    textContent = '0';
                                  }
                                  return Text(
                                    textContent,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  );
                                }),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 20),

            // sales item
            Obx(() {
              final salesItem = OperatorS.pendingSales.firstWhereOrNull(
                (sales) =>
                    sales.trxCode == OperatorS.currentPendingTrxCode.value,
              );
              if (salesItem == null || salesItem.items.isEmpty) {
                return const SizedBox.shrink();
              }
              return Column(
                children: List.generate(
                  salesItem.items.length,
                  (index) => SalesItemWidget(
                    item: salesItem.items[index],
                    index: index,
                  ),
                ),
              );
            }),

            SizedBox(height: 5),

            // add new product on this pending sales
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 40,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      onPressed: () {
                        Get.to(
                          () => SelectMenuView(),
                          transition: Transition.rightToLeft,
                          arguments: 'new-sales',
                        );
                      },
                      child: Text('+ Tambah Item'),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            // promo available
            PromoItemWidget(
              available:
                  OperatorS.pendingSales
                      .firstWhere(
                        (sale) =>
                            sale.trxCode ==
                            OperatorS.currentPendingTrxCode.value,
                      )
                      .items
                      .length >=
                  2,
              title: 'Beli 2 Gratis 1',
            ),
            PromoItemWidget(
              available:
                  OperatorS.pendingSales
                      .firstWhere(
                        (sale) =>
                            sale.trxCode ==
                            OperatorS.currentPendingTrxCode.value,
                      )
                      .total
                      .value >=
                  50000,
              title: 'Belanja Minimal 50rb gratis 1 item',
            ),
            SizedBox(height: 20),
            Container(
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.only(bottom: 20, left: 0, right: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Hero(
                      tag: 'back-button',
                      child: TextButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all(
                            Colors.grey[300],
                          ),
                        ),
                        onPressed: () {
                          OperatorS.currentPendingTrxCode.value = '';
                          Get.offNamed('/beranda-operator');
                        },
                        child: Text('Kembali', style: TextStyle(fontSize: 16)),
                      ),
                    ),
                  ),
                  OperatorS.pendingSales
                              .firstWhere(
                                (sales) =>
                                    sales.trxCode ==
                                    OperatorS.currentPendingTrxCode.value,
                              )
                              .itemCount
                              .value ==
                          0
                      ? SizedBox()
                      : SizedBox(width: 10),
                  OperatorS.pendingSales
                              .firstWhere(
                                (sales) =>
                                    sales.trxCode ==
                                    OperatorS.currentPendingTrxCode.value,
                              )
                              .itemCount
                              .value ==
                          0
                      ? SizedBox()
                      : Expanded(
                        child: ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                          onPressed: () {
                            if (OperatorS.pendingSales
                                    .firstWhere(
                                      (sales) =>
                                          sales.trxCode ==
                                          OperatorS.currentPendingTrxCode.value,
                                    )
                                    .itemCount
                                    .value ==
                                0) {
                              Get.defaultDialog(
                                title: 'Peringatan',
                                titleStyle: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                                content: Text('Item yang dipilih kosong'),
                                radius: 10,
                              );
                            } else {
                              Get.to(() => SelectPaymentMethodView());
                            }
                          },
                          child: Text(
                            'Pembayaran',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PromoItemWidget extends StatelessWidget {
  const PromoItemWidget({
    super.key,
    required this.available,
    required this.title,
  });

  final bool available;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: DottedBorder(
              options: RoundedRectDottedBorderOptions(
                radius: Radius.circular(10),
                dashPattern: [6, 4],
                color: available ? Colors.teal[900]! : Colors.grey[400]!,
              ),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: available ? Colors.teal[50] : Colors.grey[100],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              available
                                  ? 'PROMO TERSEDIA!'
                                  : 'PROMO BELUM TERSEDIA',
                              style: TextStyle(
                                color:
                                    available ? Colors.teal[800] : Colors.grey,
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              title,
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color:
                                    available ? Colors.teal[900] : Colors.grey,
                                fontWeight: FontWeight.w500,
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
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () {},
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SalesItemWidget extends StatelessWidget {
  const SalesItemWidget({super.key, required this.item, required this.index});

  final NewSalesItem item;
  final int index;

  @override
  Widget build(BuildContext context) {
    OperatorService OperatorS = Get.find<OperatorService>();
    AuthService AuthS = Get.find<AuthService>();
    return Row(
      children: [
        Expanded(
          child: Card(
            color: Colors.white,
            elevation: 1,
            margin: EdgeInsets.only(bottom: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 15, right: 5, top: 15, bottom: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Sales item image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                          height: 45,
                          width: 45,
                          child:
                              GetPlatform.isWeb || !AuthS.isConnected.value
                                  ? SvgPicture.asset(
                                    kImgPlaceholder,
                                    fit: BoxFit.cover,
                                  )
                                  : FadeInImage.assetNetwork(
                                    placeholder: kImgPlaceholder,
                                    image:
                                        '${AuthS.mainServerUrl.value}/api/v1/${item.product.imgUrl}',
                                  ),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.product.name,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            item.topping.isEmpty
                                ? SizedBox()
                                : Text(
                                  '+ Abon Ayam',
                                  style: TextStyle(fontSize: 12),
                                ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    '${item.product.discount}%',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                    ),
                                  ),
                                  SizedBox(width: 3),
                                  Text(
                                    item.product.getPriceInRupiah().substring(
                                      4,
                                    ),
                                    style: TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                item.product.getPriceInRupiahAfterDiscount(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  // SizedBox(height: 5),
                  // Text('"Less Sugar"', style: TextStyle(fontSize: 14)),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          TextButton(
                            style: ButtonStyle(
                              padding: WidgetStatePropertyAll(
                                EdgeInsets.all(5),
                              ),
                            ),
                            onPressed: () {},
                            child: Text(
                              '+ Topping',
                              style: TextStyle(fontSize: 10),
                            ),
                          ),
                          TextButton(
                            style: ButtonStyle(
                              padding: WidgetStatePropertyAll(
                                EdgeInsets.all(5),
                              ),
                            ),
                            onPressed: () {},
                            child: Text(
                              '+ Catatan',
                              style: TextStyle(fontSize: 10),
                            ),
                          ),
                          TextButton(
                            style: ButtonStyle(
                              padding: WidgetStatePropertyAll(
                                EdgeInsets.all(5),
                              ),
                            ),
                            onPressed: () {
                              OperatorS.pendingSales
                                  .firstWhere(
                                    (sales) =>
                                        sales.trxCode ==
                                        OperatorS.currentPendingTrxCode.value,
                                  )
                                  .items
                                  .removeAt(index);
                              OperatorS.pendingSales
                                  .firstWhere(
                                    (sales) =>
                                        sales.trxCode ==
                                        OperatorS.currentPendingTrxCode.value,
                                  )
                                  .items
                                  .refresh();
                            },
                            child: Text(
                              'Hapus',
                              style: TextStyle(fontSize: 10),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            color: Colors.red[700],
                            onPressed: () {
                              item.removeOne();
                              OperatorS.pendingSales
                                  .firstWhere(
                                    (sales) =>
                                        sales.trxCode ==
                                        OperatorS.currentPendingTrxCode.value,
                                  )
                                  .updateIndicators();
                              OperatorS.pendingSales.refresh();
                            },
                            icon: Icon(Icons.remove_circle),
                          ),
                          SizedBox(width: 5),
                          Obx(() => Text(item.qty.value.toString())),
                          SizedBox(width: 5),
                          IconButton(
                            color: Colors.green,
                            onPressed: () {
                              item.addOne();
                              OperatorS.pendingSales
                                  .firstWhere(
                                    (sales) =>
                                        sales.trxCode ==
                                        OperatorS.currentPendingTrxCode.value,
                                  )
                                  .updateIndicators();
                              OperatorS.pendingSales.refresh();
                            },
                            icon: Icon(Icons.add_circle),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
