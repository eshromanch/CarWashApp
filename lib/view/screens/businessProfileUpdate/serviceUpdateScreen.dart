import 'dart:ffi';
import 'dart:io';

import 'package:car_wash_app/controller/home_controller.dart';
import 'package:car_wash_app/controller/service_controller.dart';
import 'package:car_wash_app/data/model/response/login_response.dart';
import 'package:car_wash_app/view/base/custom_button.dart';
import 'package:car_wash_app/view/base/custom_text_field_with_title.dart';
import 'package:car_wash_app/view/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BusinessUpdateScreen extends StatefulWidget {

  BusinessUpdateScreen({Key? key,}) : super(key: key);

  @override
  _ServiceUpdateScreenState createState() => _ServiceUpdateScreenState();
}

class _ServiceUpdateScreenState extends State<BusinessUpdateScreen> {

  bool isUpdate=false;


  TextEditingController businessNameEt= TextEditingController();

  FocusNode businessNamefs= FocusNode();

  TextEditingController address1Et= TextEditingController();

   FocusNode address1fs= FocusNode();

  TextEditingController address2Et= TextEditingController();

   FocusNode address2fs= FocusNode();

  TextEditingController phoneEt= TextEditingController();

   FocusNode phonefs= FocusNode();

  TextEditingController emailEt= TextEditingController();

   FocusNode emailfs= FocusNode();

  TextEditingController websiteEt= TextEditingController();

   FocusNode websitefs= FocusNode();

  TextEditingController vatEt= TextEditingController();

   FocusNode vatfs= FocusNode();

  TextEditingController footerEt= TextEditingController();

   FocusNode footerfs= FocusNode();

  @override
  Widget build(BuildContext context) {
    Get.find<ServiceController>().getBusinessProfile(true);
    Get.find<ServiceController>().SetpickImageNull();
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 3,
        title: Text(
          "Business Details",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
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
        child: GetBuilder<ServiceController>(



          builder: (controller) {
            if(controller.serviceList!=null&&controller.serviceList!.length>0){
              businessNameEt.text=controller.serviceList![0].business_name??"";
              address1Et.text=controller.serviceList![0].address_line1??"";
              address2Et.text=controller.serviceList![0].address_line2??"";
              phoneEt.text=controller.serviceList![0].mobile??"";
              emailEt.text=controller.serviceList![0].email??"";
             // print(controller.serviceList![serviceIndex].website);
              websiteEt.text=controller.serviceList![0].website??"";
              vatEt.text=controller.serviceList![0].vat.toString()??"";
              footerEt.text=controller.serviceList![0].footer_note??"";
              isUpdate=true;
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
                      ):
                      isUpdate?Image.file(
                        File(controller.serviceList![0].logo_path!), width: double.infinity, height: 120, fit: BoxFit.fill,
                      ):SizedBox(),
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
                  CustomTextFieldWithTitle(hintText:"Enter Your Business Name",titleText: "Business Name", controller: businessNameEt, focusNode: businessNamefs,nextFocus:address1fs ,),
                  CustomTextFieldWithTitle(hintText:"Enter Your Address",titleText: "Address Line 1", controller: address1Et, focusNode: address1fs,nextFocus:address2fs ,),
                  CustomTextFieldWithTitle(hintText:"Enter Your Address",titleText: "Address Line 2", controller: address2Et, focusNode: address2fs,nextFocus:phonefs ,),
                  CustomTextFieldWithTitle(hintText:"Enter Your Phone Number",titleText: "Phone", controller: phoneEt, focusNode: phonefs,nextFocus:emailfs ,),
                  CustomTextFieldWithTitle(hintText:"Enter Your Email",titleText: "Email", controller: emailEt, focusNode: emailfs,nextFocus:websitefs ,),
                  CustomTextFieldWithTitle(hintText:"Enter Your Vat Number",titleText: "Vat Number", controller: websiteEt, focusNode: websitefs,nextFocus:vatfs ,),
                  CustomTextFieldWithTitle(hintText:"Enter VAT",titleText: "VAT", controller: vatEt, focusNode: vatfs,nextFocus:footerfs ,inputType: TextInputType.number,),
                  CustomTextFieldWithTitle(
                    inputType: TextInputType.multiline,

                    minLines: 4,maxLines: 5,
                    hintText:"Enter Footer Note",titleText: "Footer Note", controller: footerEt, focusNode: footerfs,),
                  SizedBox(height: 20,),
                  controller.isLoading?Center(child: CircularProgressIndicator()):CustomButton(buttonText:isUpdate? 'UPDATE':"ADD", onPressed: () { dataValidation(controller); },customColor: Color(0xff012A93),height: 45,),
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

  void dataValidation(ServiceController controller){
    String businessName=businessNameEt.text.trim();
    String addressl1=address1Et.text.trim();
    String addressl2=address2Et.text.trim();
    String phone=phoneEt.text.trim();
    String email=emailEt.text.trim();
    String vatNumber=websiteEt.text.trim();
    String vat=vatEt.text.trim();
    String footer=footerEt.text.trim();

      if (businessName.isNotEmpty) {
        if (addressl1.isNotEmpty) {
          if (addressl2.isNotEmpty) {
            if (phone.isNotEmpty) {
                if (vatNumber.isNotEmpty) {
                  if (vat.isNotEmpty) {
                    if (footer.isNotEmpty) {
                      controller.saveImageToDisk().then((value) {
                        isUpdate? controller.updateServiceInfo(new Service(
                            id: controller.serviceList![0].id,
                            email: email??null,
                            business_name: businessName,
                            website: vatNumber,
                            vat: double.parse(vat),
                            address_line1: addressl1,
                            address_line2: addressl2,
                            mobile: phone,
                            logo_path: value==null?controller.serviceList![0].logo_path:value,
                            footer_note: footer,
                            updatedAt: DateTime.now().toString()
                        )).then((value) async {
                          if (value > 0) {
                            await controller.getBusinessProfile(true);

                            Get.find<HomeController>().getLogoList(true);
                            Get.back();
                          }
                          else {
                            Get.snackbar("Error",
                                "Service did not Updated,Something Wrong!");
                          }
                        }): controller.submitServiceInfo(new Service(
                            email: email??null,
                            business_name: businessName,
                            website: vatNumber,
                            vat: double.parse(vat),
                            address_line1: addressl1,
                            address_line2: addressl2,
                            mobile: phone,
                            footer_note: footer,
                            logo_path: value,
                            createdAt: DateTime.now().toString(),
                            updatedAt: DateTime.now().toString()
                        )).then((value) async {
                          if (value > 0) {
                            await controller.getBusinessProfile(true);

                            Get.find<HomeController>().getLogoList(true);
                            Get.back();
                          }
                        });
                      });






                    } else {
                      Get.snackbar("Empty", "Please Enter your Footer Note",
                          colorText: Colors.red);
                    }
                  } else {
                    Get.snackbar("Empty", "Please Enter your VAT",
                        colorText: Colors.red);
                  }
                } else {
                  Get.snackbar("Empty", "Please Enter your Website Link",
                      colorText: Colors.red);
                }
            } else {
              Get.snackbar("Empty", "Please Enter your Phone Number",
                  colorText: Colors.red);
            }
          }
          else {
            Get.snackbar("Empty", "Please Enter your Address Line 2",
                colorText: Colors.red);
          }
        }
        else {
          Get.snackbar("Empty", "Please Enter your Address Line 1",
              colorText: Colors.red);
        }
      } else {
        Get.snackbar(
            "Empty", "Please Enter your Business Name", colorText: Colors.red);
      }

  }
}
