import 'package:abg_pos_app/app/shared/buttons/floating_add_button.dart';
import 'package:abg_pos_app/app/shared/custom_card.dart';
import 'package:abg_pos_app/app/shared/custom_nav_item.dart';
import 'package:abg_pos_app/app/utils/constants/padding_constants.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../routes/app_pages.dart';
import '../../../../shared/custom_appbar.dart';
import '../../../../shared/custom_drawer.dart';
import '../../../../shared/status_sign.dart';
import '../../../../shared/user_roles.dart';
import '../../../../shared/vertical_sized_box.dart';
import '../../../../utils/constants/string_value.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../shared/custom_input_with_error.dart';
import '../widgets/filter_badge_row.dart';
import '../widgets/user_filter_dialog.dart';
import '../controllers/user_list_controller.dart';

class UserListView extends GetView<UserListController> {
  const UserListView({super.key});
  @override
  Widget build(BuildContext context) {
    final svg = Svg(AppConstants.PROFILE_PLACEHOLDER);
    return Scaffold(
      appBar: customAppBar(StringValue.USER),
      drawer: customDrawer(),
      body: Column(
        children: [
          Padding(
            padding: horizontalPadding,
            child: CustomInputWithError(
              controller: controller.searchC,
              hint: StringValue.SEARCH_USER,
              prefixIcon: Icon(
                Icons.search,
                size: AppConstants.DEFAULT_ICON_SIZE,
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
          const VerticalSizedBox(),
          // users qty indicator
          Obx(() {
            final users = controller.userData.users;
            final total = users.length;
            final active = users.where((u) => u.isActive).length;
            final inactive = total - active;

            return _buildStatCard(total, active, inactive);
          }),
          // filter indicator
          Obx(
            () => FilterBadgeRow(
              filter: controller.filter.value,
              onClear: () {
                controller.filter.value.resetFilters();
                controller.filter.refresh();
              },
            ),
          ),

          VerticalSizedBox(),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async => await controller.userData.syncData(),
              child: Obx(() {
                final users = controller.filter.value.getFilteredUsers(
                  controller.userData.users,
                );
                return controller.userData.isLoading.value
                    ? Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        padding: horizontalPadding,
                        itemCount: users.length,
                        itemBuilder: (_, index) {
                          final user = users[index];
                          return CustomNavItem(
                            image: svg,
                            isProfileImage: true,
                            title: user.name,
                            subTitleWidget: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: UserRoles(
                                role: user.roles,
                                status: user.isActive,
                                alignment: MainAxisAlignment.start,
                              ),
                            ),
                            trailing: StatusSign(
                              status: user.isActive,
                              size: AppConstants.DEFAULT_FONT_SIZE.toInt() - 2,
                            ),
                            onTap: () {
                              controller.userData.selectedUser.value = user;
                              Get.toNamed(Routes.USER_DETAIL);
                            },
                          );
                        },
                      );
              }),
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
                  tooltip: StringValue.USER_FILTER,
                  heroTag: 'user_filter',
                  onPressed: () async {
                    await userFilterDialog();
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
                                .getFilteredUsers(controller.userData.users)
                                .length
                                .toString(),
                          ),
                        ),
                      )
                    : SizedBox(),
              ],
            ),
          ),
          const VerticalSizedBox(),
          FloatingAddButton(
            route: Routes.ADD_USER,
            tooltip: StringValue.ADD_USER,
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(int total, int active, int inactive) {
    return Padding(
      padding: horizontalPadding,
      child: CustomCard(
        padding: 10,
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("${StringValue.USER}: $total"),
            Text("${StringValue.ACTIVE}: $active"),
            Text("${StringValue.INACTIVE}: $inactive"),
          ],
        ),
      ),
    );
  }
}
