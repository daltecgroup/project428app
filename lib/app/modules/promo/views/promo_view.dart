import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../core/constants/constants.dart';
import '../../../shared/widgets/admin/admin_appbar.dart';
import '../../../shared/widgets/admin/admin_drawer.dart';
import '../controllers/promo_controller.dart';

class PromoView extends GetView<PromoController> {
  const PromoView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AdminAppBar(context, "Promo", null),
      drawer: AdminDrawer(context, kAdminMenuPromo),
      body: const Center(
        child: Text('PromoView is working', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
