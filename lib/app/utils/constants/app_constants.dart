class AppConstants {
  // --- Application Information ---
  static const String APP_NAME = 'ABG POS';
  static const String APP_TITLE = 'Aroma Bisnis Group POS';
  static const String APP_VERSION = '0.0.1';
  static const String APP_BUILD_NUMBER = '1';
  static const String APP_DESCRIPTION =
      'Aplikasi POS untuk Aroma Bisnis Group.';
  static const String SUPPORT_EMAIL = 'support@aromabisnisgroup.com';
  static const String WEBSITE_URL = 'https://www.aromabisnisgroup.com';

  // --- Development/Production
  static const String DEV = 'development';
  static const String PROD = 'production';
  static const String ENVIRONMENT_SETTING = PROD;

  // --- API Configuration ---
  // Base URLs for different environments (useful for build configurations)
  static const String BASE_API_URL_DEV = 'http://10.0.2.2:8000/api/v1';
  static const String BASE_API_URL_PROD =
      'http://gg8ko0kg00oo00sscwoosk4w.46.202.163.60.sslip.io/api/v1';

  static const String CURRENT_BASE_API_URL = BASE_API_URL_PROD;

  static const int API_TIMEOUT_SECONDS = 30; // Global API request timeout
  static const int SYNC_TIMER = 10;
  static const bool RUN_SYNC_TIMER = true;

  static const String API_KEY_Maps = 'YOUR_MAPS_API_KEY';
  static const String API_KEY_FIREBASE = 'YOUR_FIREBASE_API_KEY';

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
  static const String KEY_MENU_LATEST = 'menu_latest_update';
  static const String KEY_OUTLET_LATEST = 'outlet_latest_update';
  static const String KEY_PROMO_SETTING_LATEST = 'promo_setting_latest_update';
  static const String KEY_ORDER_LATEST = 'order_latest_update';
  static const String KEY_BUNDLE_LATEST = 'bundle_latest_update';

  // --- File name ---
  static const String FILENAME_USER_DATA = 'abg_pos_local_user_data.json';
  static const String FILENAME_INGREDIENT_DATA =
      'abg_pos_local_ingredient_data.json';
  static const String FILENAME_MENU_CATEGORY_DATA =
      'abg_pos_local_menu_category_data.json';
  static const String FILENAME_ADDON_DATA = 'abg_pos_local_addon_data.json';
  static const String FILENAME_MENU_DATA = 'abg_pos_local_menu_data.json';
  static const String FILENAME_OUTLET_DATA = 'abg_pos_local_outlet_data.json';
  static const String FILENAME_PROMO_SETTING_DATA =
      'abg_pos_local_promo_setting_data.json';
  static const String FILENAME_ORDER_DATA = 'abg_pos_local_order_data.json';
  static const String FILENAME_BUNDLE_DATA = 'abg_pos_local_bundle_data.json';

  // --- Hero tag ---
  static const String HERO_AUTH_CARD = 'auth_card_hero';

  // --- User roles
  static const String ROLE_ADMIN = 'admin';
  static const String ROLE_FRANCHISEE = 'franchisee';
  static const String ROLE_SPVAREA = 'spvarea';
  static const String ROLE_OPERATOR = 'operator';

  // --- Promo Setting ---
  static const String PROMO_SETTING_BUY_GET = 'promo_buy_get';
  static const String PROMO_SETTING_SPEND_GET = 'promo_spend_get';

  // --- Routing and Navigation ---
  static const Duration ROUTE_TRANSITION_DURATION = Duration(milliseconds: 300);

  // --- UI Constants ---
  static const double DEFAULT_PADDING = 16.0;
  static const double DEFAULT_BORDER_RADIUS = 8.0;
  static const double DEFAULT_VERTICAL_MARGIN = 12.0;
  static const double DEFAULT_HORIZONTAL_MARGIN = 12.0;
  static const double DEFAULT_ICON_SIZE = 24.0;
  static const double DEFAULT_NAV_ICON_SIZE = 18.0;
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

  // --- Asset Paths (Examples) ---
  static const String IMG_LOGO = 'assets/images/logo_small.png';
  static const String IMG_PLACEHOLDER = 'assets/svg/img-placeholder.svg';
  static const String PROFILE_PLACEHOLDER =
      'assets/svg/profile-placeholder.svg';
  static const String PROFILE_PLACEHOLDER_PNG =
      'assets/png/profile-placeholder.png';

  // static const String IMG_PLACEHOLDER = 'assets/images/placeholder.png';
  static const String FONT_PRIMARY =
      'Poppins'; // Name of font family defined in pubspec.yaml

  // --- Messages and Strings (often handled by localization, but some static ones might be here) ---
  static const String ERROR_GENERIC =
      'Something went wrong. Please try again later.';
  static const String SUCCESS_GENERIC = 'Operation completed successfully.';
  static const String LOADING_MESSAGE = 'Loading...';
}
