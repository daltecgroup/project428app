import 'package:get/get.dart';

import '../middlewares/auth_guard_middleware.dart';
import '../modules/absensi_operator/bindings/absensi_operator_binding.dart';
import '../modules/absensi_operator/views/absensi_operator_view.dart';
import '../modules/aktivitas_admin/bindings/aktivitas_admin_binding.dart';
import '../modules/aktivitas_admin/views/aktivitas_admin_view.dart';
import '../modules/aktivitas_operator/bindings/aktivitas_operator_binding.dart';
import '../modules/aktivitas_operator/views/aktivitas_operator_view.dart';
import '../modules/beranda_admin/bindings/beranda_admin_binding.dart';
import '../modules/beranda_admin/views/beranda_admin_view.dart';
import '../modules/beranda_operator/bindings/beranda_operator_binding.dart';
import '../modules/beranda_operator/views/beranda_operator_view.dart';
import '../modules/detail_stok/bindings/detail_stok_binding.dart';
import '../modules/detail_stok/views/detail_stok_view.dart';
import '../modules/gerai/bindings/gerai_binding.dart';
import '../modules/gerai/views/gerai_view.dart';
import '../modules/homepage_franchisee/bindings/homepage_franchisee_binding.dart';
import '../modules/homepage_franchisee/views/homepage_franchisee_view.dart';
import '../modules/homepage_spvarea/bindings/homepage_spvarea_binding.dart';
import '../modules/homepage_spvarea/views/homepage_spvarea_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/login_as/bindings/login_as_binding.dart';
import '../modules/login_as/views/login_as_view.dart';
import '../modules/notifications/bindings/notifications_binding.dart';
import '../modules/notifications/views/notifications_view.dart';
import '../modules/operator/bindings/operator_binding.dart';
import '../modules/operator/views/operator_view.dart';
import '../modules/pengaturan_admin/bindings/pengaturan_admin_binding.dart';
import '../modules/pengaturan_admin/views/pengaturan_admin_view.dart';
import '../modules/produk/bindings/produk_binding.dart';
import '../modules/produk/views/produk_view.dart';
import '../modules/promo/bindings/promo_binding.dart';
import '../modules/promo/views/promo_view.dart';
import '../modules/sales_transaction_detail/bindings/sales_transaction_detail_binding.dart';
import '../modules/sales_transaction_detail/views/sales_transaction_detail_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/stok/bindings/stok_binding.dart';
import '../modules/stok/views/stok_view.dart';
import '../modules/stok_operator/bindings/stok_operator_binding.dart';
import '../modules/stok_operator/views/stok_operator_view.dart';
import '../modules/tambah_pengguna/bindings/user_add_binding.dart';
import '../modules/tambah_pengguna/views/user_add_view.dart';
import '../modules/tambah_stok/bindings/tambah_stok_binding.dart';
import '../modules/tambah_stok/views/tambah_stok_view.dart';
import '../modules/transaksi_operator/bindings/transaksi_operator_binding.dart';
import '../modules/transaksi_operator/views/transaksi_operator_view.dart';
import '../modules/ubah_pengguna/bindings/ubah_pengguna_binding.dart';
import '../modules/ubah_pengguna/views/ubah_pengguna_view.dart';
import '../modules/unauthorized/bindings/unauthorized_binding.dart';
import '../modules/unauthorized/views/unauthorized_view.dart';
import '../modules/user/bindings/user_binding.dart';
import '../modules/user/views/user_view.dart';
import '../modules/user_detail/bindings/user_detail_binding.dart';
import '../modules/user_detail/views/user_detail_view.dart';
import '../modules/user_update/bindings/user_update_binding.dart';
import '../modules/user_update/views/user_update_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 400),
    ),
    GetPage(
      name: _Paths.LOGIN_AS,
      page: () => const LoginAsView(),
      binding: LoginAsBinding(),
      middlewares: [
        AuthGuardMiddleware(), // Protects this route, requires login
      ],
    ),
    GetPage(
      name: _Paths.BERANDA_ADMIN,
      page: () => const BerandaAdminView(),
      binding: BerandaAdminBinding(),
      middlewares: [
        AuthGuardMiddleware(
          requiredRoles: ['admin'],
        ), // Protects this route, requires login
      ],
    ),
    GetPage(
      name: _Paths.USER,
      page: () => const UserView(),
      binding: UserBinding(),
      transition: Transition.native,
    ),
    GetPage(
      name: _Paths.USER_ADD,
      page: () => const UserAddView(),
      binding: TambahPenggunaBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: _Paths.NOTIFICATIONS,
      page: () => const NotificationsView(),
      binding: NotificationsBinding(),
    ),
    GetPage(
      name: _Paths.USER_DETAIL,
      page: () => const UserDetailView(),
      binding: UserDetailBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: _Paths.GERAI,
      page: () => const GeraiView(),
      binding: GeraiBinding(),
    ),
    GetPage(
      name: _Paths.OPERATOR,
      page: () => const OperatorView(),
      binding: OperatorBinding(),
    ),
    GetPage(
      name: _Paths.STOK,
      page: () => const StokView(),
      binding: StokBinding(),
      transition: Transition.native,
    ),
    GetPage(
      name: _Paths.PRODUK,
      page: () => const ProdukView(),
      binding: ProdukBinding(),
    ),
    GetPage(
      name: _Paths.PROMO,
      page: () => const PromoView(),
      binding: PromoBinding(),
      transition: Transition.native,
    ),
    GetPage(
      name: _Paths.BERANDA_OPERATOR,
      page: () => const BerandaOperatorView(),
      binding: BerandaOperatorBinding(),
    ),
    GetPage(
      name: _Paths.TRANSAKSI_OPERATOR,
      page: () => const TransaksiOperatorView(),
      binding: TransaksiOperatorBinding(),
    ),
    GetPage(
      name: _Paths.ABSENSI_OPERATOR,
      page: () => const AbsensiOperatorView(),
      binding: AbsensiOperatorBinding(),
    ),
    GetPage(
      name: _Paths.STOK_OPERATOR,
      page: () => const StokOperatorView(),
      binding: StokOperatorBinding(),
    ),
    GetPage(
      name: _Paths.AKTIVITAS_OPERATOR,
      page: () => const AktivitasOperatorView(),
      binding: AktivitasOperatorBinding(),
    ),
    GetPage(
      name: _Paths.UBAH_PENGGUNA,
      page: () => const UbahPenggunaView(),
      binding: UbahPenggunaBinding(),
    ),
    GetPage(
      name: _Paths.AKTIVITAS_ADMIN,
      page: () => const AktivitasAdminView(),
      binding: AktivitasAdminBinding(),
    ),
    GetPage(
      name: _Paths.PENGATURAN_ADMIN,
      page: () => PengaturanAdminView(),
      binding: PengaturanAdminBinding(),
    ),
    GetPage(
      name: _Paths.TAMBAH_STOK,
      page: () => const TambahStokView(),
      binding: TambahStokBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_STOK,
      page: () => const DetailStokView(),
      binding: DetailStokBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.UNAUTHORIZED,
      page: () => const UnauthorizedView(),
      binding: UnauthorizedBinding(),
    ),
    GetPage(
      name: _Paths.HOMEPAGE_FRANCHISEE,
      page: () => const HomepageFranchiseeView(),
      binding: HomepageFranchiseeBinding(),
    ),
    GetPage(
      name: _Paths.HOMEPAGE_SPVAREA,
      page: () => const HomepageSpvareaView(),
      binding: HomepageSpvareaBinding(),
    ),
    GetPage(
      name: _Paths.SALES_TRANSACTION_DETAIL,
      page: () => const SalesTransactionDetailView(),
      binding: SalesTransactionDetailBinding(),
    ),
    GetPage(
      name: _Paths.USER_UPDATE,
      page: () => const UserUpdateView(),
      binding: UserUpdateBinding(),
    ),
  ];
}
