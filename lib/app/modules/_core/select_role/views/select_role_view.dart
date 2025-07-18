import 'package:abg_pos_app/app/routes/app_pages.dart';
import 'package:abg_pos_app/app/shared/custom_circle_avatar_image.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../controllers/select_role_controller.dart';
import '../../../../modules/_core/select_role/widgets/select_role_button.dart';
import '../../../../shared/app_logo_title.dart';
import '../../../../shared/custom_card.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/theme/app_colors.dart';
import '../../../../utils/theme/custom_text.dart';

class SelectRoleView extends GetView<SelectRoleController> {
  const SelectRoleView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryYellow,
      body: Stack(
        children: [
          AppLogoTitle(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.DEFAULT_PADDING,
                ),
                child: Hero(
                  tag: AppConstants.HERO_AUTH_CARD,
                  child: CustomCard(
                    content: SingleChildScrollView(
                      child: Obx(
                        () => Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            if (controller.currentUser != null)
                              Material(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                elevation: 1,
                                child: ListTile(
                                  selected: true,
                                  selectedTileColor: Colors.grey[50],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  leading: CustomCircleAvatarImage(),
                                  title: Text(
                                    controller.currentUser!.name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  subtitle: Text(
                                    'ID ${controller.currentUser!.userId}',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                              ),
                            if (controller.currentUser != null)
                              SizedBox(
                                height: AppConstants.DEFAULT_VERTICAL_MARGIN,
                              ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                customInputTitleText(text: 'Masuk sebagai'),
                              ],
                            ),
                            SizedBox(
                              height: AppConstants.DEFAULT_VERTICAL_MARGIN,
                            ),
                            controller.roles.contains(AppConstants.ROLE_ADMIN)
                                ? SelectRoleButton(
                                    title: 'Admin',
                                    color: Colors.blueAccent,
                                    onPressed: () {
                                      Get.toNamed(Routes.ADMIN_DASHBOARD);
                                      controller.box.setValue(
                                        AppConstants.KEY_CURRENT_ROLE,
                                        AppConstants.ROLE_ADMIN,
                                      );
                                      controller.setting.currentRole.value =
                                          AppConstants.ROLE_ADMIN;
                                    },
                                  )
                                : SizedBox(),
                            controller.roles.contains(
                                  AppConstants.ROLE_FRANCHISEE,
                                )
                                ? SelectRoleButton(
                                    title: 'Franchisee',
                                    color: Colors.amber[800]!,
                                    onPressed: () {
                                      Get.toNamed(Routes.FRANCHISEE_DASHBOARD);
                                      controller.box.setValue(
                                        AppConstants.KEY_CURRENT_ROLE,
                                        AppConstants.ROLE_FRANCHISEE,
                                      );
                                      controller.setting.currentRole.value =
                                          AppConstants.ROLE_FRANCHISEE;
                                    },
                                  )
                                : SizedBox(),
                            controller.roles.contains(AppConstants.ROLE_SPVAREA)
                                ? SelectRoleButton(
                                    title: 'SPV Area',
                                    color: Colors.green,
                                    onPressed: () {
                                      Get.toNamed(Routes.SPVAREA_DASHBOARD);
                                      controller.box.setValue(
                                        AppConstants.KEY_CURRENT_ROLE,
                                        AppConstants.ROLE_SPVAREA,
                                      );
                                      controller.setting.currentRole.value =
                                          AppConstants.ROLE_SPVAREA;
                                    },
                                  )
                                : SizedBox(),
                            controller.roles.contains(
                                  AppConstants.ROLE_OPERATOR,
                                )
                                ? SelectRoleButton(
                                    title: 'Operator',
                                    color: Colors.redAccent,
                                    onPressed: () {
                                      controller.loginAsOperator();
                                    },
                                  )
                                : SizedBox(),
                            TextButton(
                              onPressed: () {
                                controller.logout();
                              },
                              child: Text("Logout"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: AppConstants.DEFAULT_VERTICAL_MARGIN,
            child: Container(
              alignment: Alignment.center,
              width: Get.width,
              child: Text(AppConstants.APP_VERSION),
            ),
          ),
        ],
      ),
    );
  }
}
