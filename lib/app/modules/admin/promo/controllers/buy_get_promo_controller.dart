import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../controllers/promo_setting_data_controller.dart';
import '../../../../data/models/PromoSetting.dart';
import '../../../../shared/custom_alert.dart';
import '../../../../utils/constants/app_constants.dart';

class BuyGetPromoController extends GetxController {
  BuyGetPromoController({required this.data});
  final PromoSettingDataController data;
  final TextEditingController inputC = TextEditingController();

  @override
  void onClose() {
    inputC.dispose();
    super.onClose();
  }

  Future<void> refreshData() async {
    await data.syncData(refresh: true);
  }

  PromoSetting? get currentPromoSetting =>
      data.getPromoSetting(AppConstants.PROMO_SETTING_BUY_GET);

  Future<void> setMinimumItem() async {
    await _updatePromoField(
      key: 'nominal',
      initialValue: currentPromoSetting!.nominal.round().toString(),
      numericOnly: true,
    );
  }

  Future<void> setBonusItemMaxPrice() async {
    await _updatePromoField(
      key: 'bonusMaxPrice',
      initialValue: currentPromoSetting!.bonusMaxPrice.round().toString(),
      numericOnly: true,
    );
  }

  Future<void> setPromoTitle() async {
    await _updatePromoField(
      key: 'title',
      initialValue: currentPromoSetting!.title,
      title: 'Input Judul',
    );
  }

  Future<void> setPromoDescription() async {
    await _updatePromoField(
      key: 'description',
      initialValue: currentPromoSetting!.description ?? '',
      title: 'Input Deskripsi',
      maxLines: 3,
    );
  }

  Future<void> _updatePromoField({
    required String key,
    required String initialValue,
    String? title,
    int maxLines = 1,
    bool numericOnly = false,
  }) async {
    inputC.text = initialValue;
    final value = await customTextInputDialog(
      title: title,
      controller: inputC,
      disableText: true,
      maxLines: maxLines,
    );
    inputC.clear();

    if (value == null) return;
    if (numericOnly && !GetUtils.isNumericOnly(value)) return;

    final parsed = numericOnly ? num.parse(value) : value;
    await data.updatePromoSetting(
      id: currentPromoSetting!.id,
      data: json.encode({key: parsed}),
    );
  }
}
