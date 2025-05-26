import 'package:get/get.dart';

class InputNumberController extends GetxController {
  RxString result = '0'.obs;

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

  void numberPress(int number) {
    if (result.value[0] == '0') {
      result.value = number.toString();
    } else {
      if (result.value.length < 8) {
        result.value = '${result.value}$number';
      }
    }
  }

  void clear() {
    result.value = '0';
  }

  void delete() {
    if (result.value.length == 1) {
      result.value = '0';
    } else {
      result.value = result.value.substring(0, result.value.length - 1);
    }
  }
}
