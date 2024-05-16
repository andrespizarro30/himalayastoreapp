
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
  static const String DELIVERY_BY_UID_AND_ID = "/api/deliveryByUIDandId/get";
  static const String DELIVERIES_LIST = '/api/deliveriesList/get';
  static const String REGISTER_NEW_DELIVERY_ID = '/api/registerNewDeliveryId/post';
  static const String UPDATE_DELIVERY_ID_STATUS = "/api/deliveryIdStatus/put";
  static const String DELIVERIES_DETAIL_LIST = '/api/deliveriesDetailsList/get';
  static const String REGISTER_NEW_DELIVERY_ID_DETAIL = '/api/registerNewDeliveryDetail/post';
  static const String REGISTER_PRODUCT_RATING = '/api/registerproductrating/post';
  static const String RATING_PRODUCTS_LIST = '/api/productrating/get';
  static const String UPDATE_PHONE_NUMBER = '/api/updatephonenumber/put';

  static const String FIREBASE_MESSAGING_AUTH_TOKEN = "AAAAh5w2eLs:APA91bGm5wCm_hD9DyRiy-1D-OAn5pThJzDGEuN7VxNAHO74QBCEoWgvxJJfAaIcRhECKZkqMKfrbqw0hK-lOHqSw3_WWtnL98mHTmc13g0-tdqXhZ0Wk1HqEDvQLRJOO67Zv6Sk8czO";


  static const String TOKEN = "DBToken";
  static const String FIRESTORE_TOKENS = "token";

  static const String GOOGLEMAPSANDROIDKEY = "AIzaSyAkBBvSMGpO4EoLTNjkLr7V-HzvdRlTY14";
  static const String GOOGLEMAPSIOSKEY = "AIzaSyB3gCARPJjOJlVD-HWqHYxUpwC2T-ZnxYg";

  static const String GEOCODINGKEY = "AIzaSyCBDQ2l_f4ksZaSzkCqhNsOhdHfbU5lKqA";
  static const String PLACESCODINGKEY = "AIzaSyCBDQ2l_f4ksZaSzkCqhNsOhdHfbU5lKqA";

  static const String ADDRESSSAVED = "AddressSaved";

  static const String CART_LIST = "CartList";
  static const String CART_HISTORY_LIST = "CartHistoryList";

  static const String SAVED_CREDIT_CARDS = "CreditCardsList";
  static const String CURRENT_SELECTED_PAYMENT = "CurrentSelectedPayment";
  static const String PSE_PAYMENT_METHOD = "Pago PSE";

  static const String PAYMENTS_BASE_URL = "https://apify.epayco.co";
  static const String PAYMENT_LOGIN = "/login";
  static const String CREDIT_CARD_PAYMENT = "/payment/process";
  static const String PSE_PAYMENT = "/payment/process/pse";
  static const String BANK_LIST = "/payment/pse/banks";
  static const String TRANSACTION_CONFIRM = "/payment/pse/transaction";

}