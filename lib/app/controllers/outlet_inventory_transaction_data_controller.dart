import 'dart:convert';

import 'package:abg_pos_app/app/controllers/outlet_inventory_data_controller.dart';
import 'package:abg_pos_app/app/data/models/OutletInventoryTransaction.dart';
import 'package:abg_pos_app/app/shared/custom_alert.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../data/repositories/outlet_inventory_transaction_repository.dart';
import '../utils/constants/app_constants.dart';
import '../utils/helpers/file_helper.dart';
import '../utils/helpers/get_storage_helper.dart';
import '../utils/helpers/logger_helper.dart';

class OutletInventoryTransactionDataController extends GetxController {
  OutletInventoryTransactionDataController({required this.repository});
  final OutletInventoryTransactionRepository repository;

  RxList<OutletinventoryTransaction> oits = <OutletinventoryTransaction>[].obs;

  RxBool isLoading = false.obs;
  RxInt startingDay = 7.obs;
  final Rx<DateTime?> latestSync = (null as DateTime?).obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    await syncData(
      refresh: true,
      transactionType: AppConstants.TRXTYPE_ADJUSTMENT,
    );
    setLatestSync();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> createOutletInventoryTransaction(dynamic data) async {
    await repository.createOutletInventoryTransaction(data);
  }

  Future<void> createMultipleOutletInventoryTransaction(dynamic data) async {
    final result = await repository.createMultipleOutletInventoryTransaction(
      data,
    );

    if (result['statusCode'] == 201) {
      Get.back();
      final outletInventoryData =
          Get.isRegistered<OutletInventoryDataController>()
          ? Get.find<OutletInventoryDataController>()
          : null;
      if (outletInventoryData != null) {
        await outletInventoryData.syncData(refresh: true);
      }
      customAlertDialog(result['message']);
    } else {
      customAlertDialog(result['message']);
    }
  }

  Future<void> syncData({bool? refresh, String? transactionType}) async {
    isLoading.value = true;
    try {
      final file = await getLocalFile(
        AppConstants.FILENAME_OUTLET_INVENTORY_TRANSACTION_DATA,
      );
      if (await file.exists() && (refresh == null || refresh == false)) {
        LoggerHelper.logInfo(
          'Set initial outlet inventory transaction from local data',
        );
        final List<OutletinventoryTransaction> oitList =
            (json.decode(await file.readAsString()) as List<dynamic>)
                .map(
                  (json) => OutletinventoryTransaction.fromJson(
                    json as Map<String, dynamic>,
                  ),
                )
                .toList();
        oitList.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        oits.assignAll(oitList);
      } else {
        if (await file.exists() && refresh != null && refresh == true)
          await file.delete();
        final currentOutlet = box.getValue(AppConstants.KEY_CURRENT_OUTLET);
        final currentRole = box.getValue(AppConstants.KEY_CURRENT_ROLE);
        String outletQuery = '';
        if (currentRole != null && currentRole == AppConstants.ROLE_OPERATOR) {
          if (currentOutlet != null) {
            outletQuery = '?outletId=$currentOutlet';
          }
        }

        String transactionTypeQuery = '';

        if (transactionType != null) {
          transactionTypeQuery = '&transactionType=$transactionType';
        }

        String query =
            '$outletQuery${outletQuery.isEmpty ? '?' : '&'}dateFrom=${DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(Duration(days: startingDay.value)))}$transactionTypeQuery';
        LoggerHelper.logInfo(
          'Set initial outlet inventory transactions from server',
        );

        final List<OutletinventoryTransaction> fetchedOit = await repository
            .getOutletInventoryTransactions(query: query);
        if (fetchedOit.isNotEmpty) {
          oits.assignAll(fetchedOit);
        } else {
          oits.clear();
        }

        await file.writeAsString(
          oits.map((sale) => json.encode(sale.toJson())).toList().toString(),
        );
        await box.setValue(
          AppConstants.KEY_SALE_LATEST,
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

  void setLatestSync() {
    latestSync.value = latestSyncTime;
    latestSync.refresh();
  }

  DateTime? get latestSyncTime {
    DateTime? time = null as DateTime?;
    if (!box.isNull(AppConstants.KEY_OIT_LATEST)) {
      time = DateTime.fromMillisecondsSinceEpoch(
        box.getValue(AppConstants.KEY_OIT_LATEST),
      );
    }
    return time;
  }

  Map<String, List<OutletinventoryTransaction>> get groupedOit {
    // create a map of order, key is created at in dd mm yyyy local format
    final Map<String, List<OutletinventoryTransaction>> grouped = {};
    for (var oit in oits) {
      final key =
          '${oit.createdAt.year}-${oit.createdAt.month.toString().padLeft(2, '0')}-${oit.createdAt.day.toString().padLeft(2, '0')}';
      if (!grouped.containsKey(key)) {
        grouped[key] = [];
      }
      grouped[key]!.add(oit);
    }
    // sort the map by key in descending order
    final sortedKeys = grouped.keys.toList()
      ..sort((a, b) => DateTime.parse(b).compareTo(DateTime.parse(a)));
    // create a new map with sorted keys
    final sortedGrouped = <String, List<OutletinventoryTransaction>>{};
    for (var key in sortedKeys) {
      sortedGrouped[key] = grouped[key]!;
    }
    return sortedGrouped;
  }
}
