import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:project428app/app/constants.dart';
import 'package:project428app/app/widgets/admin/admin_appbar.dart';
import 'package:project428app/app/widgets/admin/admin_drawer.dart';

import '../controllers/beranda_admin_controller.dart';
import 'package:intl/intl.dart';

class BerandaAdminView extends GetView<BerandaAdminController> {
  const BerandaAdminView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AdminAppBar(context, "Admin"),
      drawer: AdminDrawer(context, kAdminMenuBeranda),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10),
        children: [
          SizedBox(height: 20),
          Text(
            "Selamat datang, ${controller.c.userdata.name}",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 1.8,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),

            children: [
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(color: Colors.blue),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "79",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Gerai Aktif",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(color: Colors.blueGrey),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "82",
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          ),
                          Text(
                            "/82",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ],
                      ),
                      Text(
                        "Operator Aktif",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 1.8,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: [
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(color: Colors.blueGrey),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        NumberFormat('#,###,000').format(1185).toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Transaksi Hari Ini",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(color: Colors.blue),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          'IDR ${NumberFormat('#,###,000').format(5925000)}',
                          style: TextStyle(color: Colors.white, fontSize: 28),
                        ),
                      ),
                      Text(
                        "Profil Hari Ini",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Text(
            "Produk Terlaris",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(color: Colors.blueGrey),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Leker Coklat Keju",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Hari ini (250 item)",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(color: Colors.lightBlueAccent),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Leker Abon Ayam",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Bulan ini (7200 item)",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Text(
            "Pesanan Baru",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          InkWell(
            onTap: () {},
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Pesanan 763247221 (Gerai DPS 1)",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text("Pending", style: TextStyle(fontSize: 12)),
                      ],
                    ),
                    Text(
                      "Tepung 15Kg, Abon Ayam 1Kg...",
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("08.45 WIB", style: TextStyle(fontSize: 12)),
                        Text(
                          "IDR 600.000",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
