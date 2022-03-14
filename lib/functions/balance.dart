import 'package:dio/dio.dart';
import 'package:xendit_unofficial/constant/api_url.dart';
import 'package:xendit_unofficial/services/fetch.dart';

class XenditBalance {
  check() async {
    Response response = await fetch().get(API.BALANCE);
    return response.data['balance'].toString();
  }
}
