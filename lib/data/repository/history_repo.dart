/*
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:car_wash_app/data/api/api_client.dart';
import 'package:car_wash_app/data/model/body/InvoiceShowBody.dart';
import 'package:car_wash_app/data/model/body/signup_body.dart';
import 'package:car_wash_app/data/model/response/CreatedInvoiceResponse.dart';
import 'package:car_wash_app/data/model/response/login_response.dart';
import 'package:car_wash_app/database/db/database.dart';
import 'package:car_wash_app/util/app_constants.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryRepo {
  final ApiClient apiClient;

  HistoryRepo({required this.apiClient,});

  Future<List<InvoiceShow>> getInvoiceList(GasVatDatabase db) async {
    return await db.createdInvoiceDao.getInvoice() ;
  }
 */
/* Future<List<InvoiceShow>> getInvoiceListByUser(GasVatDatabase db) async {
      List<UserInfo> userlist=await db.userDao.getUsers();
      int id=userlist[0].id!;
    return await db.createdInvoiceDao.getInvoiceByUser(id) ;
  }*//*

  Future<List<InvoiceShow>> getUnSavedInvoiceList(GasVatDatabase db) async {
    return await db.createdInvoiceDao.getUnsavedInvoice(0) ;
  }
  Future<Response> saveInvoiceListIntoServer(InvoiceShowBody invoiceShow) async {
    

    return await apiClient.postData(AppConstants.INVOICE_SAVE_TO_ONLINE, invoiceShow.toJson()) ;
  }
}*/
