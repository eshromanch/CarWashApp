import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:car_wash_app/data/api/api_client.dart';
import 'package:car_wash_app/data/model/body/signup_body.dart';
import 'package:car_wash_app/util/app_constants.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InvoiceRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  InvoiceRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> getInvoice(String oilInfo_id,String amount) async {
    return await apiClient.postData(AppConstants.OIL_INFO,{"oilInfo_id":oilInfo_id,"amount":amount} );
  }

  Future<Response> getInvoicePrint(String id) async {
    return await apiClient.getData(AppConstants.INVOICE_CREATE+"/"+id, );
  }










}
