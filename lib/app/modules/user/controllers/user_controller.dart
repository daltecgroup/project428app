import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/user.dart';
import '../../../services/user_service.dart';

class UserController extends GetxController {
  UserService UserS = Get.find<UserService>();
  late TextEditingController searchc;
  RxList<User> filteredUser = <User>[].obs;
  RxList<User> searchedUser = <User>[].obs;

  // variabel filter
  RxBool isAsc = true.obs;
  RxBool isNewestFirst = true.obs;
  RxBool showActive = false.obs;
  RxBool showInnactive = false.obs;
  RxBool showAdmin = false.obs;
  RxBool showFranchisee = false.obs;
  RxBool showSpvAre = false.obs;
  RxBool showOperator = false.obs;
  RxBool isFilterOn = true.obs;

  @override
  Future<void> onInit() async {
    searchc = TextEditingController();
    await UserS.getUsers();
    filterUsers();
    searchUsers();
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
    filterUsers();
    searchUsers();
  }

  void resetFilter() {
    isNewestFirst.value = true;
    showActive.value = false;
    showInnactive.value = false;
    showAdmin.value = false;
    showFranchisee.value = false;
    showSpvAre.value = false;
    showOperator.value = false;
    filterUsers();
  }

  void searchUsers() {
    searchedUser.clear();
    RxList<User> newList = <User>[].obs;

    for (var user in filteredUser) {
      if (user.name.toString().toLowerCase().contains(
            searchc.text.toLowerCase(),
          ) ||
          user.userId.toString().toLowerCase().contains(
            searchc.text.toLowerCase(),
          )) {
        newList.add(user);
      }
    }
    searchedUser = newList;

    if (isNewestFirst.isTrue) {
      searchedUser.sort((a, b) {
        return b.createdAt.millisecondsSinceEpoch.compareTo(
          a.createdAt.millisecondsSinceEpoch,
        );
      });
    } else {
      searchedUser.sort((a, b) {
        return a.createdAt.millisecondsSinceEpoch.compareTo(
          b.createdAt.millisecondsSinceEpoch,
        );
      });
    }
  }

  void filterUsers() {
    filteredUser.clear();
    RxList<User> newList = <User>[].obs;

    for (User user in UserS.users) {
      List role = user.role;
      bool add = false;

      if (!showAdmin.value &&
          !showFranchisee.value &&
          !showSpvAre.value &&
          !showOperator.value) {
        add = true;
      } else {
        if (showAdmin.value) {
          if (role.contains('admin')) {
            add = true;
          }
        }
        if (showFranchisee.value) {
          if (role.contains('franchisee')) {
            add = true;
          }
        }
        if (showSpvAre.value) {
          if (role.contains('spvarea')) {
            add = true;
          }
        }
        if (showOperator.value) {
          if (role.contains('operator')) {
            add = true;
          }
        }
      }

      if (add) {
        if (showActive.value) {
          if (user.isActive) {
            add = true;
          } else {
            add = false;
          }
        }

        if (showInnactive.value) {
          if (!user.isActive) {
            add = true;
          } else {
            add = false;
          }
        }

        if (showActive.value && showInnactive.value) {
          add = true;
        }
      }

      if (add) {
        newList.add(user);
        // isFilterOn.value = true;
      }
    }

    if (isAsc.value) {
      newList.sort(
        (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()),
      );
    } else {
      newList.sort(
        (a, b) => b.name.toLowerCase().compareTo(a.name.toLowerCase()),
      );
    }
    filteredUser = newList;
    filteredUser.refresh();
    searchUsers();
  }
}
