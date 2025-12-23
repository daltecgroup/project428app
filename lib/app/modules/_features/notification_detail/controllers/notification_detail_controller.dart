import 'package:get/get.dart';

class NotificationDetailController extends GetxController {

   RxString title = 'Detail Notifikasi'.obs;
   RxString detail = '-'.obs;
   RxString outlet = '-'.obs;
   Rx<DateTime> createdAt = DateTime.now().obs;
   RxString status = 'Baru'.obs;
  
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
    status.value = argData['status'] ?? status.value;
    createdAt.value = DateTime.parse(argData['createdAt'] ?? createdAt.value.toString());
    outlet.value = argData['outlet'] ?? outlet.value;
  
  }
}
