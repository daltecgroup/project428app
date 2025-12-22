import 'package:abg_pos_app/app/modules/operator/operator_request/widgets/operator_request_item.dart';
import 'package:abg_pos_app/app/utils/helpers/outlet_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../shared/custom_appbar.dart';
import '../../../../shared/custom_drawer.dart';
import '../../../../shared/pages/empty_list_page.dart';
import '../../../../shared/vertical_sized_box.dart';
import '../../../../utils/constants/padding_constants.dart';
import '../../../../utils/constants/string_value.dart';
import '../controllers/operator_request_controller.dart';

class OperatorRequestView extends GetView<OperatorRequestController> {
  const OperatorRequestView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(StringValue.REQUEST, subtitle: currentOutletName),
      drawer: customDrawer(),
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.data.syncData(refresh: true);
        },
        child: Obx(() {
          if (controller.data.requests.isEmpty)
            return EmptyListPage(
              refresh: () => controller.data.syncData(refresh: true),
              text: 'Permintaan Kosong',
            );
          return ListView(
            padding: horizontalPadding,
            children: [
              const VerticalSizedBox(height: 2),
              ...List.generate(
                controller.data.requests.length,
                (index) => OperatorRequestItem(
                  request: controller.data.requests[index],
                  controller: controller,
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
