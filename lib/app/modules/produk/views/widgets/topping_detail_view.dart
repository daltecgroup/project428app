import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:project428app/app/core/constants/constants.dart';
import 'package:project428app/app/modules/produk/controllers/topping_detail_controller.dart';

import '../../../../shared/widgets/status_sign.dart';
import '../../../../shared/widgets/text_header.dart';
import '../../../../style.dart';

class ToppingDetailView extends GetView<ToppingDetailController> {
  const ToppingDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail Topping',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () {
            // Save action
            Get.back();
          },
        ),
      ),
      body: Obx(
        () => SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              SizedBox(height: 20),

              // topping image
              Material(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                ),
                elevation: 2,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    topLeft: Radius.circular(10),
                  ),
                  child: Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.only(),
                        height: kMobileWidth - 30,
                        width: double.infinity,
                        child:
                            controller.ToppingC.selectedTopping.value!.imgUrl ==
                                    null
                                ? SvgPicture.asset(
                                  fit: BoxFit.cover,
                                  kImgPlaceholder,
                                )
                                : Image.network(
                                  fit: BoxFit.cover,
                                  '${controller.AuthS.mainServerUrl.value}/api/v1/${controller.ToppingC.selectedTopping.value!.imgUrl}',
                                  webHtmlElementStrategy:
                                      WebHtmlElementStrategy.prefer,
                                ),
                      ),
                      Positioned(
                        right: 5,
                        top: 5,
                        child: IconButton(
                          tooltip: 'Ubah Gambar',
                          style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(
                              Colors.black12,
                            ),
                            iconColor: WidgetStatePropertyAll(Colors.black87),
                          ),
                          onPressed: () {},
                          icon: Icon(Icons.edit),
                        ),
                      ),

                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),

              // product data
              Card(
                color: Colors.white,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                margin: EdgeInsets.all(0),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextTitle(text: 'Kode'),
                              Text(
                                controller.ToppingC.selectedTopping.value!.code,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              TextTitle(text: 'Dibuat'),
                              Text(
                                '${controller.ToppingC.selectedTopping.value!.getCreateDate()} ${controller.ToppingC.selectedTopping.value!.getCreateTime()}',
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextTitle(text: 'Nama'),
                              Text(
                                controller.ToppingC.selectedTopping.value!.name,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              TextTitle(text: 'Diperbarui'),
                              Text(
                                '${controller.ToppingC.selectedTopping.value!.getUpdateDate()} ${controller.ToppingC.selectedTopping.value!.getUpdateTime()}',
                              ),
                            ],
                          ),
                        ],
                      ),

                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextTitle(text: 'Status'),
                              StatusSign(
                                status:
                                    controller
                                        .ToppingC
                                        .selectedTopping
                                        .value!
                                        .isActive,
                                size: 16,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              TextTitle(text: 'Harga'),
                              Text(
                                controller.ToppingC.selectedTopping.value!
                                    .getPriceInRupiah(),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: TextButton(
                              onPressed: () {
                                Get.defaultDialog(
                                  title: 'Peringatan',
                                  titleStyle: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  content: Text(
                                    'Fitur ubah belum terhubung dengan server',
                                  ),
                                  radius: 10,
                                );
                              },
                              style: PrimaryButtonStyle(Colors.blue),
                              child: Text('Ubah Data'),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: TextButton(
                              onPressed: () {
                                controller.ToppingC.selectedTopping.value!
                                    .toggleStatus()
                                    .then((success) {
                                      if (success) {
                                        controller.ToppingC.selectedTopping
                                            .refresh();
                                        controller.ToppingS.toppings.refresh();
                                      }
                                    });
                              },
                              style: PrimaryButtonStyle(
                                controller
                                        .ToppingC
                                        .selectedTopping
                                        .value!
                                        .isActive
                                    ? Colors.red[400]!
                                    : Colors.blue,
                              ),
                              child: Text(
                                controller
                                        .ToppingC
                                        .selectedTopping
                                        .value!
                                        .isActive
                                    ? 'Nonaktifkan'
                                    : 'Aktifkan',
                              ),
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
      ),
    );
  }
}
