import 'dart:async';
import 'dart:convert';
import 'package:abg_pos_app/app/utils/constants/string_value.dart';
import 'package:abg_pos_app/app/utils/helpers/outlet_helper.dart';
import 'package:abg_pos_app/app/utils/helpers/user_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/models/Request.dart';
import '../data/repositories/request_repository.dart';
import '../routes/app_pages.dart';
import '../shared/alert_snackbar.dart';
import '../shared/custom_alert.dart';
import '../utils/constants/app_constants.dart';
import '../utils/helpers/file_helper.dart';
import '../utils/helpers/get_storage_helper.dart';
import '../utils/helpers/logger_helper.dart';

class RequestDataController extends GetxController {
  RequestDataController({required this.repository});
  final RequestRepository repository;

  final RxList<Request> requests = <Request>[].obs;
  final Rx<Request?> selectedRequest = Rx<Request?>(null);
  final Rx<DateTime?> latestSync = (null as DateTime?).obs;
  final RxBool isLoading = false.obs;

  Timer? _syncTimer;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    await syncData(refresh: true);
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
      LoggerHelper.logInfo('Requests AutoSync started...');
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
      LoggerHelper.logInfo('Request AutoSync stopped...');
    }
  }

  void stopAutoSync() => _stopAutoSync();

  DateTime? get latestSyncTime {
    DateTime? time = null as DateTime?;
    if (!box.isNull(AppConstants.KEY_REQUEST_LATEST)) {
      time = DateTime.fromMillisecondsSinceEpoch(
        box.getValue(AppConstants.KEY_REQUEST_LATEST),
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

    String filter = '';

    if (isOperator && currentOutletId != null) {
      filter = '?outletId=$currentOutletId';
      refresh = true;
    }

    try {
      final file = await getLocalFile(AppConstants.FILENAME_REQUEST_DATA);
      if (await file.exists() && (refresh == null || refresh == false)) {
        LoggerHelper.logInfo('Set initial requests from local data');
        final List<Request> requestList =
            (json.decode(await file.readAsString()) as List<dynamic>)
                .map((json) => Request.fromJson(json as Map<String, dynamic>))
                .toList();
        requestList.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        requests.assignAll(requestList);
      } else {
        if (await file.exists() && refresh != null && refresh == true)
          await file.delete();
        LoggerHelper.logInfo('Set initial requests from server');

        final List<Request> fetchedRequests = await repository.getAllRequest(
          filter,
        );
        if (fetchedRequests.isNotEmpty) {
          requests.assignAll(fetchedRequests);
        } else {
          requests.clear();
        }

        await file.writeAsString(
          requests
              .map((request) => json.encode(request.toJson()))
              .toList()
              .toString(),
        );
        await box.setValue(
          AppConstants.KEY_REQUEST_LATEST,
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

  Future<void> createRequest(
    String outletId,
    String type,
    String targetId,
  ) async {
    isLoading.value = true;

    String note = '';
    final noteC = TextEditingController();
    await customTextInputDialog(
      controller: noteC,
      title: 'Catatan',
      inputType: TextInputType.text,
      maxLines: 2,
    );

    note = noteC.text;
    noteC.clear();

    if (note == '') {
      await customAlertDialog('Alasan harus diisi');
      isLoading.value = false;
      noteC.dispose();
      return;
    }

    final rawData = {
      'outletId': outletId,
      'type': type,
      'targetId': targetId,
      'reason': note,
    };

    try {
      final response = await repository.createRequest(json.encode(rawData));
      switch (response['statusCode']) {
        case 201:
          await syncData(refresh: true);
          Get.offNamed(Routes.OPERATOR_REQUEST);
          customSuccessAlertDialog(response['message']);
          break;
        default:
          successSnackbar(response['message']);
      }
    } catch (e) {
      LoggerHelper.logError(e.toString());
    } finally {
      noteC.dispose();
      isLoading.value = false;
    }
  }

  void approveRequest() async {
    processRequest(action: StringValue.REQ_APPROVE);
  }

  void rejectRequest() async {
    processRequest(action: StringValue.REQ_REJECT);
  }

  Future<void> processRequest({
    required String action,
    String? backRoute,
  }) async {
    isLoading.value = true;

    String? note;
    final noteC = TextEditingController();
    await customTextInputDialog(
      controller: noteC,
      title: 'Respon Admin',
      inputType: TextInputType.text,
      maxLines: 2,
    );

    note = noteC.text.isNotEmpty? noteC.text: null;
    noteC.clear();

    final rawData = {'action': action, 'note': note};

    try {
      if (selectedRequest.value == null)
        return customAlertDialog('Tidak ada permintaan yang dipilih');
      final response = await repository.processRequest(
        selectedRequest.value!.id,
        json.encode(rawData),
      );
      switch (response['statusCode']) {
        case 200:
          await syncData(refresh: true);
          selectedRequest.value = getRequest(selectedRequest.value!.id);
          selectedRequest.refresh();
          requests.refresh();
          if (backRoute != null) Get.toNamed(backRoute);
          customSuccessAlertDialog(response['message']);
          break;
        default:
          
          customAlertDialog(response['message']);
      }
    } catch (e) {
      LoggerHelper.logError(e.toString());
    } finally {
      noteC.dispose();
      isLoading.value = false;
    }
  }

  void deleteConfirmation() async {
    customDeleteAlertDialog('Yakin menghapus permintaan ini?', () {
      Get.back();
      deleteRequest();
    });
  }

  Future<void> deleteRequest() async {
    try {
      final response = await repository.deleteRequest(
        selectedRequest.value!.id,
      );
      switch (response['statusCode']) {
        case 200:
          await syncData(refresh: true);
          Get.offNamed(Routes.REQUEST);
          customSuccessAlertDialog(response['message']);
          break;
        default:
          customAlertDialog(response['message']);
      }
    } catch (e) {
      LoggerHelper.logError(e.toString());
    }
  }

  Request? getRequest(String requestId) {
    return requests.firstWhereOrNull((e) => e.id == requestId);
  }

  int get pendingRequestCount {
    return requests.where((e) => e.status == StringValue.STATUS_PENDING).length;
  }

  List<Request> get pendingRequests {
    return requests
        .where((e) => e.status == StringValue.STATUS_PENDING)
        .toList();
  }

  List<Request> get notPendingRequests {
    return requests
        .where((e) => e.status != StringValue.STATUS_PENDING)
        .toList();
  }
}
