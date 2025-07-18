import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FloatingAddButton extends StatelessWidget {
  const FloatingAddButton({
    super.key,
    this.route,
    this.tooltip,
    this.onPressed,
  });

  final String? route, tooltip;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        tooltip: tooltip,
        heroTag: 'floating_add_button',
        onPressed: route != null
            ? () {
                Get.toNamed(route!);
              }
            : onPressed,
        child: const Icon(Icons.add),
      ),
    );
  }
}
