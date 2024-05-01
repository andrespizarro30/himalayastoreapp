
class AppConstants{
  static const String APP_NAME = "App Delivery";
  static const int APP_VERSION = 1;

  static const String BASE_URL = "https://generalwebservicesapi.azurewebsites.net";
  static const String GOOGLE_MAPS_API_BASE_URL = "https://maps.googleapis.com/maps/api";

  static const String ALL_PRODUCTS_LIST = "/api/productslist/get";
  static const String PRODUCTS_LIST_BY_CATEGORY = "/api/productslistbycategory/get";
  static const String PRODUCTS_CATEGORIES_LIST = "/api/productscategories/get";
  static const String DELIVERY_RECEIVER_DATA = "/api/mainuser/get";
  static const String REGISTER_NEW_USER = "/api/registerNewUser/post";
  static const String DELIVERIES_LIST = '/api/deliveriesList/get';
  static const String REGISTER_NEW_DELIVERY_ID = '/api/registerNewDeliveryId/post';
  static const String DELIVERIES_DETAIL_LIST = '/api/deliveriesDetailsList/get';
  static const String REGISTER_NEW_DELIVERY_ID_DETAIL = '/api/registerNewDeliveryDetail/post';


  static const String TOKEN = "DBToken";
  static const String FIRESTORE_TOKENS = "token";

  static const String GOOGLEMAPSANDROIDKEY = "AIzaSyAkBBvSMGpO4EoLTNjkLr7V-HzvdRlTY14";
  static const String GOOGLEMAPSIOSKEY = "AIzaSyB3gCARPJjOJlVD-HWqHYxUpwC2T-ZnxYg";

  static const String GEOCODINGKEY = "AIzaSyCBDQ2l_f4ksZaSzkCqhNsOhdHfbU5lKqA";
  static const String PLACESCODINGKEY = "AIzaSyCBDQ2l_f4ksZaSzkCqhNsOhdHfbU5lKqA";

  static const String ADDRESSSAVED = "AddressSaved";

  static const String CART_LIST = "CartList";
  static const String CART_HISTORY_LIST = "CartHistoryList";
}