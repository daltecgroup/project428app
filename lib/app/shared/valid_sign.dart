import 'package:flutter/material.dart';

class ValidSign extends StatelessWidget {
  const ValidSign({super.key, required this.isValid, required this.size});

  final bool isValid;
  final int size;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Row(
        children: [
          Text(
            isValid ? 'Valid ' : 'Invalid ',
            style: TextStyle(
              fontSize: size.toDouble() - 2,
              fontWeight: FontWeight.bold,
              color: isValid ? Colors.green[700] : Colors.red,
            ),
          ),
          Stack(
            children: [
              Icon(
                isValid ? Icons.check_circle_rounded : Icons.circle,
                size: size.toDouble(),
                color: isValid ? Colors.green[700] : Colors.red,
              ),
              if (!isValid)
                Icon(
                  Icons.close_rounded,
                  size: size.toDouble(),
                  color: Colors.white,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
