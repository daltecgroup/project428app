import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../shared/buttons/delete_icon_button.dart';
import '../../../../utils/helpers/time_helper.dart';
import '../controllers/bundle_detail_controller.dart';
import '../../../../routes/app_pages.dart';
import '../../../../shared/custom_appbar_lite.dart';
import '../../../../shared/custom_card.dart';
import '../../../../shared/pages/failed_page_placeholder.dart';
import '../../../../shared/vertical_sized_box.dart';
import '../../../../shared/horizontal_sized_box.dart';
import '../../../../shared/status_sign.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/constants/string_value.dart';
import '../../../../utils/helpers/number_helper.dart';
import '../../../../utils/helpers/text_helper.dart';
import '../../../../utils/theme/button_style.dart';
import '../../../../utils/theme/custom_text.dart';
import '../../../../utils/theme/text_style.dart';

class BundleDetailView extends GetView<BundleDetailController> {
  const BundleDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarLite(
        title: 'Detail Paket',
        backRoute: Routes.BUNDLE_LIST,
        actions: [
          DeleteIconButton(
            onPressed: () {
              controller.data.deleteConfirmation();
            },
            tooltip: StringValue.DELETE_MENU,
          ),
        ],
      ),
      body: Obx(() {
        final bundle = controller.data.selectedBundle.value;
        if (bundle == null) return FailedPagePlaceholder();
        return RefreshIndicator(
          onRefresh: () => controller.refreshData(),
          child: ListView(
            padding: EdgeInsets.symmetric(
              horizontal: AppConstants.DEFAULT_PADDING,
            ),
            children: [
              const VerticalSizedBox(height: 2),
              CustomCard(
                content: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        customLabelText(text: StringValue.BUNDLE_CODE),
                        customLabelText(text: StringValue.STATUS),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        customCaptionText(text: bundle.code),
                        StatusSign(
                          status: bundle.isActive,
                          size: AppConstants.DEFAULT_FONT_SIZE.toInt(),
                        ),
                      ],
                    ),
                    const VerticalSizedBox(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        customLabelText(text: StringValue.BUNDLE_NAME),
                        customLabelText(text: StringValue.PRICE),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        customCaptionText(text: normalizeName(bundle.name)),
                        customCaptionText(text: inRupiah(bundle.price)),
                      ],
                    ),
                    const VerticalSizedBox(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        customLabelText(text: StringValue.DESCRIPTION),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: customCaptionText(
                            text: bundle.description ?? '-',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const VerticalSizedBox(),
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              Get.toNamed(Routes.BUNDLE_INPUT);
                            },
                            style: backButtonStyle(),
                            child: Text(StringValue.EDIT_DATA),
                          ),
                        ),
                        const HorizontalSizedBox(),
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              controller.data.changeStatus(
                                bundle.id,
                                !bundle.isActive,
                              );
                            },
                            style: bundle.isActive
                                ? errorButtonStyle()
                                : nextButtonStyle(),
                            child: Text(
                              bundle.isActive
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
              const VerticalSizedBox(),
              CustomCard(
                content: Column(
                  children: [
                    if (bundle.categories.isEmpty)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Text('Kategori Kosong')],
                      ),
                    if (bundle.categories.isNotEmpty)
                      Row(
                        mainAxisAlignment: bundle.categories.isNotEmpty
                            ? MainAxisAlignment.spaceBetween
                            : MainAxisAlignment.center,
                        children: [customLabelText(text: 'Kategori')],
                      ),
                    if (bundle.categories.isNotEmpty)
                      const VerticalSizedBox(height: 0.7),
                    ...bundle.categories.asMap().entries.map((item) {
                      final category = controller.categoryData.getCategory(
                        item.value.menuCategoryId,
                      );
                      if (category == null)
                        return Column(
                          children: [
                            CustomCard(
                              padding: 12,
                              color: Colors.grey[200],
                              content: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [Text('Kategori Tidak Ditemukan')],
                              ),
                            ),
                            if (item.key != bundle.categories.length - 1)
                              const VerticalSizedBox(),
                          ],
                        );
                      return Column(
                        children: [
                          CustomCard(
                            padding: 12,
                            content: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(normalizeName(category.name)),
                                Text('${item.value.qty.round()} item'),
                              ],
                            ),
                          ),
                          if (item.key != bundle.categories.length - 1)
                            const VerticalSizedBox(),
                        ],
                      );
                    }),
                  ],
                ),
              ),
              const VerticalSizedBox(height: 2),
              if (controller.data.latestSync.value != null)
                customFooterText(
                  textAlign: TextAlign.center,
                  text:
                      'Diperbarui ${contextualLocalDateTimeFormat(controller.data.latestSync.value!)}',
                ),
              const VerticalSizedBox(height: 5),
            ],
          ),
        );
      }),
    );
  }
}
