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
import 'package:car_wash_app/view/screens/auth/forgot_sreen.dart';
import 'package:car_wash_app/view/screens/home/home_screen.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  /*late LoginModel _loginRes;*/
  String phone = "";
  String password = "";
  bool _obscureText = true;
  TextEditingController phoneController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  FocusNode _passfocusNode = new FocusNode();
  FocusNode _phonfocusNode = new FocusNode();
  bool isSignIN = true;
  bool islogin = false;
  bool isforgot = false;

  @override
  void initState() {
    EasyLoading.init();
    //bool islogin= Get.find<AuthController>().isLoggedIn();
    Get.find<AuthController>().addUserToDatabase();
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
          bottomNavigationBar: Container(
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      isSignIN = false;
                      isforgot = false;
                      setState(() {});
                      //Get.to(RegisterScreen()
                      // );
                    },
                    child: Container(
                      color: isSignIN ? Colors.white : HexColor("#1D1A2F"),
                      height: 75,
                      child: isSignIN
                          ? Padding(
                              padding:
                                  const EdgeInsets.only(left: 18.0, top: 15),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Don't have an account?",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Container(
                                    child: Text(
                                      "Sign up".toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: isSignIN
                                            ? HexColor("#1D1A2F")
                                            : Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Center(
                              child: Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Sign up".toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: isSignIN
                                            ? HexColor("#1D1A2F")
                                            : Colors.white,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 6.0),
                                      child: Icon(
                                        Icons.arrow_forward,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                    ),
                  ),
                ),
                Expanded(
                    child: InkWell(
                  onTap: () {
                    if (isSignIN) {
                      login(authController);
                    } else {
                      isSignIN = true;
                      setState(() {});
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 75,
                    color: isSignIN ? HexColor("#1D1A2F") : Colors.white,
                    child: Center(
                      child: isSignIN
                          ? Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Sign In".toUpperCase(),
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: isSignIN
                                            ? Colors.white
                                            : HexColor("#1D1A2F")),
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
                            )
                          : Padding(
                              padding:
                                  const EdgeInsets.only(left: 0.0, top: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    !isSignIN ? "Have an account?" : "",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Text(
                                    "Sign In".toUpperCase(),
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: isSignIN
                                            ? Colors.white
                                            : HexColor("#1D1A2F")),
                                  )
                                ],
                              ),
                            ),
                    ),
                  ),
                )),
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    height: MediaQuery.of(context).size.height / 2.4,
                    width: MediaQuery.of(context).size.width,
                    decoration: new BoxDecoration(
                        image: new DecorationImage(
                  image: new AssetImage("assets/images/bg.png"),

                          fit: BoxFit.fill,
                ),
                    )
                ,child: Container(
                  padding: EdgeInsets.all(40),
                  child: Image.asset(
                    "assets/images/car.png",

                    fit: BoxFit.fill,
                  ),
                ),
                ),
                /*Container(
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/images/bg.png",
                    height: MediaQuery.of(context).size.height / 2.5,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fill,
                  ),
                ),*/
                isSignIN
                    ? Container(
                        decoration: BoxDecoration(),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 48.0, top: 33),
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            /*Padding(
                              padding: EdgeInsets.only(left: 48.0, top: 15),
                              child: Text(
                                "Lorem ipsum is a placeholder text commonly used to demonstrate the",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),*/
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 48.0, top: 25, right: 39),
                                child: CustomTextField(
                                  controller: phoneController,
                                  hintText: "User Id",
                                  prefixIcon: "assets/images/person.png",
                                  focusNode: _phonfocusNode,
                                  onSubmit: () {},
                                )),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 48.0, top: 20, right: 39),
                                child: CustomTextField(
                                  controller: passwordController,
                                  hintText: "Password",
                                  prefixIcon: "assets/images/lock.png",
                                  isPassword: true,
                                  focusNode: _passfocusNode,
                                  onSubmit: () {},
                                ) /*TextField(
                                textInputAction:TextInputAction.done,
                                controller: passwordController,
                                decoration: InputDecoration(
                                  hintText: "Password",
                                  prefixIcon: Image.asset(
                                    "assets/images/login_3.png",
                                    height: 10,
                                    width: 10,
                                  ),
                                ),
                              ),*/
                                ),
                            SizedBox(
                              height: 20,
                            ),

                            /*  Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                  onTap: (){
                                Get.to(ForgotScreen());
                                           },
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 36.0, top: 4),
                                      child: Text(
                                        "Forgot password ?",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: HexColor("#1D1A2F"),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),*/
                          ],
                        ),
                      )
                    : isforgot
                        ? Container(
                            decoration: BoxDecoration(),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    isforgot = true;
                                  },
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(left: 48.0, top: 33),
                                    child: Text(
                                      "Forgot Password",
                                      style: TextStyle(
                                          fontSize: 30,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 50.0, top: 40),
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
                          )
                        : Container(
                            decoration: BoxDecoration(),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 48.0, top: 33),
                                  child: Text(
                                    "Sign Up",
                                    style: TextStyle(
                                        fontSize: 30,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 50.0, top: 40),
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
    }));
  }

  void login(AuthController authController) {
    String phone = phoneController.text.trim();
    String password = passwordController.text.trim();
    if (phone.isEmpty) {
      showCustomSnackBar('Enter your Phone Number');
    } else if (password.isEmpty) {
      showCustomSnackBar('Enter your Password');
    } else {
      EasyLoading.show(maskType: EasyLoadingMaskType.clear);
      authController.login1(phone, password).then((status) async {
        EasyLoading.dismiss();
        if (status.isSuccess) {
          //showCustomSnackBar(status.message);
          Get.toNamed(RouteHelper.getHomeRoute());
        } else {
          showCustomSnackBar(status.message);
        }
      });
    }

    //checkAPI(phone, password);
  }

/*Future<void> checkAPI(String _phone, String _password) async {
    EasyLoading.show(maskType: EasyLoadingMaskType.clear);
    Map<String, dynamic> jsonMap = {
      'email': _phone,
      'password': _password,
    };

    try {
      final response = await http.post(
        Uri.parse("https://riddhosoft.com/api/v1/login"),
        body: jsonMap,
      );

      EasyLoading.dismiss();
      _loginRes = loginModelFromJson(response.body);
      if (_loginRes.userData!.status == "1") {
        _phone = _loginRes.userData!.email!;
        log("RESPONSE____${response.body}");
        await MyPrefs.setAuthCode("${_loginRes.accessToken}");
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ));
      } else {
        EasyLoading.dismiss();
      }

      log(response.body);
    } on SocketException {
      EasyLoading.dismiss();
      // Constants.showNoInternetSnackBar(context);
    }
  }*/
}
