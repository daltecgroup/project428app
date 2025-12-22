import 'package:abg_pos_app/app/data/models/Request.dart';
import 'package:abg_pos_app/app/shared/custom_alert.dart';
import 'package:get/get.dart';

import '../../../../controllers/request_data_controller.dart';

class RequestDetailController extends GetxController {
  RequestDetailController({required this.data});
  final RequestDataController data;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Request? get selectedRequest => data.selectedRequest.value;

  Future<dynamic> deleteRequest(){
    return customDeleteAlertDialog('Yakin hapus permintaan ini?', () {
    },);
  }

  void approveRequest() => data.approveRequest();

  void rejectRequest() => data.rejectRequest();
}
