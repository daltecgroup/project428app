import 'package:flutter/material.dart';

Text TextHeader({
  required String text,
  double fontSize = 20,
  FontWeight fontWeight = FontWeight.w600,
}) {
  return Text(
    text,
    style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
  );
}

Text TextTitle({
  required String text,
  double fontSize = 14,
  FontWeight fontWeight = FontWeight.w600,
}) {
  return Text(
    text,
    style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
  );
}
