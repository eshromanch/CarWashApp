/*
import 'package:flutter/material.dart';
import 'package:car_wash_app/ui/login_sreen.dart';
import 'package:get/route_manager.dart';
import 'package:hexcolor/hexcolor.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Container(
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: (){
                    Get.to(LoginScreen());
                  },
                  child: Container(
                    height: 75,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 18.0, top: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Already have an account?",
                            style: TextStyle(fontSize: 14),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Container(
                            child: Text(
                              "Sign in".toUpperCase(),
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: HexColor("#1D1A2F"),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                  child: InkWell(
                    onTap: (){
                      Get.to(LoginScreen());
                    },
                    child: Container(
                alignment: Alignment.center,
                height: 75,
                color: HexColor("#1D1A2F"),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Sign up".toUpperCase(),
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 6.0),
                        child: Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                      ),
                    ],
                ),
              ),
                  )),
            ],
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.center,
                color: HexColor("#1D1A2F"),
                child: Image.asset(
                  "assets/images/login_1.png",
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 48.0, top: 33),
                      child: Text(
                        "Register",
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 48.0, top: 15),
                      child: Text(
                        "Lorem ipsum is a placeholder text commonly used to demonstrate the",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 48.0, top: 25, right: 39),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Phone",
                          prefixIcon: IconButton(
                            onPressed: null,
                            icon: Icon(
                              Icons.phone
                              ,
                              size: 33,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 48.0, top: 20, right: 39),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Password",
                          prefixIcon: Image.asset(
                            "assets/images/login_3.png",
                            height: 10,
                            width: 10,
                          ),
                        ),
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
            ),
          ],
        ),
      ),
    );
  }
}
*/
