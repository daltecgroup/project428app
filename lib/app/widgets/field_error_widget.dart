import 'package:flutter/material.dart';

class FieldErrorWidget extends StatelessWidget {
  const FieldErrorWidget({
    super.key,
    required this.isError,
    required this.text,
  });

  final bool isError;
  final String text;

  @override
  Widget build(BuildContext context) {
    return isError
        ? Text(text, style: TextStyle(fontSize: 12, color: Colors.red))
        : SizedBox();
  }
}
