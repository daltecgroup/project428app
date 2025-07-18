import 'package:flutter/material.dart';

class StatusSign extends StatelessWidget {
  const StatusSign({super.key, required this.status, required this.size});

  final bool status;
  final int size;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Row(
        children: [
          Text(
            status ? 'Aktif ' : 'Nonaktif ',
            style: TextStyle(
              fontSize: size.toDouble() - 2,
              fontWeight: FontWeight.bold,
              color: status ? Colors.blue : Colors.grey,
            ),
          ),
          Icon(
            Icons.check_circle,
            size: size.toDouble(),
            color: status ? Colors.blue : Colors.grey,
          ),
        ],
      ),
    );
  }
}
