import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/user_filter.dart';
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

  Future<void> getUsers() async {
    await UserS.getUsers();
  }
}
