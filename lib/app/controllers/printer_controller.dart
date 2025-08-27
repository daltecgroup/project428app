import 'dart:async';
import 'dart:convert';
import 'package:abg_pos_app/app/data/models/Sale.dart';
import 'package:abg_pos_app/app/shared/custom_alert.dart';
import 'package:abg_pos_app/app/utils/helpers/get_storage_helper.dart';
import 'package:abg_pos_app/app/utils/helpers/logger_helper.dart';
import 'package:abg_pos_app/app/utils/helpers/time_helper.dart';
import 'package:bluetooth_print_plus/bluetooth_print_plus.dart';
import 'package:flutter/material.dart' hide Alignment;
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import 'sale_data_controller.dart';

class PrinterController extends GetxController {
  BluetoothDevice? device;
  RxList<BluetoothDevice> scanResults = <BluetoothDevice>[].obs;
  RxBool isBlueOn = false.obs;

  final escCommand = EscCommand();

  late StreamSubscription<BlueState> _blueStateSubscription;

  @override
  void onInit() {
    super.onInit();
    if (BluetoothPrintPlus.isBlueOn) {
      isBlueOn.value = true;
    }
    _blueStateSubscription = BluetoothPrintPlus.blueState.listen((event) {
      LoggerHelper.logInfo('BLUESTATE CHANGE: $event');
      if (event == BlueState.blueOff) {
        isBlueOn.value = false;
      } else {
        isBlueOn.value = true;
      }
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    _blueStateSubscription.cancel();
    super.onClose();
  }

  Future<Uint8List?> escTemplateCmd(Sale saleData) async {
    await escCommand.cleanCommand();
    await escCommand.newline();
    await escCommand.text(
      content: 'LEKER LONDO',
      style: EscTextStyle.bold,
      alignment: Alignment.center,
    );
    await escCommand.newline();
    await escCommand.text(
      content: "--------------------------------",
      style: EscTextStyle.default_,
    );
    await escCommand.newline();
    await escCommand.text(
      content: saleData.code.toUpperCase(),
      style: EscTextStyle.bold,
      alignment: Alignment.center,
    );
    await escCommand.newline();
    await escCommand.text(
      content: localDateTimeFormat(saleData.createdAt).toUpperCase(),
      style: EscTextStyle.default_,
      alignment: Alignment.center,
    );
    await escCommand.newline();
    await escCommand.text(
      content: "--------------------------------",
      style: EscTextStyle.default_,
    );
    await escCommand.newline();
    await escCommand.text(
      content:
          'ITEM: ${saleData.itemCount}'.padRight(16, ' ') +
          'PROMO: ${saleData.itemPromo.length}'.padLeft(16, ' '),
    );
    await escCommand.newline();
    await escCommand.text(
      content: 'METODE: ${saleData.payment.method.toUpperCase()}',
    );
    await escCommand.newline();
    await escCommand.text(
      content: 'KASIR: ${saleData.operator.name.toUpperCase()}',
    );
    await escCommand.newline();

    await escCommand.newline();
    await escCommand.text(
      content: '${'ITEM'.padRight(21, ' ')}QTY${'JUMLAH'.padLeft(8, ' ')}',
      style: EscTextStyle.boldAndUnderline,
    );

    for (var single in saleData.itemSingle) {
      await escCommand.newline();
      await escCommand.text(
        content:
            '${single.name.padRight(21, ' ')}${'${single.qty.round()}'.padRight(3)}${'${(single.price * single.qty).round()}'.padLeft(8, ' ')}',
        style: EscTextStyle.default_,
      );
    }

    await escCommand.newline();
    await escCommand.newline();
    await escCommand.newline();
    await escCommand.text(content: 'TOTAL HARGA: ${saleData.totalPrice}');
    await escCommand.newline();
    await escCommand.text(content: 'JUMLAH BAYAR: ${saleData.totalPaid}');
    await escCommand.newline();
    await escCommand.text(content: 'KEMBALIAN: ${saleData.totalChange}');

    await escCommand.newline();
    await escCommand.newline();
    await escCommand.newline();
    await escCommand.text(
      content: 'Terima Kasih Telah Berbelanja',
      style: EscTextStyle.bold,
      alignment: Alignment.center,
    );
    await escCommand.print(feedLines: 5);
    final cmd = await escCommand.getCommand();
    return cmd;
  }

  void clearPrinter() {
    box.removeValue('printerName');
    box.removeValue('printerAddress');
  }

  Future<void> startPrinting(
    Sale sale, {
    SaleDataController? data,
    String? id,
  }) async {
    await Permission.camera.request();
    if (isBlueOn.isFalse) {
      customAlertDialog('Nyalakan bluetooth untuk menggunakan printer');
    } else {
      if (box.getValue('printerName') != null &&
          box.getValue('printerAddress') != null) {
        device = BluetoothDevice(
          box.getValue('printerName'),
          box.getValue('printerAddress'),
        );

        if (BluetoothPrintPlus.isConnected) {
          BluetoothPrintPlus.write(await escTemplateCmd(sale));
          if (data != null && id != null) {
            await data.updateSale(
              id: id,
              data: json.encode({"addInvoicePrintHistory": true}),
            );
            data.sales.refresh();
            data.selectedSale.refresh();
          }
          clearPrinter();
        } else {
          BluetoothPrintPlus.connect(device!).then((value) async {
            BluetoothPrintPlus.write(await escTemplateCmd(sale));
          });
        }
      } else {
        scanPrinter(sale);
      }
    }
  }

  Future<void> scanPrinter(Sale sale) async {
    scanResults.clear();
    BluetoothPrintPlus.startScan(timeout: Duration(seconds: 10));
    Get.defaultDialog(
      title: 'Pilih Printer',
      titleStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
      radius: 10,
      content: StreamBuilder(
        stream: BluetoothPrintPlus.scanResults,
        builder: (context, snapshot) {
          print(snapshot.connectionState);
          if (snapshot.connectionState == ConnectionState.active &&
              snapshot.data != null) {
            return Column(
              children: [
                if (snapshot.connectionState == ConnectionState.waiting &&
                    snapshot.data!.isEmpty)
                  Text('Sedang mencari perangkat...'),
                if (snapshot.data!.isNotEmpty)
                  ...List.generate(
                    snapshot.data!.length,
                    (index) => snapshot.data![index].type == 3
                        ? ListTile(
                            leading: Icon(Icons.print_rounded),
                            title: Text(
                              snapshot.data![index].name,
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            subtitle: Text(
                              snapshot.data![index].address,
                              style: TextStyle(fontSize: 12),
                            ),
                            onTap: () async {
                              await BluetoothPrintPlus.stopScan();
                              box.setValue(
                                'printerName',
                                snapshot.data![index].name,
                              );
                              box.setValue(
                                'printerAddress',
                                snapshot.data![index].address,
                              );
                              startPrinting(sale);
                              Get.back();
                            },
                          )
                        : SizedBox(),
                  ),
              ],
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
