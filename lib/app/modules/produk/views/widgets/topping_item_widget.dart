import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:project428app/app/core/constants/constants.dart';
import 'package:project428app/app/modules/produk/bindings/produk_binding.dart';
import 'package:project428app/app/modules/produk/controllers/topping_controller.dart';
import 'package:project428app/app/modules/produk/views/widgets/topping_detail_view.dart';

import '../../../../data/models/topping.dart';

class ToppingItemWidget extends GetView<ToppingController> {
  const ToppingItemWidget({super.key, required this.topping});

  final Topping topping;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Card(
              color: Colors.white,
              margin: const EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(right: 12),
                    height: 90,
                    width: 100,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                      ),
                      child:
                          topping.imgUrl != null
                              ? Image.network(
                                fit: BoxFit.cover,
                                'https://placebear.com/250/250',
                                webHtmlElementStrategy:
                                    WebHtmlElementStrategy.prefer,
                              )
                              : SvgPicture.asset(
                                fit: BoxFit.cover,
                                kImgPlaceholder,
                              ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(
                        left: 0,
                        right: 10,
                        bottom: 10,
                        top: 0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  topping.name,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Kode',
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      topping.code,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Harga',
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      topping.getPriceInRupiah(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
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
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {
                    controller.selectedTopping.value = topping;
                    controller.selectedTopping.refresh();
                    Get.to(
                      () => ToppingDetailView(),
                      binding: ProdukBinding(),
                      transition: Transition.rightToLeft,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
