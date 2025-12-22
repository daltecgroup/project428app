import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../modules/admin/request/widgets/request_item.dart';
import '../../../../shared/custom_appbar.dart';
import '../../../../shared/pages/empty_list_page.dart';
import '../../../../shared/vertical_sized_box.dart';
import '../../../../utils/constants/padding_constants.dart';
import '../../../../utils/constants/string_value.dart';
import '../../../../utils/theme/custom_text.dart';
import '../../../../shared/custom_drawer.dart';
import '../controllers/request_controller.dart';

class RequestView extends GetView<RequestController> {
  const RequestView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(StringValue.REQUEST),
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

          final pendingList = controller.data.pendingRequests;
          final notPendingList = controller.data.notPendingRequests;

          return ListView(
            padding: horizontalPadding,
            children: [
              const VerticalSizedBox(height: 2),

              // pending list
              if (pendingList.isNotEmpty) ...[
                customListHeaderText(text: 'Pending'),
                const VerticalSizedBox(height: 0.7),
                ...List.generate(
                  pendingList.length,
                  (index) => RequestItem(
                    request: pendingList[index],
                    controller: controller,
                  ),
                ),
                const VerticalSizedBox(),
              ],

              // not pending list
              if (notPendingList.isNotEmpty) ...[
                customListHeaderText(text: 'Riwayat Permintaan'),
                const VerticalSizedBox(height: 0.7),
                ...List.generate(
                  notPendingList.length,
                  (index) => RequestItem(
                    request: notPendingList[index],
                    controller: controller,
                  ),
                ),
                const VerticalSizedBox(height: 2),
              ],
            ],
          );
        }),
      ),
    );
  }
}
