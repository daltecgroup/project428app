import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project428app/app/constants.dart';
import 'package:project428app/app/services/personalization_service.dart';

Drawer OperatorDrawer(BuildContext context, String selectedItem) {
  Color selectedColor = Colors.redAccent;

  return Drawer(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: BoxDecoration(color: selectedColor),
          child: ListTile(
            leading: CircleAvatar(radius: 30),
            title: Text(
              'Operator',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text('', style: TextStyle(color: Colors.white)),
          ),
        ),
        ListTile(
          title: const Text('Beranda'),
          selected: selectedItem == kOperatorMenuBeranda ? true : false,
          selectedColor: selectedColor,
          selectedTileColor: selectedColor.withOpacity(0.2),
          onTap: () {
            // Handle item tap
            Get.toNamed('/beranda-operator');
          },
        ),
        ListTile(
          title: const Text('Transaksi'),
          selected: selectedItem == kOperatorMenuTransaksi ? true : false,
          selectedColor: selectedColor,
          selectedTileColor: selectedColor.withOpacity(0.2),
          onTap: () {
            // Handle item tap
            Get.toNamed('/transaksi-operator');
          },
        ),
        ListTile(
          title: const Text('Absensi'),
          selected: selectedItem == kOperatorMenuAbsensi ? true : false,
          selectedColor: selectedColor,
          selectedTileColor: selectedColor.withOpacity(0.2),
          onTap: () {
            // Handle item tap
            Get.toNamed('/absensi-operator');
          },
        ),
        ListTile(
          title: const Text('Stok'),
          selected: selectedItem == kOperatorMenuStok ? true : false,
          selectedColor: selectedColor,
          selectedTileColor: selectedColor.withOpacity(0.2),
          onTap: () {
            // Handle item tap
            Get.toNamed('/stok-operator');
          },
        ),
        Divider(color: Colors.grey),
        ListTile(
          title: const Text('Aktivitas'),
          selected: selectedItem == kOperatorMenuAktivitas ? true : false,
          selectedColor: selectedColor,
          selectedTileColor: selectedColor.withOpacity(0.2),
          onTap: () {
            // Handle item tap
            Get.toNamed('/aktivitas-operator');
          },
        ),
        ListTile(
          title: const Text('Logout'),
          onTap: () {
            Get.find<Personalization>().logOut();
          },
        ),
        // IconButton(
        //   icon: Obx(
        //     () =>
        //         c.isDarkMode.value
        //             ? Icon(Icons.dark_mode)
        //             : Icon(Icons.light_mode),
        //   ),
        //   onPressed: () {
        //     c.switchTheme();
        //   },
        // ),
      ],
    ),
  );
}
