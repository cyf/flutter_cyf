import 'package:dio/dio.dart';

import 'package:flutter_cyf/common/http/http.dart';
import 'package:flutter_cyf/common/model/news_model.dart';
import 'package:flutter_cyf/common/model/result_model.dart';
import 'package:flutter_cyf/common/utils/result_model_utils.dart';

var http = Http();

class NewsAPi {
  static Future<ResultModel<NewsModel>> fetch() async {
    var url = 'news.json';

    try {
      Response response = await http.get(url);
      if (response.statusCode == 200) {
        var result = response.data;
        List<NewsModel> items = [];
        if (result != null && result.length > 0) {
          result.forEach((v) {
            items.add(NewsModel.fromJson(v));
          });
        }
        return ResultModelUtils.success(items);
      }
      return ResultModelUtils.failure(null);
    } on DioError catch (e) {
      formatError(e);
      return ResultModelUtils.error(e?.message ?? '');
    }
  }
}
