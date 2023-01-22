import 'dart:convert';



import 'package:car_wash_app/controller/logo_controller.dart';
import 'package:car_wash_app/controller/service_controller.dart';
import 'package:car_wash_app/data/repository/logo_repo.dart';
import 'package:car_wash_app/data/repository/service_repo.dart';
import 'package:flutter/services.dart';
import 'package:car_wash_app/controller/auth_controller.dart';
import 'package:car_wash_app/controller/history_controller.dart';
import 'package:car_wash_app/controller/home_controller.dart';
import 'package:car_wash_app/data/api/api_client.dart';
import 'package:car_wash_app/data/repository/auth_repo.dart';
import 'package:car_wash_app/data/repository/history_repo.dart';
import 'package:car_wash_app/data/repository/home_repo.dart';
import 'package:car_wash_app/data/repository/invoice_repo.dart';
import 'package:car_wash_app/database/db/database.dart';
import 'package:car_wash_app/util/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';


Future<void> init() async {
  // Core

  final sharedPreferences = await SharedPreferences.getInstance();
  final db= await $FloorGasVatDatabase
      .databaseBuilder('user_database.db')
      .build();
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => db);
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL, sharedPreferences: Get.find()));
  Get.lazyPut(() => AuthRepo( sharedPreferences: Get.find()));
  Get.lazyPut(() => HomeRepo(apiClient: Get.find()));
  Get.lazyPut(() => LogoRepo(sharedPreferences: Get.find()));
  Get.lazyPut(() => ServiceRepo(apiClient: Get.find()));
  Get.lazyPut(() => InvoiceRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  //Get.lazyPut(() => HistoryRepo(apiClient: Get.find()));

  Get.lazyPut(() => AuthController(authRepo: Get.find(),db: Get.find(), ));
  Get.lazyPut(() => HomeController(homeRepo: Get.find() ,database: Get.find()));
  Get.lazyPut(() => ServiceController(serviceRepo: Get.find() ,database: Get.find()));
  Get.lazyPut(() => LogoController(database: Get.find(), logoRepo: Get.find() ));
 // Get.lazyPut(() => HistoryController(historyRepo: Get.find(),database: Get.find()));

 


}
