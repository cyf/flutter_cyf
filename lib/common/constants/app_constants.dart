class AppConstants {
  static const int TIME_OUT = 5 * 1000;

  static const String API_PREFIX = "https://api.kjxbyz.com/v1/";
  static const Map<String, dynamic> HEADERS = {
    'Content-Type': 'application/x-www-form-urlencoded'
  };

  static const String MI_API_PREFIX = "https://m.mi.com/v1/";
  static const Map<String, dynamic> MI_HEADERS = {
    'Host': 'm.mi.com',
    'Origin': 'https://m.mi.com',
    'Content-Type': 'application/x-www-form-urlencoded',
    'Referer': 'https://m.mi.com/',
  };
}
