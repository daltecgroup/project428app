import 'package:abg_pos_app/app/utils/constants/string_value.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/constants/app_constants.dart';
import '../utils/theme/button_style.dart';
import '../utils/theme/custom_text.dart';
import '../utils/theme/text_style.dart';
import 'custom_input_with_error.dart';

Future<dynamic> customAlertDialog(String content) {
  return Get.defaultDialog(
    title: 'Peringatan',
    titleStyle: AppTextStyle.dialogTitle,
    radius: AppConstants.DEFAULT_BORDER_RADIUS,
    contentPadding: EdgeInsets.symmetric(
      horizontal: AppConstants.DEFAULT_PADDING,
    ),
    content: Text(
      content,
      textAlign: TextAlign.center,
      style: TextStyle(height: 1.8),
    ),
  );
}

Future<dynamic> customAlertDialogWithTitle({
  required String title,
  Widget? content,
}) {
  return Get.defaultDialog(
    title: title,
    titleStyle: AppTextStyle.dialogTitle,
    radius: AppConstants.DEFAULT_BORDER_RADIUS,
    content: content,
    contentPadding: EdgeInsets.all(AppConstants.DEFAULT_PADDING),
  );
}

Future<dynamic> customActionDialog({
  String? title,
  bool? currentStatus,
  VoidCallback? edit,
  VoidCallback? toggleStatus,
  VoidCallback? delete,
}) {
  return Get.defaultDialog(
    title: title ?? 'Pilihan',
    titleStyle: AppTextStyle.dialogTitle,
    radius: AppConstants.DEFAULT_BORDER_RADIUS,
    content: Column(
      children: [
        if (edit != null)
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: edit,
                  style: nextButtonStyle(),
                  child: customButtonText(text: 'Ubah'),
                ),
              ),
            ],
          ),
        if (toggleStatus != null)
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: toggleStatus,
                  style: nextButtonStyle(),
                  child: customButtonText(
                    text: currentStatus == null
                        ? 'Ganti Status'
                        : (currentStatus ? 'Nonaktifkan' : 'Aktifkan'),
                  ),
                ),
              ),
            ],
          ),
        if (delete != null)
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: delete,
                  style: errorButtonStyle(),
                  child: customButtonText(text: 'Hapus'),
                ),
              ),
            ],
          ),
      ],
    ),
    contentPadding: EdgeInsets.all(AppConstants.DEFAULT_PADDING),
  );
}

Future<dynamic> customSuccessAlertDialog(String content) {
  return Get.defaultDialog(
    title: 'Berhasil',
    titleStyle: AppTextStyle.dialogTitle,
    radius: AppConstants.DEFAULT_BORDER_RADIUS,
    content: Text(
      content,
      textAlign: TextAlign.center,
      style: TextStyle(height: 1.8),
    ),
  );
}

Future<dynamic> customDeleteAlertDialog(String content, VoidCallback confirm) {
  return Get.defaultDialog(
    title: StringValue.CONFIRMATION,
    titleStyle: AppTextStyle.dialogTitle,
    radius: AppConstants.DEFAULT_BORDER_RADIUS,
    content: Text(
      content,
      textAlign: TextAlign.center,
      style: TextStyle(height: 1.8),
    ),
    cancel: TextButton(
      onPressed: () => Get.back(),
      child: Text(StringValue.CANCEL),
    ),
    confirm: TextButton(onPressed: confirm, child: Text(StringValue.CONFIRM)),
  );
}

Future<dynamic> customConfirmationDialog(
  String content,
  VoidCallback confirm, {
  String? confirmText,
  String? cancelText,
}) {
  return Get.defaultDialog(
    title: StringValue.CONFIRMATION,
    titleStyle: AppTextStyle.dialogTitle,
    radius: AppConstants.DEFAULT_BORDER_RADIUS,
    contentPadding: EdgeInsets.symmetric(
      horizontal: AppConstants.DEFAULT_PADDING,
    ),
    content: Text(
      content,
      textAlign: TextAlign.center,
      style: TextStyle(height: 1.8),
    ),
    cancel: TextButton(
      onPressed: () => Get.back(),
      child: Text(cancelText ?? StringValue.CANCEL),
    ),
    confirm: TextButton(
      onPressed: confirm,
      child: Text(confirmText ?? StringValue.CONFIRM),
    ),
  );
}

Future<String> changeOrderStatusSelectionDialog() async {
  final result = await Get.defaultDialog(
    title: 'Pilihan Status',
    titleStyle: AppTextStyle.dialogTitle,
    radius: AppConstants.DEFAULT_BORDER_RADIUS,
    content: Column(
      children: [
        // Example buttons for different statuses with logo and text
        ElevatedButton(
          onPressed: () => Get.back(result: 'ordered'),
          style: primaryButtonStyle(Colors.white),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.shopping_cart, color: Colors.orange),
              SizedBox(width: 8),
              Text('Dipesan', style: TextStyle(color: Colors.orange)),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: () => Get.back(result: 'processed'),
          style: primaryButtonStyle(Colors.white),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.sync, color: Colors.blue),
              SizedBox(width: 8),
              Text('Diproses', style: TextStyle(color: Colors.blue)),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: () => Get.back(result: 'ontheway'),
          style: primaryButtonStyle(Colors.white),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.local_shipping, color: Colors.teal),
              SizedBox(width: 8),
              Text('Dalam Perjalanan', style: TextStyle(color: Colors.teal)),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: () => Get.back(result: 'returned'),
          style: primaryButtonStyle(Colors.white),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.undo, color: Colors.deepPurple),
              SizedBox(width: 8),
              Text('Dikembalikan', style: TextStyle(color: Colors.deepPurple)),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: () => Get.back(result: 'failed'),
          style: primaryButtonStyle(Colors.white),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.cancel, color: Colors.red),
              SizedBox(width: 8),
              Text('Gagal', style: TextStyle(color: Colors.red)),
            ],
          ),
        ),
      ],
    ),
    contentPadding: EdgeInsets.all(AppConstants.DEFAULT_PADDING),
  );
  return result is String ? result : '';
}

Future<String?> customTextInputDialog({
  required TextEditingController controller,
  String? title,
  String? initialValue,
  String? initialText,
  TextInputType? inputType,
  bool disableText = false,
  int? maxLines,
  String? labelText,
}) {
  String text = initialText ?? 'Jumlah saat ini';
  return Get.defaultDialog(
    title: title ?? 'Input Jumlah',
    titleStyle: AppTextStyle.dialogTitle,
    radius: AppConstants.DEFAULT_BORDER_RADIUS,
    contentPadding: EdgeInsets.all(AppConstants.DEFAULT_PADDING),
    content: Column(
      children: [
        if (initialValue != null && !disableText) Text('$text: $initialValue'),
        if (labelText != null) Text(labelText),
        CustomInputWithError(
          controller: controller,
          maxLines: maxLines,
          autoFocus: true,
          inputType: inputType ?? TextInputType.number,
          onSubmitted: (value) {
            Get.back(result: controller.text);
          },
        ),
      ],
    ),
    cancel: TextButton(
      onPressed: () {
        Get.back();
      },
      child: Text(StringValue.CANCEL),
    ),
    confirm: TextButton(
      onPressed: () {
        Get.back(result: controller.text);
      },
      child: Text(StringValue.SAVE),
    ),
  );
}
