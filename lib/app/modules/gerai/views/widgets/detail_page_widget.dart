import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project428app/app/constants.dart';
import 'package:project428app/app/modules/gerai/controllers/outlet_detail_controller.dart';
import 'package:project428app/app/modules/gerai/views/widgets/operator_panel_widget.dart';
import 'package:project428app/app/modules/gerai/views/widgets/owner_panel_widget.dart';
import 'package:project428app/app/modules/gerai/views/widgets/supervisor_panel_widget.dart';
import 'package:project428app/app/style.dart';
import 'package:project428app/app/widgets/status_sign.dart';
import 'package:project428app/app/widgets/text_header.dart';

import '../../../../services/auth_service.dart';

class DetailPageWidget extends StatelessWidget {
  const DetailPageWidget({super.key, required this.c});

  final OutletDetailController c;

  @override
  Widget build(BuildContext context) {
    AuthService authS = Get.find<AuthService>();
    return Obx(
      () => Container(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              SizedBox(height: 20),

              // outlet image
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
                            c.outlet.value.imgUrl.isEmpty
                                ? SvgPicture.asset(
                                  fit: BoxFit.cover,
                                  kImgPlaceholder,
                                )
                                : FadeInImage.assetNetwork(
                                  fit: BoxFit.cover,
                                  image:
                                      '${authS.mainServerUrl.value}/api/v1/uploads/${c.outlet.value.imgUrl}',
                                  placeholder: kAssetLoadingBuffer,
                                ),

                        // : Image.network(
                        //   fit: BoxFit.cover,
                        //   '$kServerUrl/api/v1/uploads/${c.outlet.value.imgUrl}',
                        //   webHtmlElementStrategy:
                        //       WebHtmlElementStrategy.prefer,
                        // ),
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
                            iconColor: WidgetStatePropertyAll(Colors.grey[700]),
                          ),
                          onPressed: () {
                            c.imagePickerC.pickImage(ImageSource.gallery).then((
                              value,
                            ) {
                              print('upload image');
                              c.updateImage();
                            });
                          },
                          icon: Icon(Icons.edit),
                        ),
                      ),
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
                              Text(c.outlet.value.code),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              TextTitle(text: 'Didirikan'),
                              Text(c.outlet.value.getFoundedTime()),
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
                              Text(c.outlet.value.name),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              TextTitle(text: 'Status'),
                              StatusSign(
                                status: c.outlet.value.isActive,
                                size: 16,
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextTitle(text: 'Alamat '),
                                Text(
                                  c.outlet.value.getFullAddress(),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              ],
                            ),
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
                                c.toggleStatus();
                              },
                              style: PrimaryButtonStyle(
                                c.outlet.value.isActive
                                    ? Colors.red[400]!
                                    : Colors.blue,
                              ),
                              child: Text(
                                c.outlet.value.isActive
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
              SizedBox(height: 20),

              // Owners
              OwnerPanelWidget(c: c),
              SizedBox(height: 20),

              // Owners
              OperatorPanelWidget(c: c),
              SizedBox(height: 20),

              // Owners
              SupervisorPanelWidget(c: c),
              SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      c.deleteOutlet();
                    },
                    child: Text(
                      'Hapus Gerai',
                      style: TextStyle(color: Colors.red[700]),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
