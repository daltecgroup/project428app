import 'dart:async';

import 'package:get/get.dart';
import 'dart:convert';
import '../data/models/MenuCategory.dart';
import '../data/repositories/menu_category_repository.dart';
import '../routes/app_pages.dart';
import '../shared/alert_snackbar.dart';
import '../shared/custom_alert.dart';
import '../utils/constants/app_constants.dart';
import '../utils/helpers/file_helper.dart';
import '../utils/helpers/get_storage_helper.dart';
import '../utils/helpers/logger_helper.dart';
import '../utils/helpers/text_helper.dart';

class MenuCategoryDataController extends GetxController {
  MenuCategoryDataController({required this.repository});
  final MenuCategoryRepository repository;
  BoxHelper box = BoxHelper();

  final RxList<MenuCategory> categories = <MenuCategory>[].obs;
  final Rx<MenuCategory?> selectedMenuCategory = Rx<MenuCategory?>(null);
  final Rx<DateTime?> latestSync = (null as DateTime?).obs;
  final RxBool isLoading = false.obs;

  Timer? _syncTimer;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    syncData();
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
      LoggerHelper.logInfo('Menu Category AutoSync started...');
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
      LoggerHelper.logInfo('Menu Category AutoSync stopped...');
    }
  }

  void stopAutoSync() => _stopAutoSync();

  DateTime? get latestSyncTime {
    DateTime? time = null as DateTime?;
    if (!box.isNull(AppConstants.KEY_MENU_CATEOGORY_LATEST)) {
      time = DateTime.fromMillisecondsSinceEpoch(
        box.getValue(AppConstants.KEY_MENU_CATEOGORY_LATEST),
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
      final file = await getLocalFile(AppConstants.FILENAME_MENU_CATEGORY_DATA);
      if (await file.exists() && (refresh == null || refresh == false)) {
        LoggerHelper.logInfo('Set initial menu category data from local data');
        final List<MenuCategory> categoryList =
            (json.decode(await file.readAsString()) as List<dynamic>)
                .map(
                  (json) => MenuCategory.fromJson(json as Map<String, dynamic>),
                )
                .toList();
        categoryList.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        categories.assignAll(categoryList);
      } else {
        // if (await file.exists() && refresh != null && refresh == true)
        //   await file.delete();
        LoggerHelper.logInfo('Set initial menu category data from server');

        final List<MenuCategory> fetchedCategories = await repository
            .getMenuCategories();
        if (fetchedCategories.isNotEmpty) {
          categories.assignAll(fetchedCategories);
        } else {
          categories.clear();
        }

        await file.writeAsString(
          categories
              .map((category) => json.encode(category.toJson()))
              .toList()
              .toString(),
        );
        await box.setValue(
          AppConstants.KEY_MENU_CATEOGORY_LATEST,
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

  MenuCategory? getCategory(String id) {
    return categories.firstWhereOrNull((e) => e.id == id);
  }

  String getCategoryName(String id) {
    MenuCategory? category = categories.firstWhereOrNull((e) => e.id == id);

    if (category == null) {
      return 'Non Kategori';
    }

    return category.name;
  }

  Future<void> createMenuCategory(dynamic data) async {
    isLoading.value = true;
    try {
      final response = await repository.createMenuCategory(data);
      switch (response['statusCode']) {
        case 201:
          successSnackbar(response['message']);
          await syncData(refresh: true);
          Get.offNamed(Routes.MENU_CATEGORY_LIST);
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

  Future<void> updateMenuCategory({
    required String id,
    dynamic data,
    String? backRoute,
  }) async {
    isLoading.value = true;
    try {
      final response = await repository.updateMenuCategory(id, data);
      switch (response['statusCode']) {
        case 200:
          await syncData(refresh: true);
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
      await updateMenuCategory(
        id: id,
        data: json.encode({'isActive': targetStatus}),
      );
    } catch (e) {
      LoggerHelper.logError(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void deleteConfirmation(String id, String name) async {
    customDeleteAlertDialog('Yakin menghapus ${normalizeName(name)}?', () {
      Get.back();
      deleteMenuCategory(id);
    });
  }

  Future<void> deleteMenuCategory(String id) async {
    try {
      final response = await repository.deleteMenuCategory(id);
      switch (response['statusCode']) {
        case 200:
          await syncData(refresh: true);
          customSuccessAlertDialog(response['message']);
          break;
        default:
          customAlertDialog(response['message']);
      }
    } catch (e) {
      LoggerHelper.logError(e.toString());
    }
  }
}
