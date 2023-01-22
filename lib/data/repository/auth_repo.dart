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

class AuthRepo {

  final SharedPreferences sharedPreferences;
  AuthRepo({ required this.sharedPreferences});

 /* Future<Response> registration(SignUpBody signUpBody) async {
    return await apiClient.postData(AppConstants.REGISTER_URI, signUpBody.toJson());
  }*/

  Future<List<UserInfo>> login({required UserInfo userInfo, required GasVatDatabase db}) async {
    print(userInfo.email);
    return await db.userDao.getUsers();
  }
  Future<UserInfo?> login1({required UserInfo userInfo, required GasVatDatabase db}) async {
    print(userInfo.email);
    return await db.userDao.login(userInfo.email!);
  }
  Future<bool> saveUserLogin(String token) async {

    return await sharedPreferences.setBool(AppConstants.ISLOGIN, true);
  }


  Future<void> saveUserAdded(bool isAdd) async {

     await sharedPreferences.setBool(AppConstants.ISADD, isAdd);
  }

  bool isAdded() {
    return sharedPreferences.getBool(AppConstants.ISADD)??false;
  }


  bool isLoggedIn() {
    return sharedPreferences.getBool(AppConstants.ISLOGIN)??false;
  }
  bool clearSharedData() {

    sharedPreferences.remove(AppConstants.ISLOGIN);



    return true;
  }

  Future<int> addUserToDatabase(GasVatDatabase db,UserInfo userInfo) async {

    return await db.userDao.inserUser(userInfo);
  }






}
