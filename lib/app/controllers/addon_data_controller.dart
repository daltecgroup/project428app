import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import '../data/models/Addon.dart';
import '../data/repositories/addon_repository.dart';
import '../routes/app_pages.dart';
import '../shared/alert_snackbar.dart';
import '../shared/custom_alert.dart';
import '../utils/constants/app_constants.dart';
import '../utils/helpers/file_helper.dart';
import '../utils/helpers/get_storage_helper.dart';
import '../utils/helpers/logger_helper.dart';
import '../utils/helpers/text_helper.dart';

class AddonDataController extends GetxController {
  AddonDataController({required this.repository});
  final AddonRepository repository;

  final RxList<Addon> addons = <Addon>[].obs;
  final Rx<Addon?> selectedAddon = Rx<Addon?>(null);
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
      LoggerHelper.logInfo('Addon AutoSync started...');
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
      LoggerHelper.logInfo('Addon AutoSync stopped...');
    }
  }

  void stopAutoSync() => _stopAutoSync();

  DateTime? get latestSyncTime {
    DateTime? time = null as DateTime?;
    if (!box.isNull(AppConstants.KEY_ADDON_LATEST)) {
      time = DateTime.fromMillisecondsSinceEpoch(
        box.getValue(AppConstants.KEY_ADDON_LATEST),
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
      final file = await getLocalFile(AppConstants.FILENAME_ADDON_DATA);
      if (await file.exists() && (refresh == null || refresh == false)) {
        LoggerHelper.logInfo('Set initial addons from local data');
        final List<Addon> addonList =
            (json.decode(await file.readAsString()) as List<dynamic>)
                .map((json) => Addon.fromJson(json as Map<String, dynamic>))
                .toList();
        addonList.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        addons.assignAll(addonList);
      } else {
        if (await file.exists() && refresh != null && refresh == true)
          await file.delete();
        LoggerHelper.logInfo('Set initial addons from server');

        final List<Addon> fetchedAddons = await repository.getAddons();
        if (fetchedAddons.isNotEmpty) {
          addons.assignAll(fetchedAddons);
        } else {
          addons.clear();
        }

        await file.writeAsString(
          addons
              .map((addon) => json.encode(addon.toJson()))
              .toList()
              .toString(),
        );
        await box.setValue(
          AppConstants.KEY_ADDON_LATEST,
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

  Future<void> createAddon(dynamic data) async {
    isLoading.value = true;
    try {
      final response = await repository.createAddon(data);
      switch (response['statusCode']) {
        case 201:
          successSnackbar(response['message']);
          await syncData(refresh: true);
          Get.offNamed(Routes.ADDON_LIST);
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

  Future<void> updateAddon({
    required String id,
    dynamic data,
    String? backRoute,
  }) async {
    isLoading.value = true;
    try {
      final response = await repository.updateAddon(id, data);
      switch (response['statusCode']) {
        case 200:
          await syncData(refresh: true);
          selectedAddon.value = response['addon'];
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
      await updateAddon(id: id, data: json.encode({'isActive': targetStatus}));
    } catch (e) {
      LoggerHelper.logError(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void deleteConfirmation() async {
    customDeleteAlertDialog(
      'Yakin menghapus ${normalizeName(selectedAddon.value!.name)}?',
      () {
        Get.back();
        deleteAddon();
      },
    );
  }

  Future<void> deleteAddon() async {
    try {
      final response = await repository.deleteAddon(selectedAddon.value!.id);
      switch (response['statusCode']) {
        case 200:
          await syncData(refresh: true);
          Get.offNamed(Routes.ADDON_LIST);
          customSuccessAlertDialog(response['message']);
          break;
        default:
          customAlertDialog(response['message']);
      }
    } catch (e) {
      LoggerHelper.logError(e.toString());
    }
  }

  Addon? getAddon(String addonId) {
    return addons.firstWhereOrNull((e) => e.id == addonId);
  }
}
