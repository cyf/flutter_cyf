import 'package:dio/dio.dart';

import 'package:flutter_cyf/common/constants/app_constants.dart';

class MiInterceptor extends InterceptorsWrapper {
  @override
  Future onRequest(RequestOptions options) {
    options
      ..baseUrl = AppConstants.MI_API_PREFIX
      ..connectTimeout = AppConstants.TIME_OUT //5s
      ..receiveTimeout = AppConstants.TIME_OUT
      ..headers.addAll(AppConstants.MI_HEADERS);
    return super.onRequest(options);
  }

}
