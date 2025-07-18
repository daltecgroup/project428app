import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../utils/theme/text_style.dart';
import '../../../../utils/theme/custom_text.dart';
import '../../../../utils/constants/string_value.dart';
import '../../../../utils/constants/app_constants.dart';
import '../controllers/user_list_controller.dart';

Future<dynamic> userFilterDialog() {
  UserListController c = Get.find<UserListController>();
  return Get.defaultDialog(
    title: StringValue.USER_FILTER,
    titleStyle: AppTextStyle.dialogTitle,
    radius: AppConstants.DEFAULT_BORDER_RADIUS,
    content: Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.DEFAULT_PADDING,
      ),
      child: Obx(
        () => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customInputTitleText(text: StringValue.SEQUENCE),
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
                      customInputTitleText(text: StringValue.NEWEST_TO_OLDEST),
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
                      customInputTitleText(text: StringValue.OLDEST_TO_NEWEST),
                    ],
                  ),
                ],
              ),
              customInputTitleText(text: StringValue.STATUS),
              Row(
                children: [
                  Checkbox(
                    value: c.filter.value.showActive,
                    onChanged: (value) {
                      c.filter.value.setShowActive(value!);
                      c.filter.refresh();
                    },
                  ),
                  Text(StringValue.ACTIVE),
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
                  Text(StringValue.INACTIVE),
                ],
              ),
              customInputTitleText(text: StringValue.ROLE),
              Row(
                children: [
                  Checkbox(
                    value: c.filter.value.showAdmin,
                    onChanged: (value) {
                      c.filter.value.setShowAdmin(value!);
                      c.filter.refresh();
                    },
                  ),
                  Text(StringValue.ADMIN),
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
                  Text(StringValue.FRANCHISEE),
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
                  Text(StringValue.SPV_AREA),
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
                  Text(StringValue.OPERATOR),
                ],
              ),
              GestureDetector(
                onTap: () {
                  c.filter.value.resetFilters();
                  c.filter.refresh();
                },
                child: Text(StringValue.RESET),
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
      child: Text(StringValue.CLOSE),
    ),
  );
}
