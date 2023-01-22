import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:car_wash_app/controller/auth_controller.dart';
import 'package:car_wash_app/helper/route_helper.dart';


import 'package:car_wash_app/view/base/custom_snackbar.dart';
import 'package:car_wash_app/view/base/custom_text_field.dart';
import 'package:car_wash_app/view/screens/home/home_screen.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;

class ForgotScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<ForgotScreen> {


  @override
  void initState() {

    EasyLoading.init();
    //bool islogin= Get.find<AuthController>().isLoggedIn();

    super.initState();
  }

  @override
  void deactivate() {
    EasyLoading.dismiss();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: GetBuilder<AuthController>(builder: (authController) {
          return Scaffold(
            appBar: AppBar(backgroundColor:HexColor("#1D1A2F"),title: Text("Forgot Password"),),
            body:SingleChildScrollView(
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.center,

                        child: Image.asset(
                          "assets/images/carbg.png",
                    height: MediaQuery.of(context).size.height/2.5,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:EdgeInsets.only(left: 48.0, top: 33),
                              child: Text(
                                "Forgot Password",
                                style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding:EdgeInsets.only(left: 50.0, top: 40),
                              child: Text(
                                "contact with your admin email:",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 80.0, top: 10),
                              child: Text(
                                "help@riddhosoft.com",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Color(0xff0163E2),
                                    fontWeight: FontWeight.w400),
                              ),
                            ),

                            // Row(
                            //   crossAxisAlignment: CrossAxisAlignment.end,
                            //   mainAxisAlignment: MainAxisAlignment.end,
                            //   children: [
                            //     Padding(
                            //       padding: const EdgeInsets.only(right: 36.0, top: 4),
                            //       child: Text(
                            //         "Forgot password ?",
                            //         style: TextStyle(
                            //           fontSize: 14,
                            //           fontWeight: FontWeight.w400,
                            //           color: HexColor("#1D1A2F"),
                            //         ),
                            //       ),
                            //     )
                            //   ],
                            // ),
                          ],
                        ),
                      ),

                    ],
                  ),
                ));
        }
      ));



  }




}
