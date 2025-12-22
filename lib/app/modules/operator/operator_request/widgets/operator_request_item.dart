import 'package:abg_pos_app/app/data/models/Request.dart';
import 'package:abg_pos_app/app/routes/app_pages.dart';
import 'package:abg_pos_app/app/shared/custom_nav_item.dart';
import 'package:abg_pos_app/app/shared/horizontal_sized_box.dart';
import 'package:abg_pos_app/app/shared/request_item_badge.dart';
import 'package:abg_pos_app/app/utils/helpers/time_helper.dart';
import 'package:abg_pos_app/app/utils/theme/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/operator_request_controller.dart';

class OperatorRequestItem extends StatelessWidget {
  const OperatorRequestItem({super.key, required this.request, required this.controller});

  final Request request;
  final OperatorRequestController controller;

  @override
  Widget build(BuildContext context) {
    return CustomNavItem(
      marginBottom: true,
      leading: Icon(Icons.delete_outline),
      disableTrailing: true,
      titleWidget: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(request.requestType),
              HorizontalSizedBox(width: 0.7),
              RequestItemBadge(status: request.status),
            ],
          ),
          customSmallLabelText(text: localTimeFormat(request.createdAt)),
        ],
      ),
      subTitleWidget: Text('Target: ${request.targetCode}'),
      onTap: () {
        controller.selectRequest(request);
        Get.toNamed(
          Routes.REQUEST_DETAIL,
          arguments: request,
        );
      },
    );
  }
}
