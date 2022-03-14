import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:xendit_unofficial/constant/api_url.dart';
import 'package:xendit_unofficial/services/fetch.dart';

class XenditVA {
  String external_id;
  String bank_code;
  String name;
  String? virtual_account_number;
  int? suggested_amount;
  bool? is_closed;
  int? expected_amount;
  bool? is_single_use;
  String? description;
  XenditVA(
      {required this.external_id,
      required this.bank_code,
      required this.name,
      this.virtual_account_number,
      this.suggested_amount,
      this.is_closed,
      this.expected_amount,
      this.is_single_use,
      this.description});

  Future<String> generate() async {
    try {
      var params = {
        "external_id": "${external_id}",
        "bank_code": "${bank_code}",
        "name": "${name}",
        "virtual_account_number":
            virtual_account_number != null ? "${virtual_account_number}" : null,
        "suggested_amount": suggested_amount,
        "is_closed": is_closed,
        "expected_amount": expected_amount,
        "is_single_use": is_single_use,
        "description": description != null ? "${description}" : null
      };
      // ignore: avoid_print
      params.removeWhere((key, value) => value == null);
      print(params);
      Response response = await fetch().post(API.VA, data: params);

      return jsonEncode(response.data);
    } on DioError catch (e) {
      return jsonEncode(e.response!.data);
    } catch (e) {
      return jsonEncode(e);
    }
  }
}

XenditVaModel xenditVaModelFromJson(String str) =>
    XenditVaModel.fromJson(json.decode(str));

String xenditVaModelToJson(XenditVaModel data) => json.encode(data.toJson());

class XenditVaModel {
  XenditVaModel({
    required this.ownerId,
    required this.externalId,
    required this.bankCode,
    required this.merchantCode,
    required this.name,
    required this.accountNumber,
    required this.expectedAmount,
    required this.isSingleUse,
    required this.description,
    required this.currency,
    required this.status,
    required this.isClosed,
    required this.id,
  });

  String ownerId;
  String externalId;
  String bankCode;
  String merchantCode;
  String name;
  String accountNumber;
  int expectedAmount;
  bool isSingleUse;
  String description;
  String currency;
  String status;
  bool isClosed;
  String id;

  factory XenditVaModel.fromJson(Map<String, dynamic> json) => XenditVaModel(
        ownerId: json["owner_id"] == null ? "" : json["owner_id"],
        externalId: json["external_id"] == null ? "" : json["external_id"],
        bankCode: json["bank_code"] == null ? "" : json["bank_code"],
        merchantCode:
            json["merchant_code"] == null ? "" : json["merchant_code"],
        name: json["name"] == null ? "" : json["name"],
        accountNumber:
            json["account_number"] == null ? "" : json["account_number"],
        expectedAmount:
            json["expected_amount"] == null ? 0 : json["expected_amount"],
        isSingleUse:
            json["is_single_use"] == null ? false : json["is_single_use"],
        description: json["description"] == null ? "" : json["description"],
        currency: json["currency"] == null ? "" : json["currency"],
        status: json["status"] == null ? "" : json["status"],
        isClosed: json["is_closed"] == null ? false : json["is_closed"],
        id: json["id"] == null ? "" : json["id"],
      );

  Map<String, dynamic> toJson() => {
        "owner_id": ownerId,
        "external_id": externalId,
        "bank_code": bankCode,
        "merchant_code": merchantCode,
        "name": name,
        "account_number": accountNumber,
        "expected_amount": expectedAmount,
        "is_single_use": isSingleUse,
        "description": description,
        "currency": currency,
        "status": status,
        "is_closed": isClosed,
        "id": id,
      };
}
