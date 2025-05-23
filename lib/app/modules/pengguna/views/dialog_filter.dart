import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project428app/app/modules/pengguna/controllers/pengguna_controller.dart';

import '../../../widgets/text_header.dart';

Future<dynamic> UserFilterDialog() {
  PenggunaController c = Get.find<PenggunaController>();
  return Get.defaultDialog(
    title: "Filter Pengguna",
    content: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextTitle(text: "Urutan"),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   children: [
            //     Row(
            //       mainAxisAlignment: MainAxisAlignment.start,
            //       children: [
            //         Radio(
            //           value: true,
            //           groupValue: c.isAsc.value,
            //           onChanged: (value) {
            //             c.isAsc.value = true;
            //             c.filterUsers();
            //           },
            //         ),
            //         TextTitle(text: "A-Z"),
            //       ],
            //     ),
            //     SizedBox(width: 20),
            //     Row(
            //       mainAxisAlignment: MainAxisAlignment.start,
            //       children: [
            //         Radio(
            //           value: false,
            //           groupValue: c.isAsc.value,
            //           onChanged: (value) {
            //             c.isAsc.value = false;
            //             c.filterUsers();
            //           },
            //         ),
            //         TextTitle(text: "Z-A"),
            //       ],
            //     ),
            //   ],
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Radio(
                      value: true,
                      groupValue: c.isNewestFirst.value,
                      onChanged: (value) {
                        c.isNewestFirst.value = true;
                        c.filterUsers();
                      },
                    ),
                    TextTitle(text: "Baru - Lama"),
                  ],
                ),
                SizedBox(width: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Radio(
                      value: false,
                      groupValue: c.isNewestFirst.value,
                      onChanged: (value) {
                        c.isNewestFirst.value = false;
                        c.filterUsers();
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
                  value: c.showActive.value,
                  onChanged: (value) {
                    c.showActive.toggle();
                    c.filterUsers();
                  },
                ),
                Text("Aktif"),
              ],
            ),
            Row(
              children: [
                Checkbox(
                  value: c.showInnactive.value,
                  onChanged: (value) {
                    c.showInnactive.toggle();
                    c.filterUsers();
                  },
                ),
                Text("Nonaktif"),
              ],
            ),
            TextTitle(text: "Peran"),
            Row(
              children: [
                Checkbox(
                  value: c.showAdmin.value,
                  onChanged: (value) {
                    c.showAdmin.toggle();
                    c.filterUsers();
                  },
                ),
                Text("Admin"),
              ],
            ),
            Row(
              children: [
                Checkbox(
                  value: c.showFranchisee.value,
                  onChanged: (value) {
                    c.showFranchisee.toggle();
                    c.filterUsers();
                  },
                ),
                Text("Franchisee"),
              ],
            ),
            Row(
              children: [
                Checkbox(
                  value: c.showSpvAre.value,
                  onChanged: (value) {
                    c.showSpvAre.toggle();
                    c.filterUsers();
                  },
                ),
                Text("SPV Area"),
              ],
            ),
            Row(
              children: [
                Checkbox(
                  value: c.showOperator.value,
                  onChanged: (value) {
                    c.showOperator.toggle();
                    c.filterUsers();
                  },
                ),
                Text("Operator"),
              ],
            ),
            GestureDetector(
              onTap: () {
                c.resetFilter();
              },
              child: Text('Reset'),
            ),
          ],
        ),
      ),
    ),
    // confirm: TextButton(
    //   onPressed: () {
    //     c.filterUsers();
    //     c.isFilterOn.value = true;
    //     Get.back();
    //   },
    //   child: Text("Terapkan"),
    // ),
    cancel: TextButton(
      onPressed: () {
        c.filterUsers();
        Get.back();
      },
      child: Text("Tutup"),
    ),
  );
}
