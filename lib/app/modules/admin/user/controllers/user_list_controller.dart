import 'package:abg_pos_app/app/controllers/user_data_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/user_filter.dart';

class UserListController extends GetxController {
  UserListController({required this.userData});
  UserDataController userData;

  Rx<UserFilter> filter = UserFilter(keyword: null).obs;
  late TextEditingController searchC;

  @override
  void onInit() {
    super.onInit();
    searchC = TextEditingController();
  }

  @override
  void onClose() {
    super.onClose();
    searchC.dispose();
  }
}
