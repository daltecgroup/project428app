import 'dart:async';
import 'dart:convert';
import 'package:abg_pos_app/app/data/models/Menu.dart';
import 'package:abg_pos_app/app/data/repositories/menu_repository.dart';
import 'package:get/get.dart';
import '../routes/app_pages.dart';
import '../shared/alert_snackbar.dart';
import '../shared/custom_alert.dart';
import '../utils/constants/app_constants.dart';
import '../utils/helpers/file_helper.dart';
import '../utils/helpers/get_storage_helper.dart';
import '../utils/helpers/logger_helper.dart';
import '../utils/helpers/text_helper.dart';

class MenuDataController extends GetxController {
  MenuDataController({required this.repository, this.isRefresh});
  final MenuRepository repository;

  final RxList<Menu> menus = <Menu>[].obs;
  final Rx<Menu?> selectedMenu = Rx<Menu?>(null);
  final Rx<DateTime?> latestSync = (null as DateTime?).obs;
  final RxBool isLoading = false.obs;

  Timer? _syncTimer;
  bool? isRefresh;

  @override
  void onInit() {
    super.onInit();
    syncData(refresh: isRefresh);
  }

  @override
  void onReady() {
    super.onReady();
    setLatestSync();
    _startAutoSync();
  }

  @override
  void onClose() {
    super.onClose();
    _stopAutoSync();
  }

  void _startAutoSync() {
    if (AppConstants.RUN_SYNC_TIMER) {
      LoggerHelper.logInfo('Menu AutoSync started...');
      _syncTimer = Timer.periodic(Duration(seconds: AppConstants.SYNC_TIMER), (
        timer,
      ) async {
        await syncData(refresh: true);
      });
    }
  }

  void _stopAutoSync() {
    if (_syncTimer != null) {
      _syncTimer!.cancel();
      _syncTimer = null;
      LoggerHelper.logInfo('Menu AutoSync stopped...');
    }
  }

  void stopAutoSync() => _stopAutoSync();

  DateTime? get latestSyncTime {
    DateTime? time = null as DateTime?;
    if (!box.isNull(AppConstants.KEY_MENU_LATEST)) {
      time = DateTime.fromMillisecondsSinceEpoch(
        box.getValue(AppConstants.KEY_MENU_LATEST),
      );
    }
    return time;
  }

  void setLatestSync() {
    latestSync.value = latestSyncTime;
    latestSync.refresh();
  }

  Future<void> syncData({bool? refresh}) async {
    isLoading.value = true;
    try {
      final file = await getLocalFile(AppConstants.FILENAME_MENU_DATA);
      if (await file.exists() && (refresh == null || refresh == false)) {
        LoggerHelper.logInfo('Set initial menu from local data');
        final List<Menu> menuList =
            (json.decode(await file.readAsString()) as List<dynamic>)
                .map((json) => Menu.fromJson(json as Map<String, dynamic>))
                .toList();
        menuList.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        menus.assignAll(menuList);
      } else {
        // if (await file.exists() && refresh != null && refresh == true) {
        //   await file.delete();
        // }
        LoggerHelper.logInfo('Set initial menu from server');

        final List<Menu> fetchedMenus = await repository.getMenu();
        if (fetchedMenus.isNotEmpty) {
          menus.assignAll(fetchedMenus);
        } else {
          menus.clear();
        }

        await file.writeAsString(
          menus.map((menu) => json.encode(menu.toJson())).toList().toString(),
        );
        await box.setValue(
          AppConstants.KEY_MENU_LATEST,
          DateTime.now().toUtc().toLocal().millisecondsSinceEpoch,
        );
        setLatestSync();
      }
    } catch (e) {
      LoggerHelper.logError(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createMenu(dynamic data) async {
    isLoading.value = true;
    try {
      final response = await repository.createMenu(data);
      switch (response['statusCode']) {
        case 201:
          successSnackbar(response['message']);
          await syncData(refresh: true);
          Get.offNamed(Routes.MENU_LIST);
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

  Future<void> updateMenu({
    required String id,
    dynamic data,
    String? backRoute,
  }) async {
    isLoading.value = true;
    try {
      final response = await repository.updateMenu(id, data);
      switch (response['statusCode']) {
        case 200:
          await syncData(refresh: true);
          selectedMenu.value = response['menu'];
          selectedMenu.refresh();
          if (backRoute != null) Get.toNamed(backRoute);
          customSuccessAlertDialog(response['message']);
          break;
        default:
          customAlertDialog(response['message']);
      }
    } catch (e) {
      LoggerHelper.logError(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateMenuImage({
    required String id,
    dynamic data,
    String? backRoute,
  }) async {
    isLoading.value = true;
    try {
      final response = await repository.updateMenuImage(id, data);
      switch (response['statusCode']) {
        case 200:
          await syncData(refresh: true);
          selectedMenu.value = response['menu'];
          selectedMenu.refresh();
          if (backRoute != null) Get.toNamed(backRoute);
          customSuccessAlertDialog(response['message']);
          break;
        default:
          customAlertDialog(response['message']);
      }
    } catch (e) {
      LoggerHelper.logError(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> changeStatus(String id, bool targetStatus) async {
    isLoading.value = true;
    try {
      await updateMenu(id: id, data: json.encode({'isActive': targetStatus}));
    } catch (e) {
      LoggerHelper.logError(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void deleteConfirmation() async {
    customDeleteAlertDialog(
      'Yakin menghapus ${normalizeName(selectedMenu.value!.name)}?',
      () {
        Get.back();
        deleteMenu();
      },
    );
  }

  Future<void> deleteMenu() async {
    try {
      final response = await repository.deleteMenu(selectedMenu.value!.id);
      switch (response['statusCode']) {
        case 200:
          await syncData(refresh: true);
          Get.offNamed(Routes.MENU_LIST);
          customSuccessAlertDialog(response['message']);
          break;
        default:
          customAlertDialog(response['message']);
      }
    } catch (e) {
      LoggerHelper.logError(e.toString());
    }
  }

  Map<String, List<Menu>> get groupedMenuByCategory {
    final Map<String, List<Menu>> grouped = {};
    if (menus.isEmpty) return grouped;
    for (var menu in menus) {
      if (grouped.containsKey(menu.menuCategoryId)) {
        grouped[menu.menuCategoryId]!.add(menu);
      } else {
        grouped[menu.menuCategoryId] = [menu];
      }
    }
    // reorder the grouped map values length, longest first
    grouped.forEach((key, value) {
      value.sort((a, b) => b.name.compareTo(a.name));
    });
    // sort the grouped map by key (category name)
    final sortedKeys = grouped.keys.toList()..sort((a, b) => a.compareTo(b));
    final Map<String, List<Menu>> sortedGrouped = {};
    for (var key in sortedKeys) {
      sortedGrouped[key] = grouped[key]!;
    }
    grouped.clear();
    grouped.addAll(sortedGrouped);
    return grouped;
  }

  Menu? getMenu(String menuId) {
    if (menus.isEmpty) return null;
    return menus.firstWhereOrNull((e) => e.id == menuId);
  }
}
