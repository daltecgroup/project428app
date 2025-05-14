import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../constants.dart';
import '../../../widgets/admin/admin_appbar.dart';
import '../../../widgets/admin/admin_drawer.dart';
import '../controllers/produk_controller.dart';

class ProdukView extends GetView<ProdukController> {
  const ProdukView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AdminAppBar(context, "Produk"),
      drawer: AdminDrawer(context, kAdminMenuProduk),
      body: const Center(
        child: Text('ProdukView is working', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
