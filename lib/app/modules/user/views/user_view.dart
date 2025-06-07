import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project428app/app/core/constants/constants.dart';
import 'package:project428app/app/modules/user/views/dialog_filter.dart';
import 'package:project428app/app/modules/user/views/user_item.dart';
import 'package:project428app/app/shared/widgets/admin/admin_appbar.dart';
import 'package:project428app/app/shared/widgets/admin/admin_drawer.dart';
import '../../../style.dart';
import '../controllers/user_controller.dart';

class UserView extends GetView<UserController> {
  const UserView({super.key});
  @override
  Widget build(BuildContext context) {
    controller.UserS.getUsers();
    return Scaffold(
      appBar: AdminAppBar(context, "Pengguna", null),
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
                onChanged: (value) {
                  if (value.isEmpty) {
                    controller.filter.value.setKeyword(null);
                  } else {
                    controller.filter.value.setKeyword(value);
                  }
                  controller.filter.refresh();
                },
              ),
            ),
          ),
          SizedBox(height: 10),

          // users qty indicator
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Obx(
              () => Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: EdgeInsets.all(0),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Pengguna: ${controller.UserS.users.length}"),
                      Text(
                        "Aktif: ${controller.UserS.users.where((user) => user.isActive).length}",
                      ),
                      Text(
                        "Nonaktif: ${controller.UserS.users.where((user) => user.isActive == false).length}",
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // filter indicator
          Obx(
            () =>
                controller.filter.value.isFilterActive()
                    ? Column(
                      children: [
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text("Filter: "),
                                  controller.filter.value.showActive &&
                                          !controller.filter.value.showDeactive
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
                                  !controller.filter.value.showActive &&
                                          controller.filter.value.showDeactive
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
                                  controller.filter.value.showAdmin
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
                                  controller.filter.value.showFranchisee
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
                                  controller.filter.value.showSpvarea
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
                                  controller.filter.value.showOperator
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
                                  controller.filter.value.resetFilters();
                                  controller.filter.refresh();
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
              onRefresh: () => controller.UserS.getUsers(),
              child: Obx(
                () => ListView(
                  children: List.generate(
                    controller.filter.value
                        .getFilteredUsers(controller.UserS.users)
                        .length,
                    (index) => UserItem(
                      controller.filter.value.getFilteredUsers(
                        controller.UserS.users,
                      )[index],
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
                controller.filter.value.isFilterActive()
                    ? Positioned(
                      right: 0,
                      top: 0,
                      child: Badge(
                        label: Text(
                          controller.filter.value
                              .getFilteredUsers(controller.UserS.users)
                              .length
                              .toString(),
                        ),
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
              Get.toNamed("/user-add");
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
