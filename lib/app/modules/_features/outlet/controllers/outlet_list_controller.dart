import 'package:abg_pos_app/app/controllers/outlet_data_controller.dart';
import 'package:abg_pos_app/app/data/models/Outlet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/helpers/get_storage_helper.dart';

class OutletListController extends GetxController {
  OutletListController({required this.data});
  OutletDataController data;

  late BoxHelper box;
  final String backRoute = Get.previousRoute;

  RxString groupedBy = 'regency'.obs;
  late TextEditingController searchC;

  RxString keyword = ''.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    searchC = TextEditingController();
    box = BoxHelper();
    await refreshData();
  }

  @override
  void onClose() {
    searchC.dispose();
    super.onClose();
  }

  Future<void> refreshData() async {
    await data.syncData(refresh: true);
    groupedBy.value = 'regency';
  }

  List<Outlet> filteredOutlets({bool? status, String? keyword}) {
    List<Outlet> list = data.outlets;

    list = data.outlets
        .where(
          (e) =>
              (status != null ? e.isActive == status : true) &&
              (keyword != null
                  ? e.name.toLowerCase().contains(
                      keyword.toLowerCase().toString(),
                    )
                  : true),
        )
        .toList();

    return list;
  }

  Map<String, List<Outlet>> groupOutletByRegency(String keyword) {
    final outlets = filteredOutlets(keyword: keyword);
    final grouped = <String, List<Outlet>>{};

    for (var outlet in outlets) {
      final key = switch (groupedBy.value) {
        'province' => outlet.address.province,
        'district' => outlet.address.district,
        'village' => outlet.address.village,
        _ => outlet.address.regency,
      };

      grouped.putIfAbsent(key, () => []).add(outlet);
    }

    return grouped;
  }

  void changeGroupedBy() {
    if (groupedBy.value == 'village') {
      groupedBy.value = 'province';
      return;
    }
    if (groupedBy.value == 'province') {
      groupedBy.value = 'regency';
      return;
    }
    if (groupedBy.value == 'regency') {
      groupedBy.value = 'district';
      return;
    }
    if (groupedBy.value == 'district') {
      groupedBy.value = 'village';
      return;
    }
  }
}
