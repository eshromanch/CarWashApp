import 'dart:ffi';
import 'dart:io';

import 'package:car_wash_app/controller/home_controller.dart';
import 'package:car_wash_app/controller/logo_controller.dart';
import 'package:car_wash_app/controller/service_controller.dart';
import 'package:car_wash_app/data/model/body/Logo.dart';
import 'package:car_wash_app/data/model/response/login_response.dart';
import 'package:car_wash_app/view/base/custom_button.dart';
import 'package:car_wash_app/view/base/custom_text_field_with_title.dart';
import 'package:car_wash_app/view/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogoUpdateScreen extends StatefulWidget {
  final int logoIndex;
  LogoUpdateScreen({Key? key, required this.logoIndex,}) : super(key: key);

  @override
  _ServiceUpdateScreenState createState() => _ServiceUpdateScreenState();
}

class _ServiceUpdateScreenState extends State<LogoUpdateScreen> {




  TextEditingController carNameEt= TextEditingController();
  FocusNode carNamefs= FocusNode();

  @override
  Widget build(BuildContext context) {
    Get.find<LogoController>().getLogoList(false);
    Get.find<LogoController>().SetpickImageNull();
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 3,
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black)),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Icon(
                    Icons.person_outline_rounded,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: GetBuilder<LogoController>(



            builder: (controller) {
              if(controller.logoList!=null&&controller.logoList!.length>0){
                carNameEt.text=controller.logoList![widget.logoIndex].name??"";


              }

              return controller.isLoading?Center(child: CircularProgressIndicator()):Container(
                color: Colors.white,
                padding: EdgeInsets.only(left: 30,right: 30),
                child: ListView(

                  children: [
                    SizedBox(height: 10,),
                    Text("Information",style: TextStyle(fontSize: 28,decoration: TextDecoration.underline,decorationColor: Color(0xff2E5BFF),),),
                    SizedBox(height: 10,),
                    Stack(
                      children: [
                        controller.pickedLogo != null?
                        Image.file(
                          File(controller.pickedLogo!.path), width: double.infinity, height: 120, fit: BoxFit.fill,
                        ):controller.logoList![widget.logoIndex].url!.substring(0,1)=="a"?Image.asset(controller.logoList![widget.logoIndex].url!,width: double.infinity,height: 120,fit: BoxFit.fitHeight): Image.file(
                          File(controller.logoList![widget.logoIndex].url!),  width: double.infinity,height: 120,fit: BoxFit.fitHeight,
                        ),

                        Container(
                            height: 120,
                            child:Center(child: GestureDetector(
                                onTap: (){
                                  controller.pickImage();
                                },
                                child: Image.asset("assets/images/camera.png",width: 50,height: 50,)))
                        )
                      ],
                    ) ,
                    CustomTextFieldWithTitle(hintText:"Enter Car Company Name",titleText: "Car Company Name",inputType:TextInputType.text, controller: carNameEt, focusNode: carNamefs,),


                    controller.isLoading?Center(child: CircularProgressIndicator()):CustomButton(buttonText:'UPDATE', onPressed: () { dataValidation(controller); },customColor: Color(0xff012A93),height: 45,),
                    SizedBox(height: 20,),
                    InkWell(
                      onTap: ()=>{
                        Get.back(),
                      },
                      child: Container(

                        child: Center(
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.all(Radius.circular(10))
                              ),

                              padding: EdgeInsets.only(top:10,bottom:10,left: 40,right: 40),
                              child: Image.asset("assets/images/home.png",width: 20,height: 20,)),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                  ],
                ),
              );
            }
        ),
      ),
    );
  }

  void dataValidation(LogoController controller){
    String businessName=carNameEt.text.trim();

    if (businessName.isNotEmpty) {
      controller.saveImageToDisk().then((value) {
        controller.updatelogoInfo(new Logo(
            id: controller.logoList![widget.logoIndex].id,
            url: value==null?controller.logoList![widget.logoIndex].url:value,
            name: businessName,
        )).then((value) async {
          if (value > 0) {
            await controller.getLogoList(true);

            Get.find<HomeController>().getLogoList(true);
            Get.back();
          }
          else {
            Get.snackbar("Error",
                "Logo did not Updated,Something Wrong!");
          }
        });
      });

    } else {
      Get.snackbar(
          "Empty", "Please Enter Logo Name", colorText: Colors.red);
    }

  }
}
