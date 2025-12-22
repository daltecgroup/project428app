import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class NotificationService extends GetxService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Inisialisasi
  Future<void> init() async {
    // Setting Icon untuk Android (pastikan file ic_launcher ada di folder mipmap, defaultnya sudah ada)
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // Setting untuk iOS
    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      requestAlertPermission: false, // Kita request manual nanti
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  // Fungsi Request Izin (Penting untuk Android 13+)
  Future<void> requestPermissions() async {
    if (Platform.isIOS) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    } else if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();

      await androidImplementation?.requestNotificationsPermission();
    }
  }

  // Detail Tampilan Notifikasi
  NotificationDetails _notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'channel_id_1', 
        'Nama Channel',
        channelDescription: 'Deskripsi Channel',
        importance: Importance.max,
        priority: Priority.max,
        ticker: 'ticker',
        icon: 
        '@mipmap/ic_launcher',
      ),
      iOS: DarwinNotificationDetails(),
    );
  }

  // 1. Tampilkan Langsung (Test)
  Future<void> showInstantNotification(String title, String body) async {
    await flutterLocalNotificationsPlugin.show(
      0, // ID Unik
      title,
      body,
      _notificationDetails(),
    );
  }

  // 2. Tampilkan Berkala (Setiap Menit) - TANPA TIMEZONE
  Future<void> schedulePeriodicNotification() async {
    await flutterLocalNotificationsPlugin.periodicallyShow(
      1, // ID Harus beda dari yang instant
      'Pengingat Rutin',
      'Halo, sudah 1 menit berlalu!',
      RepeatInterval.everyMinute, // Pilihan: everyMinute, hourly, daily, weekly
      _notificationDetails(),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
    );
  }

  // Stop Notifikasi
  Future<void> cancelAll() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}