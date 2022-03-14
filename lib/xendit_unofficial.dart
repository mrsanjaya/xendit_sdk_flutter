// You have generated a new plugin project without
// specifying the `--platforms` flag. A plugin project supports no platforms is generated.
// To add platforms, run `flutter create -t plugin --platforms <platforms> .` under the same
// directory. You can also find a detailed instruction on how to add platforms in the `pubspec.yaml` at https://flutter.dev/docs/development/packages-and-plugins/developing-packages#plugin-platforms.

import 'dart:async';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:xendit_unofficial/functions/balance.dart';
import 'package:xendit_unofficial/services/token.dart';
export 'functions/qr_code.dart';
export 'functions/balance.dart';
export 'functions/virtual_account.dart';
export 'constant/bank_code.dart';

class XenditSDK {
  String apiKey;
  XenditSDK({required this.apiKey});

  init() async {
    TokenController tokenController = Get.put(TokenController());
    tokenController.setUsername(apiKey);
  }
}
