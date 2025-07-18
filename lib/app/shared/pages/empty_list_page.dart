import 'package:abg_pos_app/app/utils/theme/custom_text.dart';
import 'package:flutter/material.dart';

class EmptyListPage extends StatelessWidget {
  const EmptyListPage({super.key, required this.refresh, required this.text});

  final VoidCallback refresh;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          customListTitleText(text: text),
          TextButton(onPressed: refresh, child: Text('Muat Ulang')),
        ],
      ),
    );
  }
}
