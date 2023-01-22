import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:car_wash_app/view/screens/amountEntry/test.dart';

import 'package:car_wash_app/view/screens/auth/login_sreen.dart';
import 'package:car_wash_app/view/screens/history/historyScreen.dart';
import 'package:car_wash_app/view/screens/home/home_screen.dart';

import 'package:get/get.dart';

class RouteHelper {


  static const String signIn = '/sign-in';
  static const String signUp = '/sign-up';
  static const String home = '/home';
  static const String history = '/history';







  static String getSignInRoute() => '$signIn';
  static String getHomeRoute() => '$home';
  static String getHistoryRoute() => '$history';
 // static String getSignUpRoute() => '$signUp';
  //static String getLandingRoute() => '$home';




  static List<GetPage> routes = [

    GetPage(name: signIn, page: () => LoginScreen()),
    GetPage(name: home, page: () => HomeScreen()),

  //  GetPage(name: signUp, page: () => RegisterScreen()),
   // GetPage(name: home, page: () => home()),


    //GetPage(name: onBoarding, page: () => OnBoardingScreen()),


  ];

 /* static getRoute(Widget navigateTo) {
    return false? UpdateScreen(isUpdate: true)
        : false? UpdateScreen(isUpdate: false)
        : Get.find<LocationController>().getUserAddress() != null ? navigateTo
        : AccessLocationScreen(fromSignUp: false, fromHome: false, route: Get.currentRoute);
  }*/
}
