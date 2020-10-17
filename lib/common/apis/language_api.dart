import 'package:dio/dio.dart';

import 'package:flutter_cyf/common/http/http.dart';
import 'package:flutter_cyf/common/model/language_model.dart';

var http = Http();
class LanguageAPi {
  static Future<List<Language>> fetch() async {
    var url = 'languages.json';

    try {
      Response response = await http.get(url);
      if (response.statusCode == 200) {
        var result = response.data;
        if (result != null && result.length > 0) {
          List<Language> items = [];
          result.forEach((v) {
            items.add(Language.fromJson(v));
          });
          return items;
        }
      }
    } on DioError catch (e) {
      formatError(e);
    }

    return [];
  }
}
