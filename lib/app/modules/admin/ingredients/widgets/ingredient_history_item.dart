import 'package:flutter/material.dart';

import '../../../../utils/helpers/time_helper.dart';

class IngredientHistoryItem extends StatelessWidget {
  const IngredientHistoryItem({
    super.key,
    this.first,
    this.last,
    this.createdAt,
    this.content,
  });

  final bool? first;
  final bool? last;
  final DateTime? createdAt;
  final String? content;

  @override
  Widget build(BuildContext context) {
    bool firstEntry = first ?? true;
    bool lastEntry = last ?? true;
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              firstEntry
                  ? SizedBox(height: 4)
                  : Container(width: 1, height: 4, color: Colors.grey),
              // SizedBox(height: 4),
              Icon(Icons.circle_rounded, size: 12, color: Colors.grey),
              // Text("|"),
              if (!lastEntry)
                Expanded(child: Container(width: 1, color: Colors.grey)),
            ],
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  localDateTimeFormat(createdAt ?? DateTime.now()),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  content ?? '',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                if (!lastEntry) SizedBox(height: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
