
class Constrants {
  static String API_HOST = "https://www.phyok.com";
  static String SUFIIX = "author=wzb198911290019";

  static String API_AUTH = "$API_HOST/account/auth?$SUFIIX";
  static String API_SYS_CONFIG = "$API_HOST/sys/config?$SUFIIX";

  static String API_GET_USER_INFO = "$API_HOST/biz/getUserInfo?$SUFIIX";
  static String API_CHECK_LIMIT = "$API_HOST/biz/checkLimit?$SUFIIX";
  static String API_GET_TXT_HISTORY = "$API_HOST/biz/getTxtHistory?$SUFIIX";
  static String API_SAVE_TXT_HISTORY = "$API_HOST/biz/saveTxtHistory?$SUFIIX";

  static String API_SAVE_COLLECTION = "$API_HOST/collection/save?$SUFIIX";
  static String API_GET_COLLECTION_ALL = "$API_HOST/collection/all?$SUFIIX";
  static String API_GET_COLLECTION_DETAIL = "$API_HOST/collection/detail?$SUFIIX";

  static String API_PAY = "$API_HOST/pay/wx/app?$SUFIIX";
  static String API_IAP = "$API_HOST/sys/iap/verify?$SUFIIX";
}
