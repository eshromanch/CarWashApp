
import 'package:car_wash_app/view/screens/LogoEditScreen/LogoEditScreen.dart';
import 'package:car_wash_app/view/screens/auth/login_sreen.dart';
import 'package:car_wash_app/view/screens/businessProfileUpdate/serviceUpdateScreen.dart';
import 'package:flutter/material.dart';
import 'package:car_wash_app/controller/auth_controller.dart';
import 'package:car_wash_app/controller/history_controller.dart';
import 'package:car_wash_app/controller/home_controller.dart';

import 'package:car_wash_app/helper/route_helper.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';


class CustomDrawerTwo extends StatefulWidget {
  @override
  _CustomDrawerTwoState createState() => _CustomDrawerTwoState();
}

class _CustomDrawerTwoState extends State<CustomDrawerTwo> {



  @override
  Widget build(BuildContext context) {

    return Container(
      width: 280,
      child: Drawer(

        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,

            children: <Widget>[


              Image.asset("assets/images/bgcar.png",height: 300,fit: BoxFit.fill,),
              SizedBox(height: 20,),
              InkWell(
                onTap: () {
                  Get.back();
                  Get.to(BusinessUpdateScreen());


                },
                child: Container(
                  padding: EdgeInsets.all(15),
                  child: Row(
                    children: [
                    Icon(Icons.miscellaneous_services_outlined,size: 20,color: Color(0xff2F76BC),),
                    SizedBox(width: 10,),
                    Text(
                      "Company Details",
                      style: TextStyle( fontSize: 17,color: Colors.black),
                    )
                  ],),
                ),
              ),
              InkWell(
                onTap: () {
                  Get.back();
                  Get.to(LogoEditScreen());


                },
                child: Container(
                  padding: EdgeInsets.all(15),
                  child: Row(
                    children: [
                    Icon(Icons.miscellaneous_services_outlined,size: 20,color: Color(0xff2F76BC),),
                    SizedBox(width: 10,),
                    Text(
                      "Cars Company",
                      style: TextStyle( fontSize: 17,color: Colors.black),
                    )
                  ],),
                ),
              ),
              InkWell(
                onTap: () {
                  Get.back();
                  Get.find<AuthController>().clearSharedData().then((value){
                    if(value){
                      Get.offAll(LoginScreen());
                    }

                  });


                },
                child: Container(
                  padding: EdgeInsets.all(15),
                  child: Row(
                    children: [
                    Icon(Icons.logout,size: 20,color: Color(0xff2F76BC),),
                    SizedBox(width: 10,),
                      Text(
                        "Logout",
                        style: TextStyle( fontSize: 17,color: Colors.black),
                      )
                  ],),
                ),
              ),



            ],
          ),
        ),
      ),
    );
  }
}
