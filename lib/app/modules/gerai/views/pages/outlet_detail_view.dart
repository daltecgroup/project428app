import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project428app/app/modules/gerai/controllers/outlet_detail_controller.dart';
import 'package:project428app/app/modules/gerai/views/pages/transaction_page_widget.dart';
import 'package:project428app/app/modules/gerai/views/widgets/detail_page_widget.dart';
import 'package:project428app/app/modules/gerai/views/pages/document_page_widget.dart';
import 'package:project428app/app/modules/gerai/views/pages/report_page_widget.dart';

class OutletDetailView extends GetView {
  const OutletDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    OutletDetailController c = Get.put(OutletDetailController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Get.arguments.name,
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Get.offNamed('/gerai');
          },
          icon: Icon(Icons.arrow_back_rounded),
        ),
      ),
      body: Obx(
        () => [
          DetailPageWidget(c: c),
          ReportPageWidget(),
          DocumentPageWidget(),
          TransactionPageWidget(),
        ].elementAt(c.selectedIndex.value),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          showUnselectedLabels: true,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Rincian'),
            BottomNavigationBarItem(
              icon: Icon(Icons.document_scanner_rounded),
              label: 'Laporan',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.file_copy_rounded),
              label: 'Dokumen',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.payment),
              label: 'Transaksi',
            ),
          ],
          currentIndex: c.selectedIndex.value,
          unselectedItemColor: Colors.grey[500],
          selectedItemColor: Colors.blue[800],
          onTap: (index) {
            c.selectedIndex.value = index;
          },
        ),
      ),
    );
  }
}
