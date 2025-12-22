class AppConstants {
  // --- Development/Production
  static const String ENV_DEV = 'development';
  static const String ENV_PROD = 'production';
  static const String ENVIRONMENT_SETTING = ENV_DEV;

  // --- Application Information ---
  static const String APP_NAME = 'BATMANPOS';
  static const String APP_TITLE = 'Batman POS';
  static const String APP_VERSION_PROD = '1.0.12';
  static const String APP_VERSION_DEV = 'V1.0.12 build 31 | ClOSED TESTING';
  static const String APP_BUILD_NUMBER = '31';
  static const String APP_VERSION = ENVIRONMENT_SETTING == ENV_PROD
      ? APP_VERSION_PROD
      : APP_VERSION_DEV;
  static const String APP_DESCRIPTION =
      'Aplikasi POS untuk Aroma Bisnis Group.';
  static const String SUPPORT_EMAIL = 'support@aromabisnisgroup.com';
  static const String WEBSITE_URL = 'https://www.aromabisnisgroup.com';

  // --- API Configuration ---
  static const String BASE_API_URL_DEV = 'http://10.0.2.2:8000/api/v1';
  static const String BASE_API_URL_DEV_IMAGE = 'http://10.0.2.2:8000';
  static const String BASE_API_URL_PROD =
      'http://gg8ko0kg00oo00sscwoosk4w.46.202.163.60.sslip.io/api/v1';
  static const String BASE_API_URL_PROD_IMAGE =
      'http://gg8ko0kg00oo00sscwoosk4w.46.202.163.60.sslip.io';

  static const String CURRENT_BASE_API_URL = ENVIRONMENT_SETTING == ENV_PROD
      ? BASE_API_URL_PROD
      : BASE_API_URL_DEV;
  static const String CURRENT_BASE_API_URL_IMAGE =
      ENVIRONMENT_SETTING == ENV_PROD
      ? BASE_API_URL_PROD_IMAGE
      : BASE_API_URL_DEV_IMAGE;

  static const int API_TIMEOUT_SECONDS = 30; // Global API request timeout
  static const int SYNC_TIMER = 3600;
  static const bool RUN_SYNC_TIMER = ENVIRONMENT_SETTING == ENV_PROD
      ? true
      : false;

  // --- Shared Preferences Keys ---
  static const String KEY_IS_LOGGED_IN = 'is_logged_in';
  static const String KEY_USER_TOKEN = 'user_token';
  static const String KEY_CURRENT_USER_DATA = 'current_user_data';
  static const String KEY_CURRENT_ROLE = 'current_role';
  static const String KEY_CURRENT_OUTLET = 'current_outlet';
  static const String KEY_APP_LANGUAGE = 'app_language';
  static const String KEY_THEME_MODE = 'theme_mode';
  static const String KEY_REMEMBER_ME_ID = 'remember_me_id';
  static const String KEY_REMEMBER_ME_PASSWORD = 'remember_me_password';
  static const String KEY_CURRENT_ROUTE = 'current_route';
  static const String KEY_USER_DATA_LATEST = 'user_data_latest_update';
  static const String KEY_INGREDIENT_DATA_LATEST =
      'ingredient_data_latest_update';
  static const String KEY_MENU_CATEOGORY_LATEST = 'menu_category_latest_update';
  static const String KEY_ADDON_LATEST = 'addon_latest_update';
  static const String KEY_REQUEST_LATEST = 'request_latest_update';
  static const String KEY_SALE_LATEST = 'sale_latest_update';
  static const String KEY_OIT_LATEST = 'oit_latest_update';
  static const String KEY_MENU_LATEST = 'menu_latest_update';
  static const String KEY_OUTLET_LATEST = 'outlet_latest_update';
  static const String KEY_OUTLET_INVENTORY_LATEST =
      'outlet_inventory_latest_update';
  static const String KEY_PROMO_SETTING_LATEST = 'promo_setting_latest_update';
  static const String KEY_ORDER_LATEST = 'order_latest_update';
  static const String KEY_BUNDLE_LATEST = 'bundle_latest_update';
  static const String KEY_ADMIN_NOTIFICATION_LATEST = 'admin_notification_latest_update';

  // --- File name ---
  static const String FILENAME_USER_DATA = 'abg_pos_local_user_data.json';
  static const String FILENAME_INGREDIENT_DATA =
      'abg_pos_local_ingredient_data.json';
  static const String FILENAME_MENU_CATEGORY_DATA =
      'abg_pos_local_menu_category_data.json';
  static const String FILENAME_ADDON_DATA = 'abg_pos_local_addon_data.json';
  static const String FILENAME_REQUEST_DATA = 'abg_pos_local_request_data.json';
  static const String FILENAME_SALE_DATA = 'abg_pos_local_sale_data.json';
  static const String FILENAME_MENU_DATA = 'abg_pos_local_menu_data.json';
  static const String FILENAME_OUTLET_DATA = 'abg_pos_local_outlet_data.json';
  static const String FILENAME_OUTLET_INVENTORY_DATA =
      '_abg_pos_local_outlet_inventory_data.json';
  static const String FILENAME_OUTLET_INVENTORY_TRANSACTION_DATA =
      '_abg_pos_local_outlet_inventory_transaction_data.json';
  static const String FILENAME_PROMO_SETTING_DATA =
      'abg_pos_local_promo_setting_data.json';
  static const String FILENAME_ORDER_DATA = 'abg_pos_local_order_data.json';
  static const String FILENAME_BUNDLE_DATA = 'abg_pos_local_bundle_data.json';
  static const String FILENAME_ADMIN_NOTIFICATION_DATA = 'abg_pos_local_admin_notification_data.json';
  static const String FILENAME_USER_OUTLET_DATA =
      'abg_pos_local_user_outlet_data.json';

  // --- Hero tag ---
  static const String HERO_AUTH_CARD = 'auth_card_hero'; // Unused

  // --- User roles
  static const String ROLE_ADMIN = 'admin';
  static const String ROLE_FRANCHISEE = 'franchisee';
  static const String ROLE_SPVAREA = 'spvarea';
  static const String ROLE_OPERATOR = 'operator';

  // --- Promo Setting ---
  static const String PROMO_SETTING_BUY_GET = 'promo_buy_get'; // Unused
  static const String PROMO_SETTING_SPEND_GET = 'promo_spend_get'; // Unused

  // --- Routing and Navigation ---
  static const Duration ROUTE_TRANSITION_DURATION = Duration(
    milliseconds: 300,
  ); // Unused

  // --- UI Constants ---
  static const double DEFAULT_PADDING = 16.0;
  static const double DEFAULT_BORDER_RADIUS = 8.0;
  static const double DEFAULT_VERTICAL_MARGIN = 12.0;
  static const double DEFAULT_HORIZONTAL_MARGIN = 12.0;
  static const double DEFAULT_ICON_SIZE = 24.0;
  static const double DEFAULT_NAV_ICON_SIZE = 18.0; // Unused
  static const double DEFAULT_FONT_SIZE = 16.0;

  // --- Regex Patterns ---
  static const String EMAIL_REGEX =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  static const int MIN_PASSWORD_LENGTH = 8;
  static const int MIN_USERNAME_LENGTH = 3;

  // --- Default Values ---
  static const String DEFAULT_LANGUAGE_CODE = 'en';
  static const String DEFAULT_CURRENCY_SYMBOL = 'Rp'; // Indonesian Rupiah
  static const String DEFAULT_COUNTRY_CODE = '+62'; // Indonesia

  // --- Payment method ---
  static const String PAYMENT_CASH = 'cash';
  static const String PAYMENT_TRANSFER = 'transfer';
  static const String PAYMENT_QRIS = 'qris';

  // --- Asset Paths (Examples) ---
  static const String IMG_LOGO = 'assets/images/logo_small.png';
  static const String IMG_LOGO_BW = 'assets/images/batmanpos_bw.png'; // Unused
  static const String IMG_PLACEHOLDER =
      'assets/svg/img-placeholder.svg'; // Unused
  static const String PROFILE_PLACEHOLDER =
      'assets/svg/profile-placeholder.svg'; // Unused
  static const String PROFILE_PLACEHOLDER_PNG =
      'assets/png/profile-placeholder.png'; // Unused

  // static const String IMG_PLACEHOLDER = 'assets/images/placeholder.png';
  static const String FONT_PRIMARY =
      'Poppins'; // Name of font family defined in pubspec.yaml

  // --- Messages and Strings (often handled by localization, but some static ones might be here) ---
  static const String ERROR_GENERIC =
      'Something went wrong. Please try again later.'; // Unused
  static const String SUCCESS_GENERIC =
      'Operation completed successfully.'; // Unused
  static const String LOADING_MESSAGE = 'Loading...'; // Unused

  // --- server transaction types ---
  static const String TRXTYPE_ADJUSTMENT = 'ADJUSTMENT';

  // --- server transaction source ---
  static const String TRXSRC_STOCK = 'STOCK';
}
