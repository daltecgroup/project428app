import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:project428app/app/core/constants/constants.dart';
import 'package:project428app/app/modules/gerai/models/outlet_list_item.dart';
import 'package:project428app/app/modules/gerai/views/pages/outlet_detail_view.dart';
import 'package:project428app/app/shared/widgets/status_sign.dart';

import '../../../../services/auth_service.dart';

class OutletItemWidget extends StatelessWidget {
  const OutletItemWidget({super.key, required this.outlet});

  final OutletListItem outlet;

  @override
  Widget build(BuildContext context) {
    AuthService authS = Get.find<AuthService>();
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: Stack(
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
                  height: kMobileWidth * 0.20,
                  width: kMobileWidth * 0.20 + 10,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                    ),
                    child:
                        outlet.imgUrl.isEmpty
                            ? SvgPicture.asset(
                              kImgPlaceholder,
                              fit: BoxFit.cover,
                            )
                            : FadeInImage.assetNetwork(
                              fit: BoxFit.cover,
                              image:
                                  '${authS.mainServerUrl.value}/api/v1/uploads/${outlet.imgUrl}',
                              placeholder: kAssetLoadingBuffer,
                            ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(right: 10),
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
                                outlet.name,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            StatusSign(status: outlet.isActive, size: 14),
                          ],
                        ),
                        SizedBox(height: 8),
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
                                      fontSize: 10,
                                    ),
                                  ),
                                  Text(
                                    outlet.code,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Alamat',
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 10,
                                    ),
                                  ),
                                  Text(
                                    '${outlet.street}, ${outlet.village}, ${outlet.district}',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontSize: 12,
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
                borderRadius: BorderRadius.all(Radius.circular(8)),
                onTap: () {
                  Get.to(() => OutletDetailView(), arguments: outlet);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
