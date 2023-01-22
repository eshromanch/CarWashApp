




class AppConstants {
  static const String APP_NAME = 'EazzyGASPro';
  static const String MAP_API_KEY = 'AIzaSyAq_Q4YjGePRP1DRghyMVCW85j9s5er14Y';
  static const int APP_VERSION = 1;
  static const String TOKEN = 'car_wash_app_token';
  static const String ISLOGIN = 'ISLOGIN';
  static const String ISADD = 'ISADD';
  static const String ISLOGOADD = 'ISLOGOADD';
  static const String ImagePath = 'user_image_path';

  static const String BASE_URL = 'https://riddhosoft.com/api';
  static const String IMAGE_BASE_URL = 'https://riddhosoft.com/';
  static const String LOGIN_URI = '/v1/login';
  static const String REGISTER_URI = '/v1/login';
  static const String OIL_INFO = '/v1/invoice';
  static const String INVOICE_CREATE = '/v1/invoice-page';
  static const String INVOICE_SAVE_TO_ONLINE = '/v1/invoice-old-data';

  static const String FULLWASH= 'Full Wash';
  static const String INTERIORWASH = 'Interior Wash';
  static const String EXTERIORWASH = 'Exterior Wash';

  static const String CARD = 'CARD';
  static const String CASH = 'CASH';



 /* static const String CATEGORY_URI = '/api/v1/categories';
  static const String BANNER_URI = '/api/v1/banners';
  static const String OFFER_BANNER_URI = '/api/v1/offer_image';
  static const String RESTAURANT_PRODUCT_URI = '/api/v1/products/latest?restaurant_id=';
  static const String POPULAR_PRODUCT_URI = '/api/v1/products/popular';
  static const String SPECIAL_PRODUCT_URI = '/api/v1/products/special-product?restaurant_id=';
  static const String SUBCATEGORY_LIST_URI = '/api/v1/categories/restaurant/childes/';
  static const String SEARCH_PRODUCT_URI = '/api/v1/products/details/';
  static const String SUB_CATEGORY_URI = '/api/v1/categories/childes/';
  static const String CATEGORY_PRODUCT_URI = '/api/v1/categories/products/';
  static const String CONFIG_URI = '/api/v1/config';
  static const String TRACK_URI = '/api/v1/customer/order/track?order_id=';
  static const String MESSAGE_URI = '/api/v1/customer/message/get';
  static const String SEND_MESSAGE_URI = '/api/v1/customer/message/send';
  static const String FORGET_PASSWORD_URI = '/api/v1/auth/forgot-password';
  static const String VERIFY_TOKEN_URI = '/api/v1/auth/verify-token';
  static const String RESET_PASSWORD_URI = '/api/v1/auth/reset-password';
  static const String VERIFY_PHONE_URI = '/api/v1/auth/verify-phone';
  static const String CHECK_EMAIL_URI = '/api/v1/auth/check-email';
  static const String VERIFY_EMAIL_URI = '/api/v1/auth/verify-email';
  static const String REGISTER_URI = '/api/registration';
  static const String LOGIN_URI = '/api/login';
  static const String TOKEN_URI = '/api/v1/customer/cm-firebase-token';
  static const String PLACE_ORDER_URI = '/api/v1/customer/order/place';
  static const String ADDRESS_LIST_URI = '/api/v1/customer/address/list';
  static const String ZONE_URI = '/api/v1/config/get-zone-id';
  static const String REMOVE_ADDRESS_URI = '/api/v1/customer/address/delete?address_id=';
  static const String ADD_ADDRESS_URI = '/api/v1/customer/address/add';
  static const String UPDATE_ADDRESS_URI = '/api/v1/customer/address/update/';
  static const String SET_MENU_URI = '/api/v1/products/set-menu';
  static const String CUSTOMER_INFO_URI = '/api/user';
  static const String COUPON_URI = '/api/v1/coupon/list';
  static const String COUPON_APPLY_URI = '/api/v1/coupon/apply?code=';
  static const String ORDER_LIST_URI = '/api/v1/customer/order/list';
  static const String ORDER_CANCEL_URI = '/api/v1/customer/order/cancel';
  static const String COD_SWITCH_URL = '/api/v1/customer/order/payment-method';
  static const String ORDER_DETAILS_URI = '/api/v1/customer/order/details?order_id=';
  static const String WISH_LIST_GET_URI = '/api/v1/customer/wish-list';
  static const String OFFER_LIST_GET_URI = '/api/v1/products/offer-product';
  static const String ADD_WISH_LIST_URI = '/api/v1/customer/wish-list/add?';
  static const String REMOVE_WISH_LIST_URI = '/api/v1/customer/wish-list/remove?';
  static const String NOTIFICATION_URI = '/api/v1/customer/notifications';
  static const String UPDATE_PROFILE_URI = '/api/v1/customer/update-profile';
  static const String SEARCH_URI = '/api/v1/';
  static const String SEARCH_URI_FOR_RES = '/api/v1/restaurants/search-product';
  static const String REVIEW_URI = '/api/v1/products/reviews/submit';
  static const String PRODUCT_DETAILS_URI = '/api/v1/products/details/';
  static const String LAST_LOCATION_URI = '/api/v1/delivery-man/last-location?order_id=';
  static const String DELIVER_MAN_REVIEW_URI = '/api/v1/delivery-man/reviews/submit';
  static const String RESTAURANT_URI = '/api/v1/restaurants/get-restaurants';
  static const String RESTAURANT_DETAILS_URI = '/api/v1/restaurants/details/';
  static const String BASIC_CAMPAIGN_URI = '/api/v1/campaigns/basic';
  static const String ITEM_CAMPAIGN_URI = '/api/v1/campaigns/item';
  static const String BASIC_CAMPAIGN_DETAILS_URI = '/api/v1/campaigns/basic-campaign-details?basic_campaign_id=';
  static const String INTEREST_URI = '/api/v1/customer/update-interest';
  static const String SUGGESTED_FOOD_URI = '/api/v1/customer/suggested-foods';
  static const String DISTANCE_MATRIX_URI = '/api/v1/config/distance-api';
  static const String SEARCH_LOCATION_URI = '/api/v1/config/place-api-autocomplete';
  static const String PLACE_DETAILS_URI = '/api/v1/config/place-api-details';
  static const String GEOCODE_URI = 'https://maps.googleapis.com/maps/api/geocode/json?';

  // Shared Key
  static const String THEME = 'theme';
  static const String TOKEN = 'multivendor_token';
  static const String COUNTRY_CODE = 'country_code';
  static const String LANGUAGE_CODE = 'language_code';
  static const String CART_LIST = 'cart_list';
  static const String USER_PASSWORD = 'user_password';
  static const String USER_ADDRESS = 'user_address';
  static const String USER_NUMBER = 'user_number';
  static const String USER_EMAIL = 'user_email';
  static const String USER_COUNTRY_CODE = 'user_country_code';
  static const String NOTIFICATION = 'notification';
  static const String SEARCH_HISTORY = 'search_history';
  static const String INTRO = 'intro';
  static const String NOTIFICATION_COUNT = 'notification_count';
  static const String TOPIC = 'all_zone_customer';
  static const String ZONE_ID = 'zoneId';
  static const String FIRSTTIME = 'first_time';*/

}
