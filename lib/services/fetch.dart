import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/instance_manager.dart';
import 'package:xendit_unofficial/services/crypt.dart';
import 'package:xendit_unofficial/services/token.dart';

Dio fetch() {
  var _dio = Dio();
  TokenController tokenController = Get.put(TokenController());
  _dio.interceptors.add(QueuedInterceptorsWrapper(
    onRequest: (options, handler) {
      print("Basic ${Crypt().encode(tokenController.username.toString())}");
      options.headers['Authorization'] =
          "Basic ${Crypt().encode(tokenController.username.toString())}";
      handler.next(options);
    },
    onError: (err, handler) {
      print("ERROR");
      print(err.response);
      return handler.reject(err);
    },
    onResponse: (response, handler) {
      print("RESPONSE");
      print(response);
      return handler.next(response);
    },
  ));

  return _dio;
}
