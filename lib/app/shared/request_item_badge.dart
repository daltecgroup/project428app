import 'package:flutter/material.dart';

class RequestItemBadge extends StatelessWidget {
  const RequestItemBadge({super.key, required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case 'approved':
        return Badge(
          backgroundColor: Colors.green.shade700,
          label: Text('Disetujui'),
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 1),
        );
      case 'rejected':
        return Badge(
          backgroundColor: Colors.red.shade700,
          label: Text('Ditolak'),
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 1),
        );

      default:
        return Badge(
          backgroundColor: Colors.orange.shade500,
          label: Text('Pending'),
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 1),
        );
    }
  }
}
