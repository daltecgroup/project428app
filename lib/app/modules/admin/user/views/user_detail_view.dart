import 'package:abg_pos_app/app/utils/constants/padding_constants.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../routes/app_pages.dart';
import '../../../../shared/user_roles.dart';
import '../../../../shared/status_sign.dart';
import '../../../../shared/custom_card.dart';
import '../../../../shared/vertical_sized_box.dart';
import '../../../../utils/theme/text_style.dart';
import '../../../../utils/theme/custom_text.dart';
import '../../../../utils/theme/button_style.dart';
import '../../../../shared/custom_appbar_lite.dart';
import '../../../../utils/helpers/time_helper.dart';
import '../../../../utils/constants/string_value.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../shared/pages/failed_page_placeholder.dart';
import '../widgets/user_image_panel.dart';
import '../controllers/user_detail_controller.dart';

class UserDetailView extends GetView<UserDetailController> {
  const UserDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarLite(
        context: context,
        title: StringValue.USER_DETAIL,
        backRoute: controller.backRoute,
        actions: [
          PopupMenuButton(
            color: Colors.white,
            icon: Icon(Icons.more_vert),
            itemBuilder: (context) => <PopupMenuEntry>[
              PopupMenuItem(onTap: () {}, child: Text('Reset PIN')),
              PopupMenuItem(
                onTap: () => controller.userData.deleteConfirmation(),
                child: Text('Hapus', style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
        ],
      ),
      body: Obx(
        () => controller.selectedUser == null
            ? FailedPagePlaceholder()
            : SingleChildScrollView(
                padding: horizontalPadding,
                child: Column(
                  children: [
                    VerticalSizedBox(height: 2),
                    UserImagePanel(),
                    VerticalSizedBox(),
                    UserRoles(
                      role: controller.selectedUser!.roles,
                      status: true,
                      alignment: MainAxisAlignment.center,
                    ),
                    VerticalSizedBox(),
                    customLabelText(text: StringValue.CREATED_AT),
                    customCaptionText(
                      text: localDateTimeFormat(
                        controller.selectedUser!.createdAt,
                      ),
                    ),
                    VerticalSizedBox(),
                    CustomCard(
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              customLabelText(text: StringValue.USER_ID),
                              customLabelText(text: StringValue.STATUS),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              customCaptionText(
                                text: controller.selectedUser!.userId,
                              ),
                              StatusSign(
                                status: controller.selectedUser!.isActive,
                                size: AppConstants.DEFAULT_FONT_SIZE.toInt(),
                              ),
                            ],
                          ),
                          VerticalSizedBox(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              customLabelText(text: StringValue.NAME),
                              customLabelText(text: StringValue.PHONE_NUMBER),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              customCaptionText(
                                text: controller.selectedUser!.name,
                              ),
                              customCaptionText(
                                text: controller.selectedUser!.phone ?? '-',
                              ),
                            ],
                          ),
                          VerticalSizedBox(),
                          Row(
                            children: [
                              Expanded(
                                child: TextButton(
                                  onPressed: () {
                                    Get.toNamed(Routes.EDIT_USER);
                                  },
                                  style: backButtonStyle(),
                                  child: Text(StringValue.EDIT_DATA),
                                ),
                              ),
                              SizedBox(
                                width: AppConstants.DEFAULT_HORIZONTAL_MARGIN,
                              ),
                              Expanded(
                                child: TextButton(
                                  onPressed: () {
                                    controller.userData.changeUserStatus();
                                  },
                                  style: controller.selectedUser!.isActive
                                      ? errorButtonStyle()
                                      : nextButtonStyle(),
                                  child: Text(
                                    controller.selectedUser!.isActive
                                        ? StringValue.DEACTIVATE
                                        : StringValue.ACTIVATE,
                                    style: AppTextStyle.buttonText,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
