import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../controllers/ingredient_data_controller.dart';
import '../../../../controllers/outlet_data_controller.dart';
import '../../../../controllers/outlet_inventory_transaction_data_controller.dart';
import '../../../../controllers/outlet_inventory_data_controller.dart';
import '../../../../shared/custom_alert.dart';
import '../../../../shared/custom_input_with_error.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/constants/string_value.dart';
import '../../../../utils/helpers/get_storage_helper.dart';
import '../../../../utils/theme/text_style.dart';

class AdjustmentItem {
  final String ingredientId;
  double? adjQty;
  String? notes;

  AdjustmentItem({required this.ingredientId, this.adjQty});

  void setAdjQty(double? qty) => adjQty = qty;
  void setNotes(String? text) => notes = text;
  void clearNotes() => notes = null;
}

class AdjustmentSelectorData {
  double? adjQty;
  String? notes;

  AdjustmentSelectorData({this.adjQty, this.notes});

  void setAdjQty(double? qty) => adjQty = qty;
  void setNotes(String? text) => notes = text;
}

class OutletInventoryAdjustmentController extends GetxController {
  OutletInventoryAdjustmentController({
    required this.outletData,
    required this.ingredientData,
    required this.transactionData,
    required this.data,
  });
  final OutletDataController outletData;
  final IngredientDataController ingredientData;
  final OutletInventoryTransactionDataController transactionData;
  final OutletInventoryDataController data;
  final backRoute = Get.previousRoute;

  RxList<AdjustmentItem> adjustments = <AdjustmentItem>[].obs;
  TextEditingController qtyC = TextEditingController();
  TextEditingController notesC = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  double? getAdjQty(String id) =>
      adjustments.firstWhereOrNull((e) => e.ingredientId == id)?.adjQty;

  String? getNotes(String id) =>
      adjustments.firstWhereOrNull((e) => e.ingredientId == id)?.notes;

  void clearNotes(String id) {
    adjustments.firstWhereOrNull((e) => e.ingredientId == id)?.clearNotes();
    adjustments.refresh();
  }

  Future<void> addAdjustmentQty(String id) async {
    final qty = await qtySelector();

    if (qty == null) return;
    if (getAdjQty(id) == null) {
      adjustments.add(AdjustmentItem(ingredientId: id, adjQty: qty));
    } else {
      adjustments.firstWhere((e) => e.ingredientId == id).setAdjQty(qty);
    }
    adjustments.refresh();
  }

  Future<double?> qtySelector({double? currentQty, String? notes}) {
    return Get.defaultDialog(
      title: 'Jumlah terkini (gram)',
      titleStyle: AppTextStyle.dialogTitle,
      radius: AppConstants.DEFAULT_BORDER_RADIUS,
      contentPadding: EdgeInsets.all(AppConstants.DEFAULT_PADDING),
      barrierDismissible: false,
      content: Column(
        children: [
          CustomInputWithError(
            controller: qtyC,
            inputType: TextInputType.number,
            autoFocus: true,
            onSubmitted: (value) {
              submitQtyData(currentQty: currentQty);
            },
          ),
        ],
      ),
      cancel: TextButton(
        onPressed: () {
          Get.back(result: currentQty);
          qtyC.clear();
        },
        child: Text(StringValue.CANCEL),
      ),
      confirm: TextButton(
        onPressed: () {
          submitQtyData(currentQty: currentQty);
        },
        child: Text(StringValue.SAVE),
      ),
    );
  }

  void submitQtyData({double? currentQty, String? notes}) {
    if (qtyC.text.isNotEmpty && qtyC.text != '' && GetUtils.isNum(qtyC.text)) {
      Get.back(result: double.parse(qtyC.text));
      qtyC.clear();
    } else {
      Get.back(result: currentQty);
      qtyC.clear();
    }
  }

  Future<String?> noteSelector({String? notes}) {
    if (notes != null) notesC.text = notes;
    return Get.defaultDialog(
      title: 'Input Catatan',
      titleStyle: AppTextStyle.dialogTitle,
      radius: AppConstants.DEFAULT_BORDER_RADIUS,
      contentPadding: EdgeInsets.all(AppConstants.DEFAULT_PADDING),
      barrierDismissible: false,
      content: Column(
        children: [
          CustomInputWithError(
            controller: notesC,
            inputType: TextInputType.text,
            autoFocus: true,
            maxLines: 2,
            onSubmitted: (value) {
              Get.back(result: notesC.text);
              notesC.clear();
            },
          ),
        ],
      ),
      cancel: TextButton(
        onPressed: () {
          Get.back(result: notes);
          notesC.clear();
        },
        child: Text(StringValue.CANCEL),
      ),
      confirm: TextButton(
        onPressed: () {
          Get.back(result: notesC.text);
          notesC.clear();
        },
        child: Text(StringValue.SAVE),
      ),
    );
  }

  Future<void> addAdjustmentNotes(String id, {String? currentNotes}) async {
    final notes = await noteSelector(notes: currentNotes);
    if (notes == null || notes == '') {
      adjustments.firstWhere((e) => e.ingredientId == id).setNotes(null);
      adjustments.refresh();
      return;
    }
    adjustments.firstWhere((e) => e.ingredientId == id).setNotes(notes);
    adjustments.refresh();
  }

  void submitAdjustment() {
    if (adjustments.isEmpty) {
      customAlertDialog('Anda tidak membuat perubahan pada stok');
    } else {
      customConfirmationDialog(
        'Apakah yakin jumlah penyesuaian sudah benar?',
        () {
          _adjustmentSubmission();
        },
      );
    }
  }

  Future<void> _adjustmentSubmission() async {
    final adjustmentList = [];
    for (var adjustment in adjustments) {
      var adjustmentMap = {};
      final ingredientId = data.selectedOutletInventory.value!.ingredients
          .firstWhere((e) => e.ingredientId == adjustment.ingredientId)
          .ingredientId;
      final currentQty = data.selectedOutletInventory.value!.ingredients
          .firstWhere((e) => e.ingredientId == adjustment.ingredientId)
          .currentQty;
      final newQty = adjustment.adjQty!;

      adjustmentMap['ingredientId'] = adjustment.ingredientId;
      adjustmentMap['outletId'] = box.getValue(AppConstants.KEY_CURRENT_OUTLET);
      adjustmentMap['sourceType'] = AppConstants.TRXSRC_STOCK;
      adjustmentMap['ref'] = ingredientId;
      adjustmentMap['transactionType'] = AppConstants.TRXTYPE_ADJUSTMENT;
      adjustmentMap['notes'] = adjustment.notes ?? '';
      adjustmentMap['qty'] = newQty - currentQty;
      if (adjustmentMap['qty'] != 0) adjustmentList.add(adjustmentMap);
    }

    if (adjustmentList.isNotEmpty) {
      Get.back();
      await transactionData.createMultipleOutletInventoryTransaction(
        json.encode(adjustmentList),
      );
    } else {
      Get.back();
      Get.back();
      customAlertDialog('Anda tidak membuat perubahan pada stok');
    }
  }
}
