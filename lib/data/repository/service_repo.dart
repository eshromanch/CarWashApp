import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:car_wash_app/data/api/api_client.dart';
import 'package:car_wash_app/data/model/body/signup_body.dart';

import 'package:car_wash_app/data/model/response/login_response.dart';
import 'package:car_wash_app/database/db/database.dart';
import 'package:car_wash_app/util/app_constants.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServiceRepo {
  final ApiClient apiClient;

  ServiceRepo({required this.apiClient,});

  Future<List<Service>> getBusinessFromDatabase(GasVatDatabase db) async {

    return await db.serviceDao.getServiceInfoList();
  }
  Future<int> insertServiceIntoDatabase(GasVatDatabase db,Service service) async {

    return await db.serviceDao.inserServiceInfo(service);
  }
  Future<int> UpdateServiceIntoDatabase(GasVatDatabase db,Service service) async {

    return await db.serviceDao.updateServiceInfo(service);
  }

  Future<int?> deleteServiceIntoDatabase(GasVatDatabase db,Service service) async {
    print("hoga mara");
    return await db.serviceDao.deleteServiceInfo(service.id!);
  }












}
