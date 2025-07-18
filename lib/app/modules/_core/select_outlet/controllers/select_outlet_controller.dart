import 'package:abg_pos_app/app/controllers/outlet_data_controller.dart';
import 'package:abg_pos_app/app/data/models/Outlet.dart';
import 'package:abg_pos_app/app/utils/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/helpers/get_storage_helper.dart';

class SelectOutletController extends GetxController {
  SelectOutletController({required this.data, required this.auth});
  OutletDataController data;
  AuthService auth;

  late BoxHelper box;
  final String backRoute = Get.previousRoute;

  RxString groupedBy = 'village'.obs;
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
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    searchC.dispose();
    super.onClose();
  }

  Future<void> refreshData() async {
    await data.syncData(refresh: true);
    groupedBy.value = 'village';
  }

  List<Outlet> filteredOutlets({bool? status, String? keyword}) {
    List<Outlet> list = data.outlets;

    list = data
        .getOutletByOperatorId(auth.currentUserFromStorage!.id)
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
    final outlets = filteredOutlets(status: true, keyword: keyword);
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
}
