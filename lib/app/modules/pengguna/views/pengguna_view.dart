import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:project428app/app/constants.dart';
import 'package:project428app/app/modules/pengguna/views/dialog_filter.dart';
import 'package:project428app/app/modules/pengguna/views/pengguna_item.dart';
import 'package:project428app/app/widgets/admin/admin_appbar.dart';
import 'package:project428app/app/widgets/admin/admin_drawer.dart';

import '../controllers/pengguna_controller.dart';

class PenggunaView extends GetView<PenggunaController> {
  const PenggunaView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AdminAppBar(context, "Pengguna"),
      drawer: AdminDrawer(context, kAdminMenuPengguna),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: TextField(
              controller: controller.searchc,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: "Cari Pengguna",
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => controller.searchUsers(),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Pengguna: ${controller.users.length}"),
                Text(
                  "Aktif: ${controller.users.where((user) => user['isActive']).length}",
                ),
                Text(
                  "Nonaktif: ${controller.users.where((user) => user['isActive'] == false).length}",
                ),
                GestureDetector(
                  onTap: () {
                    controller.getUsers();
                  },
                  child: Text('Refresh'),
                ),
              ],
            ),
          ),
          Obx(
            () =>
                controller.isFilterOn.value
                    ? Column(
                      children: [
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text("Filter: "),
                                  Badge(
                                    label: Text("Tampilkan Semua"),
                                    padding: EdgeInsets.symmetric(
                                      vertical: 2,
                                      horizontal: 5,
                                    ),
                                    backgroundColor: Colors.blue[400],
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  controller.resetFilter();
                                },
                                child: Row(
                                  children: [
                                    Text("Hapus"),
                                    Icon(Icons.clear_rounded, size: 18),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                    : SizedBox(),
          ),
          SizedBox(height: 10),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () => controller.getUsers(),
              child: Obx(
                () => ListView(
                  children: List.generate(
                    controller.searchedUser.length,
                    (index) => PenggunaItem(
                      controller.searchedUser[index]['userId'],
                      controller.searchedUser[index]['name'],
                      controller.searchedUser[index]['role'],
                      controller.searchedUser[index]['isActive'],
                      controller.searchedUser[index]['imgUrl'],
                      index,
                      controller.searchedUser[index]['createdAt'],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Stack(
            children: [
              FloatingActionButton(
                heroTag: "filter_pengguna",
                tooltip: "Filter Pengguna",
                onPressed: () async {
                  await UserFilterDialog();
                },
                child: const Icon(Icons.filter_list),
              ),
              Obx(
                () =>
                    controller.isFilterOn.value
                        ? Positioned(
                          top: 0.0,
                          right: 0.0,
                          child: Badge(label: Text('')),
                        )
                        : SizedBox(),
              ),
            ],
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            heroTag: "tambah_pengguna",
            tooltip: "Tambah Pengguna",
            onPressed: () {
              Get.toNamed("/tambah-pengguna");
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
