import 'package:flutter/material.dart';

class UserRoles extends StatelessWidget {
  const UserRoles({
    super.key,
    required this.role,
    required this.status,
    required this.alignment,
  });

  final List role;
  final bool status;
  final MainAxisAlignment alignment;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: alignment,
      children: [
        role.contains('admin')
            ? Container(
              margin: const EdgeInsets.only(right: 3),
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              decoration: BoxDecoration(
                color: status ? Colors.blueAccent : Colors.grey,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                "Admin",
                style: TextStyle(color: Colors.white, fontSize: 10),
              ),
            )
            : SizedBox(),
        role.contains('franchisee')
            ? Container(
              margin: const EdgeInsets.only(right: 3),
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              decoration: BoxDecoration(
                color: status ? Colors.green : Colors.grey,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                "Franchisee",
                style: TextStyle(color: Colors.white, fontSize: 10),
              ),
            )
            : SizedBox(),
        role.contains('spvarea')
            ? Container(
              margin: const EdgeInsets.only(right: 3),
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              decoration: BoxDecoration(
                color: status ? Colors.cyan : Colors.grey,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                "SPV Area",
                style: TextStyle(color: Colors.white, fontSize: 10),
              ),
            )
            : SizedBox(),
        role.contains('operator')
            ? Container(
              margin: const EdgeInsets.only(right: 3),
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              decoration: BoxDecoration(
                color: status ? Colors.amber[800] : Colors.grey,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                "Operator",
                style: TextStyle(color: Colors.white, fontSize: 10),
              ),
            )
            : SizedBox(),
      ],
    );
  }
}
