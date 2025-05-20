import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project428app/app/constants.dart';
import 'package:project428app/app/modules/pengguna/views/dialog_filter.dart';
import 'package:project428app/app/modules/pengguna/views/pengguna_item.dart';
import 'package:project428app/app/widgets/admin/admin_appbar.dart';
import 'package:project428app/app/widgets/admin/admin_drawer.dart';
import '../../../style.dart';
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
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Material(
              elevation: 1,
              borderRadius: BorderRadius.circular(8),
              child: TextField(
                controller: controller.searchc,
                decoration: MyTextFieldInputDecoration(
                  'Cari Pengguna',
                  Icon(Icons.search),
                ),
                onChanged: (value) => controller.searchUsers(),
              ),
            ),
          ),
          SizedBox(height: 10),

          // users qty indicator
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Obx(
              () => Row(
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
          ),

          // filter indicator
          Obx(
            () =>
                (controller.isFilterOn.value &&
                            !(!controller.showAdmin.value &&
                                !controller.showFranchisee.value &&
                                !controller.showSpvAre.value &&
                                !controller.showOperator.value)) ||
                        (controller.showActive.value &&
                            !controller.showInnactive.value) ||
                        (!controller.showActive.value &&
                            controller.showInnactive.value)
                    ? Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          child: Divider(height: 0.1, color: Colors.black26),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text("Filter: "),
                                  controller.showActive.value &&
                                          !controller.showInnactive.value
                                      ? Padding(
                                        padding: const EdgeInsets.only(
                                          right: 3,
                                        ),
                                        child: Badge(
                                          label: Text("Aktif"),
                                          padding: EdgeInsets.symmetric(
                                            vertical: 2,
                                            horizontal: 5,
                                          ),
                                          backgroundColor: Colors.blue[600],
                                        ),
                                      )
                                      : SizedBox(),
                                  controller.showInnactive.value &&
                                          !controller.showActive.value
                                      ? Padding(
                                        padding: const EdgeInsets.only(
                                          right: 3,
                                        ),
                                        child: Badge(
                                          label: Text("Nonaktif"),
                                          padding: EdgeInsets.symmetric(
                                            vertical: 2,
                                            horizontal: 5,
                                          ),
                                          backgroundColor: Colors.blue[600],
                                        ),
                                      )
                                      : SizedBox(),
                                  controller.showAdmin.value
                                      ? Padding(
                                        padding: const EdgeInsets.only(
                                          right: 3,
                                        ),
                                        child: Badge(
                                          label: Text("Admin"),
                                          padding: EdgeInsets.symmetric(
                                            vertical: 2,
                                            horizontal: 5,
                                          ),
                                          backgroundColor: Colors.blue[400],
                                        ),
                                      )
                                      : SizedBox(),
                                  controller.showFranchisee.value
                                      ? Padding(
                                        padding: const EdgeInsets.only(
                                          right: 3,
                                        ),
                                        child: Badge(
                                          label: Text("Franchisee"),
                                          padding: EdgeInsets.symmetric(
                                            vertical: 2,
                                            horizontal: 5,
                                          ),
                                          backgroundColor: Colors.blue[400],
                                        ),
                                      )
                                      : SizedBox(),
                                  controller.showSpvAre.value
                                      ? Padding(
                                        padding: const EdgeInsets.only(
                                          right: 3,
                                        ),
                                        child: Badge(
                                          label: Text("SPV Area"),
                                          padding: EdgeInsets.symmetric(
                                            vertical: 2,
                                            horizontal: 5,
                                          ),
                                          backgroundColor: Colors.blue[400],
                                        ),
                                      )
                                      : SizedBox(),
                                  controller.showOperator.value
                                      ? Badge(
                                        label: Text("Operator"),
                                        padding: EdgeInsets.symmetric(
                                          vertical: 2,
                                          horizontal: 5,
                                        ),
                                        backgroundColor: Colors.blue[400],
                                      )
                                      : SizedBox(),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  controller.resetFilter();
                                },
                                child: Row(
                                  children: [
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

          // user list
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
          Obx(
            () => Stack(
              children: [
                FloatingActionButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  heroTag: "filter_pengguna",
                  tooltip: "Filter Pengguna",
                  onPressed: () async {
                    await UserFilterDialog();
                  },
                  child: const Icon(Icons.filter_list),
                ),
                (controller.isFilterOn.value &&
                            !(!controller.showAdmin.value &&
                                !controller.showFranchisee.value &&
                                !controller.showSpvAre.value &&
                                !controller.showOperator.value)) ||
                        (controller.showActive.value &&
                            !controller.showInnactive.value) ||
                        (!controller.showActive.value &&
                            controller.showInnactive.value)
                    ? Positioned(
                      right: 0,
                      top: 0,
                      child: Badge(
                        label: Text(controller.searchedUser.length.toString()),
                      ),
                    )
                    : SizedBox(),
              ],
            ),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
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
