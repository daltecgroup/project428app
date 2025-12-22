import 'package:get/get.dart';

class NotificationDetailController extends GetxController {

   RxString title = 'Detail Notifikasi'.obs;
   RxString detail = '-'.obs;
  
  @override
  void onInit() {
    super.onInit();
    assignData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void assignData(){
    final argData = Get.arguments is Map ? Get.arguments as Map : null;
    if(argData == null) return;
    title.value = argData['title'] ?? title.value;
    detail.value = argData['detail'] ?? detail.value;
  
  }
}
