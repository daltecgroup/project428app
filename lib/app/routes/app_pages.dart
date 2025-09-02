import 'package:flutter/widgets.dart';

import 'package:get/get.dart';

import '../middlewares/auth_middleware.dart';
import '../modules/_core/auth/bindings/auth_binding.dart';
import '../modules/_core/auth/views/auth_view.dart';
import '../modules/_core/select_ingredient/bindings/select_ingredient_binding.dart';
import '../modules/_core/select_ingredient/views/select_ingredient_view.dart';
import '../modules/_core/select_menu_category/bindings/select_menu_category_binding.dart';
import '../modules/_core/select_menu_category/views/select_menu_category_view.dart';
import '../modules/_core/select_outlet/bindings/select_outlet_binding.dart';
import '../modules/_core/select_outlet/views/select_outlet_view.dart';
import '../modules/_core/select_role/bindings/select_role_binding.dart';
import '../modules/_core/select_role/views/select_role_view.dart';
import '../modules/_core/setting/bindings/setting_binding.dart';
import '../modules/_core/setting/views/setting_view.dart';
import '../modules/_core/splash/bindings/splash_binding.dart';
import '../modules/_core/splash/views/splash_view.dart';
import '../modules/_features/attendance/bindings/attendance_binding.dart';
import '../modules/_features/attendance/views/attendance_view.dart';
import '../modules/_features/notification/bindings/notification_binding.dart';
import '../modules/_features/notification/views/notification_view.dart';
import '../modules/_features/order/bindings/order_binding.dart';
import '../modules/_features/order/views/order_detail_view.dart';
import '../modules/_features/order/views/order_input_view.dart';
import '../modules/_features/order/views/order_list_view.dart';
import '../modules/_features/outlet/bindings/outlet_binding.dart';
import '../modules/_features/outlet/views/outlet_detail_view.dart';
import '../modules/_features/outlet/views/outlet_input_view.dart';
import '../modules/_features/outlet/views/outlet_list_view.dart';
import '../modules/_features/outlet_inventory/bindings/outlet_inventory_binding.dart';
import '../modules/_features/outlet_inventory/views/outlet_inventory_view.dart';
import '../modules/_features/outlet_inventory_adjustment/bindings/outlet_inventory_adjustment_binding.dart';
import '../modules/_features/outlet_inventory_adjustment/views/outlet_inventory_adjustment_view.dart';
import '../modules/_features/outlet_inventory_history/bindings/outlet_inventory_history_binding.dart';
import '../modules/_features/outlet_inventory_history/views/outlet_inventory_history_view.dart';
import '../modules/_features/outlet_inventory_list/bindings/outlet_inventory_list_binding.dart';
import '../modules/_features/outlet_inventory_list/views/outlet_inventory_list_view.dart';
import '../modules/_features/outlet_order_list/bindings/outlet_order_list_binding.dart';
import '../modules/_features/outlet_order_list/views/outlet_order_list_view.dart';
import '../modules/_features/outlet_sale_list/bindings/outlet_sale_list_binding.dart';
import '../modules/_features/outlet_sale_list/views/outlet_sale_list_view.dart';
import '../modules/_features/report/bindings/report_binding.dart';
import '../modules/_features/report/views/report_view.dart';
import '../modules/_features/sale_input/bindings/sale_input_binding.dart';
import '../modules/_features/sale_input/views/sale_input_view.dart';
import '../modules/_features/select_bundle/bindings/select_bundle_binding.dart';
import '../modules/_features/select_bundle/views/select_bundle_view.dart';
import '../modules/_features/select_menu/bindings/select_menu_binding.dart';
import '../modules/_features/select_menu/views/select_menu_view.dart';
import '../modules/_features/select_sale_item/bindings/select_sale_item_binding.dart';
import '../modules/_features/select_sale_item/views/select_sale_item_view.dart';
import '../modules/admin/addon/bindings/addon_binding.dart';
import '../modules/admin/addon/views/addon_detail_view.dart';
import '../modules/admin/addon/views/addon_input_view.dart';
import '../modules/admin/addon/views/addon_list_view.dart';
import '../modules/admin/admin_dashboard/bindings/admin_dashboard_binding.dart';
import '../modules/admin/admin_dashboard/views/admin_dashboard_view.dart';
import '../modules/admin/ingredients/bindings/ingredients_binding.dart';
import '../modules/admin/ingredients/views/ingredient_detail_view.dart';
import '../modules/admin/ingredients/views/ingredient_input_view.dart';
import '../modules/admin/ingredients/views/ingredient_list_view.dart';
import '../modules/admin/menu/bindings/menu_binding.dart';
import '../modules/admin/menu/views/menu_detail_view.dart';
import '../modules/admin/menu/views/menu_input_view.dart';
import '../modules/admin/menu/views/menu_list_view.dart';
import '../modules/admin/menu_category/bindings/menu_category_binding.dart';
import '../modules/admin/menu_category/views/menu_category_input_view.dart';
import '../modules/admin/menu_category/views/menu_category_list_view.dart';
import '../modules/admin/product/bindings/product_binding.dart';
import '../modules/admin/product/views/product_view.dart';
import '../modules/admin/profile/bindings/profile_binding.dart';
import '../modules/admin/profile/views/profile_view.dart';
import '../modules/admin/promo/bindings/promo_binding.dart';
import '../modules/admin/promo/views/bundle_detail_view.dart';
import '../modules/admin/promo/views/bundle_input_view.dart';
import '../modules/admin/promo/views/bundle_list_view.dart';
import '../modules/admin/promo/views/buy_get_promo_view.dart';
import '../modules/admin/promo/views/promo_view.dart';
import '../modules/admin/promo/views/spend_get_promo_view.dart';
import '../modules/admin/user/bindings/add_user_binding.dart';
import '../modules/admin/user/bindings/edit_user_binding.dart';
import '../modules/admin/user/bindings/user_detail_binding.dart';
import '../modules/admin/user/bindings/user_list_binding.dart';
import '../modules/admin/user/views/add_user_view.dart';
import '../modules/admin/user/views/edit_user_view.dart';
import '../modules/admin/user/views/user_detail_view.dart';
import '../modules/admin/user/views/user_list_view.dart';
import '../modules/franchisee/franchisee_dashboard/bindings/franchisee_dashboard_binding.dart';
import '../modules/franchisee/franchisee_dashboard/views/franchisee_dashboard_view.dart';
import '../modules/_features/ingredient_purchase_input/bindings/ingredient_purchase_input_binding.dart';
import '../modules/_features/ingredient_purchase_input/views/ingredient_purchase_input_view.dart';
import '../modules/operator/operator_attendance/bindings/operator_attendance_binding.dart';
import '../modules/operator/operator_attendance/views/operator_attendance_view.dart';
import '../modules/operator/operator_dashboard/bindings/operator_dashboard_binding.dart';
import '../modules/operator/operator_dashboard/views/operator_dashboard_view.dart';
import '../modules/operator/operator_order_list/bindings/operator_order_list_binding.dart';
import '../modules/operator/operator_order_list/views/operator_order_list_view.dart';
import '../modules/operator/operator_outlet_inventory/bindings/operator_outlet_inventory_binding.dart';
import '../modules/operator/operator_outlet_inventory/views/operator_outlet_inventory_view.dart';
import '../modules/operator/operator_sale/bindings/operator_sale_binding.dart';
import '../modules/operator/operator_sale/views/operator_sale_view.dart';
import '../modules/operator/operator_sale_detail/bindings/operator_sale_detail_binding.dart';
import '../modules/operator/operator_sale_detail/views/operator_sale_detail_view.dart';
import '../modules/operator/sale/bindings/sale_binding.dart';
import '../modules/operator/sale/views/sale_view.dart';
import '../modules/_features/outlet_menu_pricing/bindings/outlet_menu_pricing_binding.dart';
import '../modules/_features/outlet_menu_pricing/views/outlet_menu_pricing_view.dart';
import '../modules/spvarea/spvarea_dashboard/bindings/spvarea_dashboard_binding.dart';
import '../modules/spvarea/spvarea_dashboard/views/spvarea_dashboard_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.PROFILE,
      page: () => SafeArea(child: const ProfileView()),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.AUTH,
      page: () => const AuthView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.SELECT_ROLE,
      page: () => const SelectRoleView(),
      binding: SelectRoleBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_DASHBOARD,
      page: () => const AdminDashboardView(),
      binding: AdminDashboardBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: _Paths.FRANCHISEE_DASHBOARD,
      page: () => const FranchiseeDashboardView(),
      binding: FranchiseeDashboardBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: _Paths.SPVAREA_DASHBOARD,
      page: () => const SpvareaDashboardView(),
      binding: SpvareaDashboardBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: _Paths.OPERATOR_DASHBOARD,
      page: () => const OperatorDashboardView(),
      binding: OperatorDashboardBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: _Paths.NOTIFICATION,
      page: () => const NotificationView(),
      binding: NotificationBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: _Paths.OUTLET_LIST,
      page: () => const OutletListView(),
      binding: OutletBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: _Paths.OUTLET_DETAIL,
      page: () => const OutletDetailView(),
      binding: OutletBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: _Paths.OUTLET_INPUT,
      page: () => const OutletInputView(),
      binding: OutletBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: _Paths.USER_LIST,
      page: () => const UserListView(),
      binding: UserListBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: _Paths.USER_DETAIL,
      page: () => const UserDetailView(),
      binding: UserDetailBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: _Paths.ADD_USER,
      page: () => const AddUserView(),
      binding: AddUserBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: _Paths.EDIT_USER,
      page: () => const EditUserView(),
      binding: EditUserBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: _Paths.SETTING,
      page: () => const SettingView(),
      binding: SettingBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCT,
      page: () => const ProductView(),
      binding: ProductBinding(),
    ),
    GetPage(
      name: _Paths.ORDER_LIST,
      page: () => const OrderListView(),
      binding: OrderBinding(),
    ),
    GetPage(
      name: _Paths.ORDER_INPUT,
      page: () => const OrderInputView(),
      binding: OrderBinding(),
    ),
    GetPage(
      name: _Paths.ORDER_DETAIL,
      page: () => const OrderDetailView(),
      binding: OrderBinding(),
    ),
    GetPage(
      name: _Paths.REPORT,
      page: () => const ReportView(),
      binding: ReportBinding(),
    ),
    GetPage(
      name: _Paths.ATTENDANCE,
      page: () => const AttendanceView(),
      binding: AttendanceBinding(),
    ),
    GetPage(
      name: _Paths.MENU_LIST,
      page: () => const MenuListView(),
      binding: MenuBinding(),
    ),
    GetPage(
      name: _Paths.MENU_DETAIL,
      page: () => const MenuDetailView(),
      binding: MenuBinding(),
    ),
    GetPage(
      name: _Paths.MENU_INPUT,
      page: () => const MenuInputView(),
      binding: MenuBinding(),
    ),
    GetPage(
      name: _Paths.MENU_CATEGORY_LIST,
      page: () => const MenuCategoryListView(),
      binding: MenuCategoryBinding(),
    ),
    GetPage(
      name: _Paths.MENU_CATEGORY_INPUT,
      page: () => const MenuCategoryInputView(),
      binding: MenuCategoryBinding(),
    ),
    GetPage(
      name: _Paths.INGREDIENT_LIST,
      page: () => const IngredientsListView(),
      binding: IngredientsBinding(),
    ),
    GetPage(
      name: _Paths.INGREDIENT_DETAIL,
      page: () => const IngredientDetailView(),
      binding: IngredientsBinding(),
    ),
    GetPage(
      name: _Paths.INGREDIENT_INPUT,
      page: () => const IngredientInputView(),
      binding: IngredientsBinding(),
    ),
    GetPage(
      name: _Paths.ADDON_LIST,
      page: () => const AddonListView(),
      binding: AddonBinding(),
    ),
    GetPage(
      name: _Paths.ADDON_DETAIL,
      page: () => const AddonDetailView(),
      binding: AddonBinding(),
    ),
    GetPage(
      name: _Paths.ADDON_INPUT,
      page: () => const AddonInputView(),
      binding: AddonBinding(),
    ),
    GetPage(
      name: _Paths.PROMO,
      page: () => const PromoView(),
      binding: PromoBinding(),
    ),
    GetPage(
      name: _Paths.BUNDLE_LIST,
      page: () => const BundleListView(),
      binding: PromoBinding(),
    ),
    GetPage(
      name: _Paths.BUNDLE_INPUT,
      page: () => const BundleInputView(),
      binding: PromoBinding(),
    ),
    GetPage(
      name: _Paths.BUNDLE_DETAIL,
      page: () => const BundleDetailView(),
      binding: PromoBinding(),
    ),
    GetPage(
      name: _Paths.BUY_GET_PROMO,
      page: () => const BuyGetPromoView(),
      binding: PromoBinding(),
    ),
    GetPage(
      name: _Paths.SPEND_GET_PROMO,
      page: () => const SpendGetPromoView(),
      binding: PromoBinding(),
    ),
    GetPage(
      name: _Paths.SELECT_INGREDIENT,
      page: () => const SelectIngredientView(),
      binding: SelectIngredientBinding(),
    ),
    GetPage(
      name: _Paths.SELECT_OUTLET,
      page: () => const SelectOutletView(),
      binding: SelectOutletBinding(),
    ),
    GetPage(
      name: _Paths.SELECT_MENU_CATEGORY,
      page: () => const SelectMenuCategoryView(),
      binding: SelectMenuCategoryBinding(),
    ),
    GetPage(
      name: _Paths.SALE,
      page: () => const SaleView(),
      binding: SaleBinding(),
    ),
    GetPage(
      name: _Paths.OPERATOR_SALE,
      page: () => const OperatorSaleView(),
      binding: OperatorSaleBinding(),
    ),
    GetPage(
      name: _Paths.OUTLET_ORDER_LIST,
      page: () => const OutletOrderListView(),
      binding: OutletOrderListBinding(),
    ),
    GetPage(
      name: _Paths.OPERATOR_ORDER_LIST,
      page: () => const OperatorOrderListView(),
      binding: OperatorOrderListBinding(),
    ),
    GetPage(
      name: _Paths.OPERATOR_ATTENDANCE,
      page: () => const OperatorAttendanceView(),
      binding: OperatorAttendanceBinding(),
    ),
    GetPage(
      name: _Paths.SELECT_SALE_ITEM,
      page: () => const SelectSaleItemView(),
      binding: SelectSaleItemBinding(),
    ),
    GetPage(
      name: _Paths.SALE_INPUT,
      page: () => const SaleInputView(),
      binding: SaleInputBinding(),
    ),
    GetPage(
      name: _Paths.SELECT_MENU,
      page: () => const SelectMenuView(),
      binding: SelectMenuBinding(),
    ),
    GetPage(
      name: _Paths.SELECT_BUNDLE,
      page: () => const SelectBundleView(),
      binding: SelectBundleBinding(),
    ),
    GetPage(
      name: _Paths.OPERATOR_SALE_DETAIL,
      page: () => const OperatorSaleDetailView(),
      binding: OperatorSaleDetailBinding(),
    ),
    GetPage(
      name: _Paths.OUTLET_SALE_LIST,
      page: () => const OutletSaleListView(),
      binding: OutletSaleListBinding(),
    ),
    GetPage(
      name: _Paths.OUTLET_INVENTORY,
      page: () => const OutletInventoryView(),
      binding: OutletInventoryBinding(),
    ),
    GetPage(
      name: _Paths.OPERATOR_OUTLET_INVENTORY,
      page: () => const OperatorOutletInventoryView(),
      binding: OperatorOutletInventoryBinding(),
    ),
    GetPage(
      name: _Paths.OUTLET_INVENTORY_LIST,
      page: () => const OutletInventoryListView(),
      binding: OutletInventoryListBinding(),
    ),
    GetPage(
      name: _Paths.OUTLET_INVENTORY_ADJUSTMENT,
      page: () => const OutletInventoryAdjustmentView(),
      binding: OutletInventoryAdjustmentBinding(),
    ),
    GetPage(
      name: _Paths.INGREDIENT_PURCHASE_INPUT,
      page: () => const IngredientPurchaseInputView(),
      binding: IngredientPurchaseInputBinding(),
    ),
    GetPage(
      name: _Paths.OUTLET_INVENTORY_HISTORY,
      page: () => const OutletInventoryHistoryView(),
      binding: OutletInventoryHistoryBinding(),
    ),
    GetPage(
      name: _Paths.OUTLET_MENU_PRICING,
      page: () => const OutletMenuPricingView(),
      binding: OutletMenuPricingBinding(),
    ),
  ];
}
