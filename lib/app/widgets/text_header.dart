import 'package:flutter/material.dart';

TextHeader({
  required String text,
  double fontSize = 20,
  FontWeight fontWeight = FontWeight.w600,
}) {
  return Text(
    text,
    style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
  );
}

TextTitle({
  required String text,
  double fontSize = 14,
  FontWeight fontWeight = FontWeight.w600,
}) {
  return Text(
    text,
    style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
  );
}
