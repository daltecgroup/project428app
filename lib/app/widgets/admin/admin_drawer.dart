import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project428app/app/constants.dart';
import 'package:project428app/app/services/personalization_service.dart';

Drawer AdminDrawer(BuildContext context, String selectedItem) {
  final Personalization c = Get.find<Personalization>();
  GetStorage box = GetStorage();

  Color selectedColor = Colors.blueAccent;
  double tileIconSize = 18;

  return Drawer(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: BoxDecoration(color: selectedColor),
          child: Container(
            alignment: Alignment.bottomLeft,
            child: ListTile(
              contentPadding: EdgeInsets.only(left: 0),
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(
                  c.userdata.imgUrl,
                  webHtmlElementStrategy: WebHtmlElementStrategy.prefer,
                ),
              ),
              title: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  c.userdata.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              subtitle: Text("Admin", style: TextStyle(color: Colors.white)),
            ),
          ),
        ),
        ListTile(
          leading: Icon(Icons.home_filled, size: tileIconSize),
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
          leading: Icon(Icons.flag, size: tileIconSize),
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
          leading: Icon(Icons.person, size: tileIconSize),
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
          leading: Icon(Icons.work, size: tileIconSize),
          title: const Text('Operator'),
          selected: selectedItem == kAdminMenuOperator ? true : false,
          selectedColor: selectedColor,
          selectedTileColor: selectedColor.withOpacity(0.2),
          onTap: () {
            Get.toNamed('/operator');
          },
        ),
        ListTile(
          leading: Icon(Icons.inventory_2_rounded, size: tileIconSize),
          title: const Text('Stok'),
          selected: selectedItem == kAdminMenuStok ? true : false,
          selectedColor: selectedColor,
          selectedTileColor: selectedColor.withOpacity(0.2),
          onTap: () {
            Get.toNamed('/stok');
          },
        ),
        ListTile(
          leading: Icon(Icons.fastfood_rounded, size: tileIconSize),
          title: const Text('Produk'),
          selected: selectedItem == kAdminMenuProduk ? true : false,
          selectedColor: selectedColor,
          selectedTileColor: selectedColor.withOpacity(0.2),
          onTap: () {
            Get.toNamed('/produk');
          },
        ),
        ListTile(
          leading: Icon(Icons.percent_rounded, size: tileIconSize),
          title: const Text('Promo'),
          selected: selectedItem == kAdminMenuPromo ? true : false,
          selectedColor: selectedColor,
          selectedTileColor: selectedColor.withOpacity(0.2),
          onTap: () {
            Get.toNamed('/promo');
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Divider(color: Colors.grey[400], height: 0.2),
        ),
        ListTile(
          leading: Icon(Icons.task_rounded, size: tileIconSize),
          title: const Text('Aktivitas'),
          selected: selectedItem == kAdminMenuAktivitas ? true : false,
          selectedColor: selectedColor,
          selectedTileColor: selectedColor.withOpacity(0.2),
          onTap: () {
            Get.toNamed('/aktivitas-admin');
          },
        ),
        ListTile(
          leading: Icon(Icons.settings, size: tileIconSize),
          title: const Text('Pengaturan'),
          selected: selectedItem == kAdminMenuPengaturan ? true : false,
          selectedColor: selectedColor,
          selectedTileColor: selectedColor.withOpacity(0.2),
          onTap: () {
            Get.toNamed('/pengaturan-admin');
          },
        ),
        ListTile(
          leading: Icon(Icons.logout_outlined, size: tileIconSize),
          title: const Text('Logout'),
          onTap: () {
            Get.find<Personalization>().currentRoleTheme.value = 'admin';
            box.remove(kUserData);
            box.remove(kAllUserData);
            Get.offNamed('/login');
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
