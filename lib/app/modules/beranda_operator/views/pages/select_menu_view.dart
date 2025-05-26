import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:project428app/app/constants.dart';
import 'package:project428app/app/modules/beranda_operator/views/pages/new_sales_view.dart';
import 'package:project428app/app/services/auth_service.dart';
import 'package:project428app/app/services/operator_service.dart';
import 'package:project428app/app/widgets/text_header.dart';

import '../../../../models/product.dart';

class SelectMenuView extends GetView {
  const SelectMenuView({super.key});
  @override
  Widget build(BuildContext context) {
    OperatorService OperatorS = Get.find<OperatorService>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pilih Menu',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            if (Get.arguments == 'homepage') {
              Get.offNamed('/beranda-operator');
            } else {
              Get.back();
            }
          },
          icon: Icon(Icons.arrow_back_rounded),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 15, right: 15, top: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...List.generate(
              OperatorS.CategoryP.categories
                  .where((cat) => cat.isActive)
                  .toList()
                  .length,
              (index) => Column(
                children: [
                  TextTitle(
                    text:
                        OperatorS.CategoryP.categories
                            .where((cat) => cat.isActive)
                            .toList()[index]
                            .name,
                  ),
                  SizedBox(height: 10),
                  ...List.generate(
                    OperatorS.ProductP.products
                        .where(
                          (product) =>
                              product.isActive &&
                              product.category.id ==
                                  OperatorS.CategoryP.categories
                                      .where((cat) => cat.isActive)
                                      .toList()[index]
                                      .id,
                        )
                        .toList()
                        .length,
                    (secondIndex) => Column(
                      children: [
                        MenuItemWidget(
                          product:
                              OperatorS.ProductP.products
                                  .where(
                                    (product) =>
                                        product.isActive &&
                                        product.category.id ==
                                            OperatorS.CategoryP.categories
                                                .where((cat) => cat.isActive)
                                                .toList()[index]
                                                .id,
                                  )
                                  .toList()[secondIndex],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // TextTitle(text: 'Mix Topping'),
            // SizedBox(height: 10),
            // MenuItemWidget(),
            // MenuItemWidget(),
            // SizedBox(height: 10),
            // TextTitle(text: 'Mix Topping'),
            // SizedBox(height: 10),
            // MenuItemWidget(),
            // MenuItemWidget(),
          ],
        ),
      ),
    );
  }
}

class MenuItemWidget extends StatelessWidget {
  const MenuItemWidget({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    AuthService AuthS = Get.find<AuthService>();
    OperatorService OperatorS = Get.find<OperatorService>();
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      child: Stack(
        children: [
          Column(
            children: [
              Card(
                color: Colors.white,
                margin: const EdgeInsets.only(bottom: 0, left: 0, right: 0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.only(right: 12),
                      height: 110,
                      width: 110,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          bottomLeft: Radius.circular(0),
                        ),
                        child:
                            GetPlatform.isWeb || !AuthS.isConnected.value
                                ? SvgPicture.asset(
                                  kImgPlaceholder,
                                  fit: BoxFit.cover,
                                )
                                : FadeInImage.assetNetwork(
                                  fit: BoxFit.cover,
                                  placeholder: kImgPlaceholder,
                                  image:
                                      '${AuthS.mainServerUrl.value}/api/v1/${product.imgUrl}',
                                ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 8,
                          bottom: 8,
                          right: 12,
                          left: 0,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              product.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 10),
                            ),
                            SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Perkiraan Sisa",
                                        style: TextStyle(fontSize: 10),
                                      ),
                                      Text(
                                        "20",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Diskon",
                                        style: TextStyle(fontSize: 10),
                                      ),
                                      RichText(
                                        textAlign: TextAlign.start,
                                        text: TextSpan(
                                          children: <TextSpan>[
                                            TextSpan(
                                              text:
                                                  '${product.discount.toString()}%',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.red,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            TextSpan(text: ' '),
                                            TextSpan(
                                              text: product
                                                  .getPriceInRupiah()
                                                  .substring(4),
                                              style: TextStyle(
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                fontSize: 14,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Harga",
                                        style: TextStyle(fontSize: 10),
                                      ),
                                      RichText(
                                        textAlign: TextAlign.start,
                                        text: TextSpan(
                                          children: <TextSpan>[
                                            TextSpan(
                                              text:
                                                  product
                                                      .getPriceInRupiahAfterDiscount(),
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w700,
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
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                onTap: () {
                  if (OperatorS.currentPendingTrxCode.isEmpty) {
                    OperatorS.addPendingSales();
                    OperatorS.pendingSales
                        .firstWhere(
                          (sales) =>
                              sales.trxCode ==
                              OperatorS.currentPendingTrxCode.value,
                        )
                        .addItem(NewSalesItem(product: product));
                    Get.to(() => NewSalesView());
                  } else {
                    OperatorS.pendingSales
                        .firstWhere(
                          (sales) =>
                              sales.trxCode ==
                              OperatorS.currentPendingTrxCode.value,
                        )
                        .addItem(NewSalesItem(product: product));
                    OperatorS.pendingSales.refresh();
                    Get.back();
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
