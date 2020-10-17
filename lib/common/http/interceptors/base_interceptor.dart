import 'package:dio/dio.dart';

import 'package:flutter_cyf/common/constants/app_constants.dart';

class BaseInterceptor extends InterceptorsWrapper {
  @override
  Future onRequest(RequestOptions options) {
    options
      ..baseUrl = AppConstants.API_PREFIX
      ..connectTimeout = AppConstants.TIME_OUT //5s
      ..receiveTimeout = AppConstants.TIME_OUT
      ..headers.addAll(AppConstants.HEADERS);
    return super.onRequest(options);
  }

}
