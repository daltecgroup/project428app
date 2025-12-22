import 'package:abg_pos_app/app/shared/custom_alert.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../data/models/Request.dart';
import '../../../../routes/app_pages.dart';
import '../../../../shared/custom_appbar_lite.dart';
import '../../../../shared/horizontal_sized_box.dart';
import '../../../../shared/request_item_badge.dart';
import '../../../../shared/request_subtitle.dart';
import '../../../../shared/buttons/delete_icon_button.dart';
import '../../../../shared/custom_card.dart';
import '../../../../shared/vertical_sized_box.dart';
import '../../../../utils/helpers/text_helper.dart';
import '../../../../utils/helpers/user_helper.dart';
import '../../../../utils/constants/padding_constants.dart';
import '../../../../utils/helpers/time_helper.dart';
import '../../../../utils/theme/button_style.dart';
import '../../../../utils/theme/custom_text.dart';
import '../../../../utils/theme/text_style.dart';
import '../controllers/request_detail_controller.dart';

class RequestDetailView extends GetView<RequestDetailController> {
  const RequestDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarLite(
        titleWidget: Obx(() {
          final request = controller.selectedRequest;
          if (request == null) return Text('Detail Permintaan');
          return Text(normalizeName(request.outlet.name));
        }),
        actions: [
          DeleteIconButton(
            onPressed: () {
              if(controller.data.selectedRequest.value != null){
                if(controller.data.selectedRequest.value!.isCompleted){
                  customAlertDialog('Permintaan yang sudah direspon tidak dapat dihapus');
                  return;
                }
              }
              controller.data.deleteConfirmation();
            },
            tooltip: 'Hapus Permintaan',
          ),
        ],
        backRoute: isOperator? Routes.OPERATOR_REQUEST: Routes.REQUEST,
      ),
      body: Obx(() {
        final request = controller.data.selectedRequest.value;
        if (request == null) return Center(child: CircularProgressIndicator());
        return ListView(
          padding: horizontalPadding,
          children: [
            Text(
              localDateTimeFormat(request.createdAt),
              textAlign: TextAlign.center,
            ),
            const VerticalSizedBox(height: 2),
            _requestDetail(request),
            const VerticalSizedBox(height: 2),
            if (request.isCompleted && request.resolvedBy != null)
              _requestRespond(request),
          ],
        );
      }),
    );
  }

  CustomCard _requestDetail(Request request) {
    return CustomCard(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    customLabelText(text: 'Pengirim'),
                    Text(
                      normalizeName(request.requestedBy.name),
                      overflow: TextOverflow.clip,
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    customLabelText(text: 'Status'),
                    RequestItemBadge(status: request.status),
                  ],
                ),
              ),
            ],
          ),
          const VerticalSizedBox(),
          customLabelText(text: 'Permintaan'),
          RequestSubtitle(type: request.type, targetCode: request.targetCode),
          const VerticalSizedBox(),
          customLabelText(text: 'Alasan'),
          Text(request.reason ?? '', overflow: TextOverflow.clip),
          if (isAdmin && !request.isCompleted) ...[
            const VerticalSizedBox(height: 2),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => controller.rejectRequest(),
                    style: backButtonStyle(),
                    child: Text('Tolak'),
                  ),
                ),
                const HorizontalSizedBox(),
                Expanded(
                  child: TextButton(
                    onPressed: () => controller.approveRequest(),
                    style: nextButtonStyle(),
                    child: Text('Setujui', style: AppTextStyle.buttonText),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  CustomCard _requestRespond(Request request) {
    return CustomCard(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    customLabelText(text: 'Direspon oleh'),
                    Text(
                      request.resolvedBy?.name ?? '',
                      overflow: TextOverflow.clip,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    customLabelText(text: 'Waktu Respon'),
                    Text(
                      contextualLocalDateTimeFormat(request.resolvedAt!).capitalize!,
                      overflow: TextOverflow.clip,
                      textAlign: TextAlign.end,
                    ),
                  ],
                ),
              ),
            ],
          ),

          const VerticalSizedBox(),
          customLabelText(text: 'Catatan'),
          Text(request.adminResponse ?? '-', overflow: TextOverflow.clip),
        ],
      ),
    );
  }
}
