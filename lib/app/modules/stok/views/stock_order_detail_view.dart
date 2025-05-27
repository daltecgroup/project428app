import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StockOrderDetailView extends GetView {
  const StockOrderDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StockOrderDetailView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'StockOrderDetailView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
