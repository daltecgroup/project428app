import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project428app/app/modules/user/controllers/user_controller.dart';
import '../../../widgets/text_header.dart';

Future<dynamic> UserFilterDialog() {
  UserController c = Get.find<UserController>();
  return Get.defaultDialog(
    title: "Filter Pengguna",
    titleStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
    radius: 10,
    content: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Obx(
        () => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextTitle(text: "Urutan"),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Radio(
                        value: true,
                        groupValue: c.filter.value.newestFirst,
                        onChanged: (value) {
                          c.filter.value.setNewestFirst(value!);
                          c.filter.refresh();
                        },
                      ),
                      TextTitle(text: "Baru - Lama"),
                    ],
                  ),
                  SizedBox(width: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Radio(
                        value: false,
                        groupValue: c.filter.value.newestFirst,
                        onChanged: (value) {
                          c.filter.value.setNewestFirst(value!);
                          c.filter.refresh();
                        },
                      ),
                      TextTitle(text: "Lama - Baru"),
                    ],
                  ),
                ],
              ),
              TextTitle(text: "Status"),
              Row(
                children: [
                  Checkbox(
                    value: c.filter.value.showActive,
                    onChanged: (value) {
                      c.filter.value.setShowActive(value!);
                      c.filter.refresh();
                    },
                  ),
                  Text("Aktif"),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    value: c.filter.value.showDeactive,
                    onChanged: (value) {
                       c.filter.value.setShowDeactive(value!);
                      c.filter.refresh();
                    },
                  ),
                  Text("Nonaktif"),
                ],
              ),
              TextTitle(text: "Peran"),
              Row(
                children: [
                  Checkbox(
                    value: c.filter.value.showAdmin,
                    onChanged: (value) {
                      c.filter.value.setShowAdmin(value!);
                      c.filter.refresh();
                    },
                  ),
                  Text("Admin"),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    value: c.filter.value.showFranchisee,
                    onChanged: (value) {
                      c.filter.value.setShowFranchisee(value!);
                      c.filter.refresh();
                    },
                  ),
                  Text("Franchisee"),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    value: c.filter.value.showSpvarea,
                    onChanged: (value) {
                      c.filter.value.setShowSpvarea(value!);
                      c.filter.refresh();
                    },
                  ),
                  Text("SPV Area"),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    value: c.filter.value.showOperator,
                    onChanged: (value) {
                      c.filter.value.setShowOperator(value!);
                      c.filter.refresh();
                    },
                  ),
                  Text("Operator"),
                ],
              ),
              GestureDetector(
                onTap: () {
                  c.filter.value.resetFilters();
                  c.filter.refresh();
                },
                child: Text('Reset'),
              ),
            ],
          ),
        ),
      ),
    ),
    cancel: TextButton(
      onPressed: () {
        Get.back();
      },
      child: Text("Tutup"),
    ),
  );
}
