import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project428app/app/constants.dart';
import 'package:project428app/app/services/personalization_service.dart';

Drawer AdminDrawer(BuildContext context, String selectedItem) {
  final Personalization c = Get.find<Personalization>();
  GetStorage box = GetStorage();

  Color selectedColor = Colors.blueAccent;

  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: BoxDecoration(color: selectedColor),
          child: ListTile(
            leading: CircleAvatar(radius: 30),
            title: Text(
              'Admin',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              'Welcome, ${c.userdata.name}',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        ListTile(
          title: const Text('Beranda'),
          selected: selectedItem == kAdminMenuBeranda ? true : false,
          selectedColor: selectedColor,
          selectedTileColor: selectedColor.withOpacity(0.2),
          onTap: () {
            // Handle item tap
            Get.toNamed('/beranda-admin');
          },
        ),
        ListTile(
          title: const Text('Gerai'),
          selected: selectedItem == kAdminMenuGerai ? true : false,
          selectedColor: selectedColor,
          selectedTileColor: selectedColor.withOpacity(0.2),
          onTap: () {
            // Handle item tap
            Get.toNamed('/gerai');
          },
        ),
        ListTile(
          title: const Text('Pengguna'),
          selected: selectedItem == kAdminMenuPengguna ? true : false,
          selectedColor: selectedColor,
          selectedTileColor: selectedColor.withOpacity(0.2),
          onTap: () {
            // Handle item tap
            Get.toNamed('/pengguna');
          },
        ),
        ListTile(
          title: const Text('Operator'),
          selected: selectedItem == kAdminMenuOperator ? true : false,
          selectedColor: selectedColor,
          selectedTileColor: selectedColor.withOpacity(0.2),
          onTap: () {
            Get.toNamed('/operator');
          },
        ),
        ListTile(
          title: const Text('Stok'),
          selected: selectedItem == kAdminMenuStok ? true : false,
          selectedColor: selectedColor,
          selectedTileColor: selectedColor.withOpacity(0.2),
          onTap: () {
            Get.toNamed('/stok');
          },
        ),
        ListTile(
          title: const Text('Produk'),
          selected: selectedItem == kAdminMenuProduk ? true : false,
          selectedColor: selectedColor,
          selectedTileColor: selectedColor.withOpacity(0.2),
          onTap: () {
            Get.toNamed('/produk');
          },
        ),
        ListTile(
          title: const Text('Promo'),
          selected: selectedItem == kAdminMenuPromo ? true : false,
          selectedColor: selectedColor,
          selectedTileColor: selectedColor.withOpacity(0.2),
          onTap: () {
            Get.toNamed('/promo');
          },
        ),
        Divider(color: Colors.grey),
        ListTile(
          title: const Text('Logout'),
          onTap: () {
            Get.find<Personalization>().currentRoleTheme.value = 'admin';
            box.remove(kUserData);
            box.remove(kAllUserData);
            Get.offNamed('/login');
          },
        ),
        IconButton(
          icon: Obx(
            () =>
                c.isDarkMode.value
                    ? Icon(Icons.dark_mode)
                    : Icon(Icons.light_mode),
          ),
          onPressed: () {
            c.switchTheme();
          },
        ),
      ],
    ),
  );
}
