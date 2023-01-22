import 'dart:io';

import 'package:car_wash_app/controller/home_controller.dart';
import 'package:car_wash_app/controller/logo_controller.dart';
import 'package:car_wash_app/controller/service_controller.dart';
import 'package:car_wash_app/view/screens/LogoUpdate/logoUpdate.dart';
import 'package:car_wash_app/view/screens/logoAdd/LogoAddScreen.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogoEditScreen extends StatefulWidget {
  const LogoEditScreen({Key? key}) : super(key: key);

  @override
  _ServiceScreenState createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<LogoEditScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.find<LogoController>().getLogoList(true);
  }

  @override
  Widget build(BuildContext context) {
   // Get.find<HomeController>().getserviceList();

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 3,
        title: Text(
          "Car Edit",
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
        child: GetBuilder<LogoController>(

          builder: (controller) {
            return controller.isLoading?Container(child: Center(child: CircularProgressIndicator())):SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0,right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Cars",style: TextStyle(color: Colors.black,fontSize: 20,decoration: TextDecoration.underline,),),
                        InkWell(
                            onTap: (){
                              Get.to(LogoAddScreen());
                            },
                            child: Icon(Icons.add,size: 25,color: Color(0xff2E5BFF),))
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  controller.logoList!=null&&controller.logoList!.length>0?Padding(
                      padding: const EdgeInsets.only(left: 10.0,right: 10),
                      child: GridView.builder(
                        key: UniqueKey(),
                        shrinkWrap: true,

                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(

                          crossAxisSpacing: 5,
                          mainAxisSpacing:  3,
                          childAspectRatio: 0.90,
                          crossAxisCount: 3,
                        ),
                        physics: BouncingScrollPhysics(),

                        itemCount: controller.logoList!.length,

                        itemBuilder: (context, index) {
                          return Stack(

                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: (){
                                     Get.to(LogoUpdateScreen(logoIndex: index,));
                                  },
                                  child: Card(
                                    elevation: 2,
                                    child: Container(
                                      // height: 100,
                                      padding: EdgeInsets.all(0),
                                      child:controller.logoList![index].url!.substring(0,1)=="a"?Image.asset(controller.logoList![index].url!): Image.file(
                                        File(controller.logoList![index].url!),  fit: BoxFit.fitWidth,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                  top:0,
                                  right: 0,
                                  child: InkWell(
                                      onTap: ()=>{
                                        controller.deletLogo(controller.logoList![index]).then((value) {
                                          if(value!>0){
                                            Get.snackbar("Hurrah", "Successfully Deleted");
                                            controller.getLogoList(true);
                                            Get.find<HomeController>().getLogoList(true);
                                          }
                                        })
                                      },
                                      child: Icon(Icons.cancel_rounded,color: Color(0xff2E5BFF),size: 25,)))
                            ],
                          );
                        },
                      )/*ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: controller.logoList!.length,
                        itemBuilder: (_, index) {

                          return Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: (){
                                   // Get.to(ServiceUpdateScreen(serviceIndex: index));
                                  },
                                  child: Card(

                                    elevation: 2,
                                    child: Container(

                                      padding: EdgeInsets.all(20),
                                      child: Image.file(
                                        File(controller.logoList![index].url!), width: double.infinity, height: 80, fit: BoxFit.fitHeight,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                  top:0,
                                  right: 0,
                                  child: InkWell(
                                      onTap: ()=>{
                                        controller.deletLogo(controller.logoList![index]).then((value) {
                                          if(value!>0){
                                            Get.snackbar("Hurrah", "Successfully Deleted");
                                            controller.getLogoList(true);
                                            Get.find<HomeController>().getLogoList(true);
                                          }
                                        })
                                      },
                                      child: Icon(Icons.cancel_rounded,color: Color(0xff2E5BFF),size: 35,)))
                            ],
                          );
                        },
                      ),*/
                  ):Container(child: Center(child: Text("No Car Added Yet"))),

                ],
              ),
            );
          }
        ),
      ),
    );
  }
}
