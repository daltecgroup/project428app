import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../shared/widgets/format_waktu.dart';

class StockHistory {
  final String id, stockRef, authorRef, authorName, content;
  final DateTime createdAt;

  StockHistory({
    required this.id,
    required this.stockRef,
    required this.authorRef,
    required this.authorName,
    required this.content,
    required this.createdAt,
  });

  StockHistory.fromJson(Map<String, dynamic> json)
    : id = json['_id'] as String,
      stockRef = json['stock'] as String,
      authorRef = json['author']['userRef'] as String,
      authorName = json['author']['name'] as String,
      content = json['content'] as String,
      createdAt = MakeLocalDateTime(json['createdAt']);

  String getCreateTime() {
    return "${createdAt.day} ${DateFormat(DateFormat.MONTH, 'id').format(createdAt)} ${createdAt.year} ${createdAt.hour}:${createdAt.minute.isLowerThan(10) ? '0${createdAt.minute}' : createdAt.minute} WIB";
  }
}
