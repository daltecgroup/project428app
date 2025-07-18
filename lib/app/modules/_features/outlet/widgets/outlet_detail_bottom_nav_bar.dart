import 'package:abg_pos_app/app/modules/_features/outlet/controllers/outlet_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OutletDetailBottomNavBar extends StatelessWidget {
  const OutletDetailBottomNavBar({super.key, required this.controller});

  final OutletDetailController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => BottomNavigationBar(
        currentIndex: controller.selectedTab.value,
        onTap: (index) => controller.selectedTab.value = index,
        showUnselectedLabels: true,
        selectedItemColor: Colors.blue[800],
        unselectedItemColor: Colors.grey[500],
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            label: 'Ringkasan',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.receipt_long),
          //   label: 'Transaksi',
          // ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.receipt_long),
          //   label: 'Pesanan',
          // ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.inventory_2_outlined),
          //   label: 'Stok',
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: 'Pengaturan',
          ),
        ],
      ),
    );
  }
}
