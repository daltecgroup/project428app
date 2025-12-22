import 'package:abg_pos_app/app/controllers/request_data_controller.dart';
import 'package:get/get.dart';

import '../../../../data/models/Request.dart';

class RequestController extends GetxController {
  RequestController({required this.data});
  final RequestDataController data;

  @override
  Future<void> onInit() async {
    super.onInit();
    if(data.requests.isEmpty)
    await data.syncData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void selectRequest(Request request){
    data.selectedRequest.value = request;
    data.selectedRequest.refresh();
  }

}
