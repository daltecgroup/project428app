import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:abg_pos_app/app/utils/helpers/data_helper.dart';
import 'package:abg_pos_app/app/utils/services/auth_service.dart';
import 'package:get/get.dart';
import '../routes/app_pages.dart';
import '../data/models/User.dart';
import '../shared/custom_alert.dart';
import '../shared/alert_snackbar.dart';
import '../utils/helpers/time_helper.dart';
import '../utils/helpers/file_helper.dart';
import '../utils/helpers/logger_helper.dart';
import '../utils/constants/app_constants.dart';
import '../utils/helpers/get_storage_helper.dart';
import '../data/repositories/user_repository.dart';

class UserDataController extends GetxController {
  UserDataController({required this.userRepository});
  final UserRepository userRepository;
  final AuthService authService = Get.find<AuthService>();

  late File file;

  final RxList<User> users = <User>[].obs;
  final Rx<User?> selectedUser = Rx<User?>(null);

  final RxBool isLoading = false.obs;
  Timer? _syncTimer;

  @override
  Future<void> onInit() async {
    super.onInit();
    file = await getLocalFile(AppConstants.FILENAME_USER_DATA);
    await syncData();
  }

  @override
  void onReady() {
    super.onReady();
    _startAutoSync();
  }

  @override
  void onClose() {
    super.onClose();
    _stopAutoSync();
  }

  Future<void> syncData() async {
    if (box.isNull(AppConstants.KEY_IS_LOGGED_IN)) return;
    isLoading.value = true;
    int? latestSyncTime = box.getValue(AppConstants.KEY_USER_DATA_LATEST);
    try {
      if (latestSyncTime == null || await file.exists() == false) {
        LoggerHelper.logInfo('Set initial user data from server');
        await _setInitialDataFromServer();
      } else {
        final syncData = await userRepository.syncUsers(
          latestSyncTime,
          await _getLocalDataIdList,
        );
        if (syncData.isNotEmpty &&
            (syncData['toAdd']!.isNotEmpty ||
                syncData['toDelete']!.isNotEmpty ||
                syncData['toUpdate']!.isNotEmpty)) {
          LoggerHelper.logInfo('Sync user data from server');
          await _setUsersFromServerData(syncData);
        } else {
          LoggerHelper.logInfo('Sync user data from local storage');
          _setUsersFromLocalData();
        }
      }
    } catch (e) {
      LoggerHelper.logError(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void _startAutoSync() {
    if (AppConstants.RUN_SYNC_TIMER) {
      LoggerHelper.logInfo('User AutoSync started...');
      _syncTimer = Timer.periodic(Duration(seconds: AppConstants.SYNC_TIMER), (
        timer,
      ) async {
        await syncData();
      });
    }
  }

  void _stopAutoSync() {
    if (_syncTimer != null) {
      _syncTimer!.cancel();
      _syncTimer = null;
      LoggerHelper.logInfo('User AutoSync stopped...');
    }
  }

  void stopAutoSync() => _stopAutoSync();

  Future<void> _setUsersFromServerData(Map<String, List<User>> newData) async {
    DateTime latest = tenYearsAgo;
    List oldDataRaw = json.decode(await file.readAsString()) as List<dynamic>;

    final Map<String, User> userMap = {};
    if (oldDataRaw.isNotEmpty) {
      for (var userJson in oldDataRaw) {
        try {
          final user = User.fromJson(userJson);
          userMap[user.id] = user;
          if (user.updatedAt.isAfter(latest)) {
            latest = user.updatedAt;
          }
        } catch (e) {
          LoggerHelper.logError(
            'Error parsing old user data: $e, data: $userJson',
          );
          if (await file.exists()) await file.delete();
        }
      }
    }

    final List<User>? toDeleteList = newData['toDelete'];
    if (toDeleteList != null && toDeleteList.isNotEmpty) {
      for (final userToDelete in toDeleteList) {
        userMap.remove(userToDelete.id);
      }
    }

    final List<User>? toUpdateList = newData['toUpdate'];
    if (toUpdateList != null && toUpdateList.isNotEmpty) {
      for (final userToUpdate in toUpdateList) {
        userMap[userToUpdate.id] = userToUpdate;
        if (userToUpdate.updatedAt.isAfter(latest)) {
          latest = userToUpdate.updatedAt;
        }
      }
    }

    final List<User>? toAddList = newData['toAdd'];
    if (toAddList != null && toAddList.isNotEmpty) {
      for (final userToAdd in toAddList) {
        userMap[userToAdd.id] = userToAdd;
        if (userToAdd.updatedAt.isAfter(latest)) {
          latest = userToAdd.updatedAt;
        }
      }
    }

    List<User> finalUserList = userMap.values.toList();
    finalUserList.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    await box.setValue(
      AppConstants.KEY_USER_DATA_LATEST,
      latest.millisecondsSinceEpoch,
    );

    users.value = finalUserList;
    await file.writeAsString(
      json.encode(finalUserList.map((user) => user.toJson()).toList()),
    );
  }

  Future<void> _setUsersFromLocalData() async {
    final List<User> userList =
        (json.decode(await file.readAsString()) as List<dynamic>)
            .map((json) => User.fromJson(json as Map<String, dynamic>))
            .toList();
    userList.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    users.assignAll(userList);
  }

  Future<void> _setInitialDataFromServer() async {
    DateTime latest = tenYearsAgo;
    try {
      final List<User> fetchedUsers = await userRepository.getUsers();
      if (fetchedUsers.isNotEmpty) {
        for (var user in fetchedUsers) {
          if (user.updatedAt.isAfter(latest)) latest = user.updatedAt;
        }
        box.setValue(
          AppConstants.KEY_USER_DATA_LATEST,
          latest.millisecondsSinceEpoch,
        );
      } else {
        box.removeValue(AppConstants.KEY_USER_DATA_LATEST);
      }
      users.assignAll(fetchedUsers);
      users.sort(
        (a, b) => b.createdAt.millisecondsSinceEpoch.compareTo(
          a.createdAt.millisecondsSinceEpoch,
        ),
      );
      await file.writeAsString(
        users.map((user) => json.encode(user.toJson())).toList().toString(),
      );
    } catch (e) {
      LoggerHelper.logError(e.toString());
    }
  }

  Future<List<String>> get _getLocalDataIdList async {
    return (json.decode(await file.readAsString()) as List<dynamic>)
        .map((userJson) => User.fromJson(userJson as Map<String, dynamic>).id)
        .toList();
  }

  Future<void> createUser(dynamic data) async {
    isLoading.value = true;
    try {
      final response = await userRepository.createUser(data);
      switch (response['statusCode']) {
        case 201:
          successSnackbar(response['message']);
          await syncData();
          Get.offNamed(Routes.USER_LIST);
          break;
        default:
          successSnackbar(response['message']);
      }
    } catch (e) {
      LoggerHelper.logError(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> changeUserStatus() async {
    isLoading.value = true;
    if (selectedUser.value!.id == authService.currentUser.value!.id) {
      customAlertDialog('Tidak dapat menonaktifkan akun sendiri');
      isLoading.value = false;
      return;
    }
    try {
      final bool targetStatus = !selectedUser.value!.isActive;
      await updateUser(data: json.encode({'isActive': targetStatus}));
    } catch (e) {
      LoggerHelper.logError(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateUser({dynamic data, String? backRoute}) async {
    isLoading.value = true;
    try {
      if (selectedUser.value != null) {
        final response = await userRepository.updateUser(
          selectedUser.value!.id,
          data,
        );
        switch (response['statusCode']) {
          case 200:
            await syncData();
            selectedUser.value = User.fromJson(response['user']);
            selectedUser.refresh();
            if (backRoute != null) Get.offNamed(backRoute);
            customSuccessAlertDialog(response['message']);
            break;
          default:
            customAlertDialog(response['message']);
        }
      } else {
        customAlertDialog('Data Pengguna gagal dimuat');
      }
    } catch (e) {
      LoggerHelper.logError(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void deleteConfirmation() async {
    customDeleteAlertDialog('Yakin menghapus ${selectedUser.value!.name}?', () {
      softDeleteUser();
    });
  }

  Future<void> softDeleteUser() async {
    isLoading.value = true;
    try {
      if (selectedUser.value != null) {
        final response = await userRepository.softDeleteUser(
          selectedUser.value!.id,
        );
        switch (response['statusCode']) {
          case 200:
            await syncData();
            selectedUser.value = null as User?;
            Get.offNamed(Routes.USER_LIST);
            customSuccessAlertDialog(response['message']);
            break;
          default:
            customAlertDialog(response['message']);
        }
      } else {
        customAlertDialog('Data Pengguna gagal dimuat');
      }
    } catch (e) {
      LoggerHelper.logError(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  List<User> excludedUsers(List exclude) {
    return users.where((user) => !exclude.contains(user.id)).toList();
  }

  List<User> getUsersByRoles(List roles, {List? exclude}) {
    if (users.isEmpty || !allStrings(roles)) return [];

    final source =
        (exclude != null && exclude.isNotEmpty && allStrings(exclude))
        ? excludedUsers(exclude)
        : users;

    return source
        .where((user) => user.roles.any((role) => roles.contains(role)))
        .toList();
  }

  List<User> getUsersByList(List idList, {List? roles}) {
    if (users.isEmpty) return [];

    final source = (roles != null && roles.isNotEmpty && allStrings(roles))
        ? getUsersByRoles(roles)
        : users;

    return source.where((user) => idList.contains(user.id)).toList();
  }

  User? getUser(String id) {
    return users.firstWhereOrNull((e) => e.id == id);
  }
}
