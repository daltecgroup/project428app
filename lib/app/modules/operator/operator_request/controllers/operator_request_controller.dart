import 'package:get/get.dart';

import '../../../../controllers/request_data_controller.dart';
import '../../../../data/models/Request.dart';

class OperatorRequestController extends GetxController {
  OperatorRequestController({required this.data});
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
