import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/produk_controller.dart';

class ViewMenuDetailView extends GetView {
  const ViewMenuDetailView({super.key, required this.c});

  final ProdukController c;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Menu'), centerTitle: true),
      body: const Center(
        child: Text(
          'ViewMenuDetailView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
