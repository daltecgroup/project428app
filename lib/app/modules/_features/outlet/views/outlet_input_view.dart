import 'package:abg_pos_app/app/utils/constants/padding_constants.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../routes/app_pages.dart';
import '../../../../shared/custom_card.dart';
import '../../../../shared/inputs/custom_dropdown_input.dart';
import '../../../../shared/buttons/bottom_nav_button.dart';
import '../../../../shared/custom_appbar_lite.dart';
import '../../../../shared/custom_input_with_error.dart';
import '../../../../shared/status_sign.dart';
import '../../../../shared/vertical_sized_box.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/constants/string_value.dart';
import '../../../../utils/helpers/text_helper.dart';
import '../../../../utils/theme/custom_text.dart';
import '../controllers/outlet_input_controller.dart';

class OutletInputView extends GetView<OutletInputController> {
  const OutletInputView({super.key});
  @override
  Widget build(BuildContext context) {
    Future.delayed(Durations.short4, () => controller.initInput());
    return Scaffold(
      appBar: customAppBarLite(
        context: context,
        title: controller.isEdit ? 'Ubah Outlet' : 'Tambah Outlet',
        backRoute: controller.isEdit
            ? Routes.OUTLET_DETAIL
            : Routes.OUTLET_LIST,
      ),
      body: Stack(
        children: [
          // input field
          Obx(() {
            final outlet = controller.data.selectedOutlet.value;
            return ListView(
              padding: horizontalPadding,
              children: [
                const VerticalSizedBox(height: 2),

                // outlet detail
                if (controller.isEdit) ...[
                  CustomCard(
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            customLabelText(text: 'Nama Lama'),
                            customCaptionText(
                              text: normalizeName(outlet!.name),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            customLabelText(text: StringValue.STATUS),
                            StatusSign(
                              status: outlet.isActive,
                              size: AppConstants.DEFAULT_FONT_SIZE.toInt(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const VerticalSizedBox(),
                ],

                // data input field
                CustomCard(
                  content: Column(
                    children: [
                      CustomInputWithError(
                        title: controller.isEdit
                            ? 'Kode Baru'
                            : StringValue.OUTLET_CODE,
                        hint: StringValue.INPUT_OUTLET_CODE,
                        controller: controller.codeC,
                        error: controller.codeError.value,
                        errorText: controller.codeErrorText.value,
                        inputFormatter: <TextInputFormatter>[
                          LengthLimitingTextInputFormatter(50),
                        ],
                        onChanged: (_) => controller.codeError.value = false,
                      ),
                      const VerticalSizedBox(),
                      CustomInputWithError(
                        title: controller.isEdit
                            ? 'Nama Baru'
                            : StringValue.OUTLET_NAME,
                        hint: StringValue.INPUT_OUTLET_NAME,
                        controller: controller.nameC,
                        error: controller.nameError.value,
                        errorText: controller.nameErrorText.value,
                        inputFormatter: <TextInputFormatter>[
                          LengthLimitingTextInputFormatter(50),
                        ],
                        onChanged: (_) => controller.nameError.value = false,
                      ),
                    ],
                  ),
                ),

                // address input
                const VerticalSizedBox(height: 2),
                if (controller.address.provinces.isNotEmpty)
                  CustomCard(
                    content: Builder(
                      builder: (context) {
                        final address = controller.address;
                        return Obx(
                          () => Column(
                            children: [
                              if (controller.isEdit) ...[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    customLabelText(text: 'Ganti Alamat'),
                                    SizedBox(
                                      height: 40,
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Switch(
                                          padding: EdgeInsets.zero,
                                          value: controller.updateAddress.value,
                                          onChanged: (value) {
                                            controller.updateAddress.value =
                                                value;
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                              if (controller.updateAddress.value) ...[
                                const VerticalSizedBox(),
                                CustomDropdownInput(
                                  title: 'Provinsi',
                                  // value: address.selectedProvince.value,
                                  data: address.provinces,
                                  onChanged: (value) {
                                    address.selectedProvince.value = value;
                                    address.setProvince(value);
                                    address.districts.clear();
                                    address.selectedDistrict.value = '';
                                    address.villages.clear();
                                    address.fetchRegency(value);
                                  },
                                ),
                                if (controller
                                    .address
                                    .regencies
                                    .isNotEmpty) ...[
                                  const VerticalSizedBox(),
                                  CustomDropdownInput(
                                    title: 'Kabupaten/Kota',
                                    value: address.selectedRegency.value,
                                    data: address.regencies,
                                    onChanged: (value) {
                                      address.selectedRegency.value = value;
                                      address.setRegency(value);
                                      address.villages.clear();
                                      address.fetchDistrict(value);
                                    },
                                  ),
                                ],
                                if (controller
                                    .address
                                    .districts
                                    .isNotEmpty) ...[
                                  const VerticalSizedBox(),
                                  CustomDropdownInput(
                                    title: 'Kecamatan',
                                    value: address.selectedDistrict.value,
                                    data: address.districts,
                                    onChanged: (value) {
                                      address.selectedDistrict.value = value;
                                      address.setDistrict(value);
                                      address.fetchVillage(value);
                                    },
                                  ),
                                ],
                                if (controller.address.villages.isNotEmpty) ...[
                                  const VerticalSizedBox(),
                                  CustomDropdownInput(
                                    title: 'Desa/Kelurahan',
                                    value: address.selectedVillage.value,
                                    data: address.villages,
                                    onChanged: (value) {
                                      address.selectedVillage.value = value;
                                      address.setVillage(value);
                                    },
                                  ),
                                ],
                                // if (controller.address.villages.isNotEmpty)
                                ...[
                                  const VerticalSizedBox(),
                                  CustomInputWithError(
                                    title: StringValue.STREET,
                                    hint: StringValue.INPUT_STREET_NAME,
                                    controller: controller.streetC,
                                    error: controller.addressError.value,
                                    errorText:
                                        controller.addressErrorText.value,
                                    inputFormatter: <TextInputFormatter>[
                                      LengthLimitingTextInputFormatter(280),
                                    ],
                                    onChanged: (_) =>
                                        controller.nameError.value = false,
                                  ),
                                ],
                              ],
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                const VerticalSizedBox(height: 10),
              ],
            );
          }),

          // nav button
          SafeArea(
            child: BottomNavButton(
              nextBtn: 'Simpan',
              nextCb: () => controller.submit(),
            ),
          ),
        ],
      ),
    );
  }
}
