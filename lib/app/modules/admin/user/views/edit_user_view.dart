import 'package:abg_pos_app/app/modules/admin/user/controllers/edit_user_controller.dart';
import 'package:abg_pos_app/app/shared/custom_appbar_lite.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import '../../../../shared/buttons/bottom_nav_button.dart';
import '../../../../shared/custom_card.dart';
import '../../../../shared/custom_circle_avatar_image.dart';
import '../../../../shared/custom_input_with_error.dart';
import '../../../../shared/vertical_sized_box.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/constants/string_value.dart';
import '../../../../utils/theme/custom_text.dart';
import '../widgets/custom_check_box.dart';

class EditUserView extends GetView<EditUserController> {
  const EditUserView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarLite(context: context, title: 'Ubah Data Pengguna'),
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsetsGeometry.symmetric(
              horizontal: AppConstants.DEFAULT_PADDING,
            ),
            children: [
              VerticalSizedBox(),
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
                    controller.selectedUser!.name,
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text(
                    'ID ${controller.selectedUser!.userId}',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ),
              VerticalSizedBox(),
              CustomCard(
                content: Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomInputWithError(
                        title: StringValue.FULL_NAME,
                        hint: StringValue.INPUT_FULL_NAME,
                        controller: controller.nameC,
                        error: controller.nameError.value,
                        errorText: controller.nameErrorText.value,
                        inputFormatter: <TextInputFormatter>[
                          LengthLimitingTextInputFormatter(50),
                          FilteringTextInputFormatter.allow(
                            RegExp("[a-zA-Z ]"),
                          ),
                        ],
                        onChanged: (value) =>
                            controller.nameError.value = false,
                      ),

                      VerticalSizedBox(),
                      CustomInputWithError(
                        title: StringValue.PASSWORD_4_DIGIT,
                        hint: StringValue.INPUT_NEW_PASSWORD,
                        controller: controller.passwordC,
                        error: controller.passwordError.value,
                        errorText: controller.passwordErrorText.value,
                        inputType: TextInputType.number,
                        inputFormatter: <TextInputFormatter>[
                          LengthLimitingTextInputFormatter(4),
                          FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                        ],
                        onChanged: (value) =>
                            controller.passwordError.value = false,
                      ),
                      VerticalSizedBox(),
                      CustomInputWithError(
                        title: StringValue.PHONE_NUMBER,
                        hint: StringValue.INPUT_PHONE,
                        controller: controller.phoneC,
                        error: controller.phoneError.value,
                        errorText: controller.phoneErrorText.value,
                        inputType: TextInputType.phone,
                        onChanged: (value) =>
                            controller.phoneError.value = false,
                      ),
                      VerticalSizedBox(),
                      customInputTitleText(text: StringValue.ROLE),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomCheckBox(
                                text: StringValue.ADMIN,
                                value: controller.isAdmin.value,
                                onChanged: (value) {
                                  controller.isAdmin.value = value!;
                                  controller.isError;
                                },
                              ),
                              CustomCheckBox(
                                text: StringValue.FRANCHISEE,
                                value: controller.isFranchisee.value,
                                onChanged: (value) {
                                  controller.isFranchisee.value = value!;
                                  controller.isError;
                                },
                              ),
                            ],
                          ),
                          SizedBox(width: AppConstants.DEFAULT_PADDING * 2),
                          Column(
                            children: [
                              CustomCheckBox(
                                text: StringValue.SPV_AREA,
                                value: controller.isSpvarea.value,
                                onChanged: (value) {
                                  controller.isSpvarea.value = value!;
                                  controller.isError;
                                },
                              ),
                              CustomCheckBox(
                                text: StringValue.OPERATOR,
                                value: controller.isOperator.value,
                                onChanged: (value) {
                                  controller.isOperator.value = value!;
                                  controller.isError;
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      if (controller.roleError.value)
                        customErrorText(text: StringValue.ROLE_MUST_NOT_EMPTY),
                    ],
                  ),
                ),
              ),
              SizedBox(height: AppConstants.DEFAULT_VERTICAL_MARGIN * 10),
            ],
          ),
          BottomNavButton(nextCb: () => controller.submit()),
        ],
      ),
    );
  }
}
