import 'package:get/get.dart';
import 'package:project428app/app/data/operator_provider.dart';

class OperatorService extends GetxService {
  OperatorProvider OperatorP = OperatorProvider();
  RxString currentOutletCode = ''.obs;
  RxString currentOutletName = ''.obs;

  final count = 0.obs;
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

  Future<void> setCurrentOutlet(String id) async {
    await OperatorP.getOperatorOutletById(id).then((res) {
      if (res.statusCode == 200) {
        currentOutletCode.value = res.body['code'];
        currentOutletName.value = res.body['name'];
      }
    });
  }
}
