import 'package:get/get.dart';

import '../constants/locale_keys.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'id_ID': {
          // General
          LocaleKeys.error : 'Terjadi Kesalahan',
          LocaleKeys.success : 'Berhasil',
          LocaleKeys.loading : 'Memuat...',
          LocaleKeys.sync_now: 'Sinkronisasi',
          
          // Auth / Login
          LocaleKeys.login_title : 'Masuk Kasir',
          LocaleKeys.login_subtitle : 'Masuk untuk mengelola kasir',
          LocaleKeys.email : 'Email',
          LocaleKeys.password : 'Kata Sandi',
          LocaleKeys.role: 'Peran / Jabatan',
          LocaleKeys.btn_login : 'MASUK',
          LocaleKeys.login_failed : 'Login Gagal',
          LocaleKeys.input_required : 'Email dan Password wajib diisi',

          // Home
          LocaleKeys.search_hint : 'Cari Produk...',
          LocaleKeys.cart_title: 'Keranjang',
          LocaleKeys.cart_empty: 'Keranjang Kosong',
          LocaleKeys.total: 'Total',
          LocaleKeys.btn_pay: 'BAYAR',
          LocaleKeys.hello: 'Halo',
          LocaleKeys.logout_confirm: 'Keluar Aplikasi?',
          
          // Transaction
          LocaleKeys.trx_saved: 'Transaksi disimpan (Offline)',
          LocaleKeys.sync_success : 'Data berhasil disinkronisasi',
        },
        'en_US': {
          // General
          'error': 'Error Occurred',
          'success': 'Success',
          'loading': 'Loading...',
          'sync_now': 'Sync Now',
          
          // Auth / Login
          'login_title': 'Cashier Login',
          'login_subtitle': 'Sign in to manage POS',
          'email': 'Email',
          'password': 'Password',
          'role': 'Role / Position',
          'btn_login': 'LOGIN',
          'login_failed': 'Login Failed',
          'input_required': 'Email and Password are required',

          // Home
          'search_hint': 'Search Product...',
          'cart_title': 'Cart',
          'cart_empty': 'Empty Cart',
          'total': 'Total',
          'btn_pay': 'PAY',
          'hello': 'Hello',
          'logout_confirm': 'Logout?',

          // Transaction
          'trx_saved': 'Transaction saved (Offline)',
          'sync_success': 'Data synced successfully',
        }
      };
}