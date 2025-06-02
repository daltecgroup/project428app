import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/user_filter.dart';
import '../../../services/user_service.dart';

class UserController extends GetxController {
  UserService UserS = Get.find<UserService>();
  Rx<UserFilter> filter = UserFilter(keyword: null).obs;

  late TextEditingController searchc;

  @override
  Future<void> onInit() async {
    searchc = TextEditingController();
    await UserS.getUsers();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    searchc.dispose();
    super.onClose();
  }

  Future<void> getUsers() async {
    await UserS.getUsers();
  }
}
