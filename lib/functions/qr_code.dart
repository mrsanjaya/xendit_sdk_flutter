import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:xendit_unofficial/constant/api_url.dart';
import 'package:xendit_unofficial/services/fetch.dart';

class XenditQRIS {
  String external_id;
  int nominal;
  String callback;
  String type;

  XenditQRIS(
      {required this.external_id,
      required this.nominal,
      required this.callback,
      this.type = "DYNAMIC"});

  Future<String> generate() async {
    try {
      Response response = await fetch().post(API.QRCODE, data: {
        "external_id": "${external_id}",
        "type": "${type}",
        "callback_url": "${callback}",
        "amount": nominal
      });

      return jsonEncode(response.data);
    } on DioError catch (e) {
      print(e);
      return e.toString();
    }
  }
}

XenditQrisModel xenditQrisModelFromJson(String str) =>
    XenditQrisModel.fromJson(json.decode(str));

String xenditQrisModelToJson(XenditQrisModel data) =>
    json.encode(data.toJson());

class XenditQrisModel {
  XenditQrisModel({
    required this.id,
    required this.externalId,
    required this.amount,
    required this.description,
    required this.qrString,
    required this.callbackUrl,
    required this.type,
    required this.status,
    required this.created,
    required this.updated,
    required this.metadata,
  });

  String id;
  String externalId;
  int amount;
  String description;
  String qrString;
  String callbackUrl;
  String type;
  String status;
  DateTime created;
  DateTime updated;
  dynamic metadata;

  factory XenditQrisModel.fromJson(Map<String, dynamic> json) =>
      XenditQrisModel(
        id: json["id"],
        externalId: json["external_id"],
        amount: json["amount"],
        description: json["description"],
        qrString: json["qr_string"],
        callbackUrl: json["callback_url"],
        type: json["type"],
        status: json["status"],
        created: DateTime.parse(json["created"]),
        updated: DateTime.parse(json["updated"]),
        metadata: json["metadata"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "external_id": externalId,
        "amount": amount,
        "description": description,
        "qr_string": qrString,
        "callback_url": callbackUrl,
        "type": type,
        "status": status,
        "created": created.toIso8601String(),
        "updated": updated.toIso8601String(),
        "metadata": metadata,
      };
}
