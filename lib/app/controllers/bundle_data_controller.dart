import 'dart:async';
import 'dart:convert';

import 'package:abg_pos_app/app/data/models/Bundle.dart';
import 'package:abg_pos_app/app/data/repositories/bundle_repository.dart';
import 'package:get/get.dart';

import '../routes/app_pages.dart';
import '../shared/alert_snackbar.dart';
import '../shared/custom_alert.dart';
import '../utils/constants/app_constants.dart';
import '../utils/helpers/file_helper.dart';
import '../utils/helpers/get_storage_helper.dart';
import '../utils/helpers/logger_helper.dart';
import '../utils/helpers/text_helper.dart';

class BundleDataController extends GetxController {
  BundleDataController({required this.repository});
  final BundleRepository repository;

  BoxHelper box = BoxHelper();

  final RxList<Bundle> bundles = <Bundle>[].obs;
  final Rx<Bundle?> selectedBundle = Rx<Bundle?>(null);
  final Rx<DateTime?> latestSync = (null as DateTime?).obs;
  final RxBool isLoading = false.obs;

  Timer? _syncTimer;

  @override
  void onInit() {
    super.onInit();
    syncData();
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
      LoggerHelper.logInfo('Bundle AutoSync started...');
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
      LoggerHelper.logInfo('Bundle AutoSync stopped...');
    }
  }

  void stopAutoSync() => _stopAutoSync();

  DateTime? get latestSyncTime {
    DateTime? time = null as DateTime?;
    if (!box.isNull(AppConstants.KEY_BUNDLE_LATEST)) {
      time = DateTime.fromMillisecondsSinceEpoch(
        box.getValue(AppConstants.KEY_BUNDLE_LATEST),
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
      final file = await getLocalFile(AppConstants.FILENAME_BUNDLE_DATA);
      if (await file.exists() && (refresh == null || refresh == false)) {
        LoggerHelper.logInfo('Set initial bundle from local data');
        final List<Bundle> bundleList =
            (json.decode(await file.readAsString()) as List<dynamic>)
                .map((json) => Bundle.fromJson(json as Map<String, dynamic>))
                .toList();
        bundleList.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        bundles.assignAll(bundleList);
      } else {
        if (await file.exists() && refresh != null && refresh == true)
          await file.delete();
        LoggerHelper.logInfo('Set initial bundle from server');

        final List<Bundle> fetchedBundles = await repository.getBundles();
        if (fetchedBundles.isNotEmpty) {
          bundles.assignAll(fetchedBundles);
        } else {
          bundles.clear();
        }

        await file.writeAsString(
          bundles
              .map((bundle) => json.encode(bundle.toJson()))
              .toList()
              .toString(),
        );
        await box.setValue(
          AppConstants.KEY_BUNDLE_LATEST,
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

  Future<void> createBundle(dynamic data) async {
    isLoading.value = true;
    try {
      final response = await repository.createBundle(data);
      switch (response['statusCode']) {
        case 201:
          successSnackbar(response['message']);
          await syncData(refresh: true);
          Get.offNamed(Routes.BUNDLE_LIST);
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

  Future<void> updateBundle({
    required String id,
    dynamic data,
    String? backRoute,
  }) async {
    isLoading.value = true;
    try {
      final response = await repository.updateBundle(id, data);
      switch (response['statusCode']) {
        case 200:
          await syncData(refresh: true);
          selectedBundle.value = response['bundle'];
          selectedBundle.refresh();
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
      await updateBundle(id: id, data: json.encode({'isActive': targetStatus}));
    } catch (e) {
      LoggerHelper.logError(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void deleteConfirmation() async {
    customDeleteAlertDialog(
      'Yakin menghapus ${normalizeName(selectedBundle.value!.name)}?',
      () {
        Get.back();
        deleteBundle();
      },
    );
  }

  Future<void> deleteBundle() async {
    try {
      final response = await repository.deleteBundle(selectedBundle.value!.id);
      switch (response['statusCode']) {
        case 200:
          await syncData(refresh: true);
          Get.offNamed(Routes.BUNDLE_LIST);
          customSuccessAlertDialog(response['message']);
          break;
        default:
          customAlertDialog(response['message']);
      }
    } catch (e) {
      LoggerHelper.logError(e.toString());
    }
  }

  Bundle? getBundle(String bundleId) {
    if (bundles.isEmpty) return null;
    return bundles.firstWhereOrNull((e) => e.id == bundleId);
  }
}
