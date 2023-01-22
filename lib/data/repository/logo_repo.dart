import 'dart:async';

import 'package:car_wash_app/data/model/body/Logo.dart';
import 'package:flutter/foundation.dart';
import 'package:car_wash_app/data/api/api_client.dart';
import 'package:car_wash_app/data/model/body/signup_body.dart';

import 'package:car_wash_app/data/model/response/login_response.dart';
import 'package:car_wash_app/database/db/database.dart';
import 'package:car_wash_app/util/app_constants.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogoRepo {
  final SharedPreferences sharedPreferences;
  LogoRepo({ required this.sharedPreferences});


  Future<List<Logo>> getLogoFromDatabase(GasVatDatabase db) async {

    return await db.logo.getLogoList();
  }
  Future<int> insertLogoIntoDatabase(GasVatDatabase db,Logo logo) async {

    return await db.logo.inserLogoInfo(logo);
  }
  Future<int> UpdateLogoIntoDatabase(GasVatDatabase db,Logo logo) async {

    return await db.logo.updateServiceInfo(logo);
  }

  Future<int?> deleteLogoIntoDatabase(GasVatDatabase db,Logo logo) async {
    print("hoga mara");
    return await db.logo.deleteLogo(logo.id!);
  }
  Future<void> setLogoInsertIntoDatabase(bool isAdd) async {

    await sharedPreferences.setBool(AppConstants.ISLOGOADD, isAdd);
  }

  Future<bool> getLogoInsertIntoDatabase() async {

    return await sharedPreferences.getBool(AppConstants.ISLOGOADD)??false;
  }










}
