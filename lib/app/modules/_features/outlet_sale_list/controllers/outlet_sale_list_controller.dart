import 'dart:io';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../controllers/outlet_data_controller.dart';
import '../../../../controllers/sale_data_controller.dart';
import '../../../../shared/alert_snackbar.dart';
import '../../../../shared/custom_alert.dart';
import '../../../../utils/helpers/logger_helper.dart';
import '../../../../utils/helpers/time_helper.dart';

class OutletSaleListController extends GetxController {
  OutletSaleListController({required this.outletData, required this.data});
  final OutletDataController outletData;
  final SaleDataController data;

  final startDate = DateTime.now().subtract(Duration(days: 7)).obs;
  final endDate = DateTime.now().obs;

  final startDateC = TextEditingController();
  final backRoute = Get.previousRoute;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    startDateC.dispose();
    super.onClose();
  }

  Future<void> setDateRange(BuildContext context) async {
    try {
      final dateRange = await showDateRangePicker(
        initialDateRange: DateTimeRange(
          start: DateTime.now(),
          end: DateTime.now(),
        ),
        context: context,
        firstDate: tenYearsAgo,
        lastDate: DateTime.now(),
      );
      if (dateRange == null) return;
      startDate(dateRange.start);
      endDate(dateRange.end);
      isLoading(true);
      data.startDate(startDate.value);
      data.endDate(endDate.value);
      await data.syncData(refresh: true);
    } catch (e) {
      LoggerHelper.logError(e.toString());
      customAlertDialog('Gagal memperoleh data terbaru: ${e.toString()}');
    } finally {
      isLoading(false);
    }
  }

  Future<void> resetDateRange() async {
    endDate(DateTime.now());
    startDate(DateTime.now().subtract(Duration(days: 7)));
    data.startDate(startDate.value);
    data.endDate(endDate.value);
    await data.syncData(refresh: true);
  }

  List<Widget> get actionButtons {
    return [
      PopupMenuButton(
        color: Colors.white,
        icon: Icon(Icons.more_vert),
        itemBuilder: (context) => <PopupMenuEntry>[
          PopupMenuItem(
            onTap: () => data.sales.isNotEmpty
                ? downloadExcelFile()
                : customAlertDialog('Tidak ada data untuk diunduh'),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text('Unduh XLSX'), Icon(Icons.download)],
            ),
          ),
        ],
      ),
    ];
  }

  Future<void> downloadExcelFile() async {
    var excel = Excel.createExcel();
    Sheet sheetTransaction = excel['per_transaksi'];

    List<String> transactionHeader = [
      'tanggal',
      'jam',
      'kode_transaksi',
      'nama_gerai',
      'nama_operator',
      'item_single',
      'item_bundle',
      'item_promo',
      'total_harga',
      'total_bayar',
      'kembalian',
      'metode',
    ];

    for (var i = 0; i < transactionHeader.length; i++) {
      var cell = sheetTransaction.cell(
        CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0),
      );
      cell.value = TextCellValue(transactionHeader[i]);
      cell.cellStyle = CellStyle(bold: true);
    }

    for (var i = 0; i < data.sales.length; i++) {
      var rowData = data.sales[i];

      // tanggal
      sheetTransaction
          .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i + 1))
          .value = DateCellValue(
        year: rowData.createdAt.year,
        month: rowData.createdAt.month,
        day: rowData.createdAt.day,
      );

      //jam
      sheetTransaction
          .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: i + 1))
          .value = TimeCellValue(
        hour: rowData.createdAt.hour,
        minute: rowData.createdAt.minute,
        second: rowData.createdAt.second,
      );

      // kode
      sheetTransaction
          .cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: i + 1))
          .value = TextCellValue(
        rowData.code,
      );

      // outlet
      sheetTransaction
          .cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: i + 1))
          .value = TextCellValue(
        rowData.outlet.name,
      );

      // operator
      sheetTransaction
          .cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: i + 1))
          .value = TextCellValue(
        rowData.operator.name,
      );

      sheetTransaction
          .cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: i + 1))
          .value = TextCellValue(
        rowData.itemSingle.length.toString(),
      );

      sheetTransaction
          .cell(CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: i + 1))
          .value = TextCellValue(
        rowData.itemBundle.length.toString(),
      );

      sheetTransaction
          .cell(CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: i + 1))
          .value = TextCellValue(
        rowData.itemPromo.length.toString(),
      );

      sheetTransaction
          .cell(CellIndex.indexByColumnRow(columnIndex: 8, rowIndex: i + 1))
          .value = DoubleCellValue(
        rowData.totalPrice,
      );

      sheetTransaction
          .cell(CellIndex.indexByColumnRow(columnIndex: 9, rowIndex: i + 1))
          .value = DoubleCellValue(
        rowData.totalPaid,
      );

      sheetTransaction
          .cell(CellIndex.indexByColumnRow(columnIndex: 10, rowIndex: i + 1))
          .value = DoubleCellValue(
        rowData.totalChange,
      );

      sheetTransaction
          .cell(CellIndex.indexByColumnRow(columnIndex: 11, rowIndex: i + 1))
          .value = TextCellValue(
        rowData.payment.method,
      );
    }

    Sheet sheetItem = excel['per_item'];

    List<String> itemHeader = [
      'tanggal',
      'jam',
      'kode_transaksi',
      'nama_gerai',
      'nama_operator',
      'jenis_item',
      'nama_item',
      'jumlah',
      'harga',
      'diskon',
      'catatan',
    ];

    for (var i = 0; i < itemHeader.length; i++) {
      var cell = sheetItem.cell(
        CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0),
      );
      cell.value = TextCellValue(itemHeader[i]);
      cell.cellStyle = CellStyle(bold: true);
    }

    final List<SaleReportItem> items = [];

    for (var item in data.sales) {
      if (item.itemBundle.isNotEmpty) {
        for (var bundle in item.itemBundle) {
          items.add(
            SaleReportItem(
              code: item.code,
              outlet: item.outlet.name,
              operator: item.operator.name,
              type: 'item_bundle',
              name: bundle.name,
              notes: '',
              qty: bundle.qty,
              price: bundle.price,
              discount: 0,
              createdAt: item.createdAt,
            ),
          );
        }
      }

      if (item.itemSingle.isNotEmpty) {
        for (var single in item.itemSingle) {
          items.add(
            SaleReportItem(
              code: item.code,
              outlet: item.outlet.name,
              operator: item.operator.name,
              type: 'item_single',
              name: single.name,
              notes: single.notes ?? '',
              qty: single.qty,
              price: single.price,
              discount: single.discount,
              createdAt: item.createdAt,
            ),
          );
        }
      }

      if (item.itemPromo.isNotEmpty) {
        for (var promo in item.itemPromo) {
          items.add(
            SaleReportItem(
              code: item.code,
              outlet: item.outlet.name,
              operator: item.operator.name,
              type: 'item_promo',
              name: promo.name,
              notes: '',
              qty: 1,
              price: 0,
              discount: 0,
              createdAt: item.createdAt,
            ),
          );
        }
      }
    }

    for (var i = 0; i < items.length; i++) {
      var rowData = items[i];

      // tanggal
      sheetItem
          .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i + 1))
          .value = DateCellValue(
        year: rowData.createdAt.year,
        month: rowData.createdAt.month,
        day: rowData.createdAt.day,
      );

      //jam
      sheetItem
          .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: i + 1))
          .value = TimeCellValue(
        hour: rowData.createdAt.hour,
        minute: rowData.createdAt.minute,
        second: rowData.createdAt.second,
      );

      // kode_transaksi
      sheetItem
          .cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: i + 1))
          .value = TextCellValue(
        rowData.code,
      );

      // nama_gerai
      sheetItem
          .cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: i + 1))
          .value = TextCellValue(
        rowData.outlet,
      );

      // nama_operator
      sheetItem
          .cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: i + 1))
          .value = TextCellValue(
        rowData.operator,
      );

      // jenis_item
      sheetItem
          .cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: i + 1))
          .value = TextCellValue(
        rowData.type,
      );

      // nama_item
      sheetItem
          .cell(CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: i + 1))
          .value = TextCellValue(
        rowData.name,
      );

      // jumlah
      sheetItem
          .cell(CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: i + 1))
          .value = DoubleCellValue(
        rowData.qty,
      );

      // harga
      sheetItem
          .cell(CellIndex.indexByColumnRow(columnIndex: 8, rowIndex: i + 1))
          .value = DoubleCellValue(
        rowData.price,
      );

      // discount
      sheetItem
          .cell(CellIndex.indexByColumnRow(columnIndex: 9, rowIndex: i + 1))
          .value = DoubleCellValue(
        rowData.discount,
      );

      // catatan
      sheetItem
          .cell(CellIndex.indexByColumnRow(columnIndex: 10, rowIndex: i + 1))
          .value = TextCellValue(
        rowData.notes,
      );
    }

    excel.delete('Sheet1');

    List<int>? fileBytes = excel.encode();

    if (fileBytes == null) {
      customAlertDialog('Gagal membuat file');
      return;
    }

    // Dapatkan direktori temporer
    final directory = await getTemporaryDirectory();
    final filePath =
        '${directory.path}/laporan_penjualan_${outletData.currentOutletName.replaceAll(' ', '_')}_${DateFormat('yyyy-MM-dd').format(startDate.value)}_to_${DateFormat('yyyy-MM-dd').format(endDate.value)}.xlsx';

    // Tulis file ke path tersebut
    final file = File(filePath);
    await file.writeAsBytes(fileBytes);

    // --- Bagian Baru: Bagikan file menggunakan share_plus ---
    try {
      // Buat objek XFile dari path file
      final xfile = XFile(filePath);

      // Bagikan file
      final result = await Share.shareXFiles(
        [xfile],
        text:
            'Berikut adalah laporan data terbaru.', // Teks opsional yang akan ikut terkirim
      );

      await file.delete();

      switch (result.status) {
        case ShareResultStatus.success:
          successSnackbar('Laporan berhasil diunduh');
          break;
        case ShareResultStatus.dismissed:
          successSnackbar('Batal mengunduh laporan');
          break;
        default:
          successSnackbar('Laporan gagal diunduh');
      }
    } catch (e) {
      customAlertDialog('Gagal membagikan file: $e');
    }
  }
}

// List<String> itemHeader = [
//       'tanggal',
//       'jam',
//       'kode_transaksi',
//       'nama_gerai',
//       'nama_operator',
//       'jenis_item',
//       'nama_item',
//       'jumlah',
//       'harga',
//       'diskon',
//       'catatan',
//     ];

class SaleReportItem {
  final String code, outlet, operator, type, name, notes;
  final double qty, price, discount;
  final DateTime createdAt;

  SaleReportItem({
    required this.code,
    required this.outlet,
    required this.operator,
    required this.type,
    required this.name,
    required this.notes,
    required this.qty,
    required this.price,
    required this.discount,
    required this.createdAt,
  });
}
