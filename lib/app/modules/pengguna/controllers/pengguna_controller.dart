import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project428app/app/constants.dart';
import 'package:project428app/app/data/user_provider.dart';
import 'package:project428app/app/widgets/format_waktu.dart';

class PenggunaController extends GetxController {
  UserProvider User = UserProvider();
  GetStorage box = GetStorage();
  late TextEditingController searchc;

  var users = [].obs;
  var filteredUser = [].obs;
  var searchedUser = [].obs;

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
  void onInit() {
    searchc = TextEditingController();
    showUsers();
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

  void setCurrentUserDetail(String userId) {
    box.write(kCurrentUserDetailId, userId);
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

  Future<Response> getUsers() {
    return User.getUsers().then((res) {
      users.clear();
      print('Get users from database');
      box.write(kAllUserData, res.body);
      users.value = res.body;
      // print(GetMillisecondSinceEpoch(users[0]['createdAt']));
      // users.refresh();
      filterUsers();
      searchUsers();
      return res;
    });
  }

  void showUsers() async {
    // if (box.read(kAllUserData) != null) {
    //   print('Set users from storage');
    //   users.value = box.read(kAllUserData);
    //   users.refresh();
    //   filterUsers();
    //   searchUsers();
    // } else {
    //   await getUsers();
    // }
    await getUsers();
  }

  void searchUsers() {
    searchedUser.clear();
    RxList newList = [].obs;

    for (var user in filteredUser) {
      if (user['name'].toString().toLowerCase().contains(
            searchc.text.toLowerCase(),
          ) ||
          user['userId'].toString().toLowerCase().contains(
            searchc.text.toLowerCase(),
          )) {
        newList.add(user);
      }
    }
    searchedUser = newList;

    if (isNewestFirst.isTrue) {
      searchedUser.sort((a, b) {
        return GetMillisecondSinceEpoch(
          b['createdAt'],
        ).compareTo(GetMillisecondSinceEpoch(a['createdAt']));
      });
    } else {
      searchedUser.sort((a, b) {
        return GetMillisecondSinceEpoch(
          a['createdAt'],
        ).compareTo(GetMillisecondSinceEpoch(b['createdAt']));
      });
    }
  }

  void filterUsers() {
    filteredUser.clear();
    RxList newList = [].obs;

    for (var user in users) {
      List role = user['role'];
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
          if (user['isActive']) {
            add = true;
          } else {
            add = false;
          }
        }

        if (showInnactive.value) {
          if (!user['isActive']) {
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
        (a, b) => a['name'].toLowerCase().compareTo(b['name'].toLowerCase()),
      );
    } else {
      newList.sort(
        (a, b) => b['name'].toLowerCase().compareTo(a['name'].toLowerCase()),
      );
    }
    filteredUser = newList;
    filteredUser.refresh();
    searchUsers();
  }
}
