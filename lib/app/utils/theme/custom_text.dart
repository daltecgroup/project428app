// create custom text widget
import 'package:abg_pos_app/app/utils/theme/text_style.dart';
import 'package:flutter/material.dart';

Text customTitleText({
  required String text,
  TextStyle? style,
  TextAlign? textAlign,
  int? maxLines,
  TextOverflow? overflow,
}) {
  return Text(
    text,
    style: style ?? AppTextStyle.subHeading,
    textAlign: textAlign ?? TextAlign.start,
    maxLines: maxLines,
    overflow: overflow ?? TextOverflow.ellipsis,
  );
}

Text customCaptionText({
  required String text,
  TextStyle? style,
  TextAlign? textAlign,
  int? maxLines,
  TextOverflow? overflow,
}) {
  return Text(
    text,
    style: style ?? AppTextStyle.bodyText,
    textAlign: textAlign ?? TextAlign.start,
    maxLines: maxLines,
    overflow: overflow ?? TextOverflow.ellipsis,
  );
}

Text customFooterText({
  required String text,
  TextStyle? style,
  TextAlign? textAlign,
  int? maxLines,
  TextOverflow? overflow,
}) {
  return Text(
    text,
    style: style ?? AppTextStyle.caption,
    textAlign: textAlign ?? TextAlign.start,
    maxLines: maxLines,
    overflow: overflow ?? TextOverflow.ellipsis,
  );
}

Text customLabelText({
  required String text,
  TextStyle? style,
  TextAlign? textAlign,
  int? maxLines,
  TextOverflow? overflow,
}) {
  return Text(
    text,
    style: style ?? AppTextStyle.inputLabel,
    textAlign: textAlign ?? TextAlign.start,
    maxLines: maxLines,
    overflow: overflow ?? TextOverflow.ellipsis,
  );
}

Text customListHeaderText({
  required String text,
  TextStyle? style,
  TextAlign? textAlign,
  int? maxLines,
  TextOverflow? overflow,
}) {
  return Text(
    text,
    style: style ?? AppTextStyle.listHeader,
    textAlign: textAlign ?? TextAlign.start,
    maxLines: maxLines,
    overflow: overflow ?? TextOverflow.ellipsis,
  );
}

Text customListTitleText({
  required String text,
  TextStyle? style,
  TextAlign? textAlign,
  int? maxLines,
  TextOverflow? overflow,
}) {
  return Text(
    text,
    style: style ?? AppTextStyle.listTitle,
    textAlign: textAlign ?? TextAlign.start,
    maxLines: maxLines,
    overflow: overflow ?? TextOverflow.ellipsis,
  );
}

Text customInputTitleText({
  required String text,
  TextStyle? style,
  TextAlign? textAlign,
  int? maxLines,
  TextOverflow? overflow,
}) {
  return Text(
    text,
    style: style ?? AppTextStyle.inputLabel,
    textAlign: textAlign ?? TextAlign.start,
    maxLines: maxLines,
    overflow: overflow ?? TextOverflow.ellipsis,
  );
}

Text customSmallLabelText({
  required String text,
  TextStyle? style,
  TextAlign? textAlign,
  int? maxLines,
  TextOverflow? overflow,
}) {
  return Text(
    text,
    style: style ?? AppTextStyle.smallInputLabel,
    textAlign: textAlign ?? TextAlign.start,
    maxLines: maxLines,
    overflow: overflow ?? TextOverflow.ellipsis,
  );
}

Text customButtonText({
  required String text,
  TextStyle? style,
  TextAlign? textAlign,
  int? maxLines,
  TextOverflow? overflow,
}) {
  return Text(
    text,
    style: style ?? AppTextStyle.buttonText,
    textAlign: textAlign ?? TextAlign.start,
    maxLines: maxLines,
    overflow: overflow ?? TextOverflow.ellipsis,
  );
}

Text customErrorText({
  required String text,
  TextStyle? style,
  TextAlign? textAlign,
  int? maxLines,
  TextOverflow? overflow,
}) {
  return Text(
    text,
    style: style ?? AppTextStyle.errorText,
    textAlign: textAlign ?? TextAlign.start,
    maxLines: maxLines,
    overflow: overflow ?? TextOverflow.ellipsis,
  );
}

Text customCardTitleText({
  required String text,
  TextStyle? style,
  TextAlign? textAlign,
  int? maxLines,
  TextOverflow? overflow,
}) {
  return Text(
    text,
    style: style ?? AppTextStyle.cardTitle,
    textAlign: textAlign ?? TextAlign.start,
    maxLines: maxLines,
    overflow: overflow ?? TextOverflow.ellipsis,
  );
}
