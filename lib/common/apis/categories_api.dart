import 'package:dio/dio.dart';

import 'package:flutter_cyf/common/http/http.dart';
import 'package:flutter_cyf/common/model/category_model.dart';

var http = Http(isMiHttp: true);
class CategoriesAPi {
  static Future<List<CategoryModel>> fetch() async {
    var url = 'home/category_v2';

    try {
      Response response = await http.post(url, queryParameters: addParam({}));
      if (response.statusCode == 200) {
        var result = response.data;
        if (result['code'] == 0 && result['result'] == 'ok') {
          result = result['data'];
          if (result != null && result.length > 0) {
            List<CategoryModel> items = [];
            result.forEach((v) {
              items.add(CategoryModel.fromJson(v));
            });
            return items;
          }
        }

      }
    } on DioError catch (e) {
      formatError(e);
    }

    return [];
  }
}
