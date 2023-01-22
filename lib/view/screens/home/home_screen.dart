import 'dart:io';

import 'package:car_wash_app/controller/logo_controller.dart';
import 'package:car_wash_app/data/model/body/TempService.dart';
import 'package:car_wash_app/view/base/custom_text_field.dart';
import 'package:car_wash_app/view/base/custom_text_field_forSearch.dart';
import 'package:car_wash_app/view/screens/ServiceChoose/ServiceChooseScreen.dart';
import 'package:car_wash_app/view/screens/amountEntry/amountEntryScreen.dart';
import 'package:car_wash_app/view/screens/businessProfileUpdate/serviceUpdateScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:car_wash_app/controller/history_controller.dart';
import 'package:car_wash_app/controller/home_controller.dart';
import 'package:car_wash_app/view/base/custom_drawer/custom_drawer.dart';
import 'package:car_wash_app/view/screens/payment/paymentScreen.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    Get.find<HomeController>().getLogoList(true);

    super.initState();
  }

  TextEditingController searchfield = TextEditingController();
  FocusNode searchfieldFs = FocusNode();

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(), () => SystemChannels.textInput.invokeMethod('TextInput.hide'));
    return Scaffold(
      drawer: CustomDrawerTwo(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 3,
        title: Text(
          "Car Wash Pro",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: InkWell(
              onTap: (){
                Get.to(BusinessUpdateScreen());
              },
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
          ),
        ],
      ),
      // drawer: CustomDrawerTwo(),
      body: GetBuilder<HomeController>(builder: (homeController) {
        return SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Card(
                        elevation: 2,
                        child: Container(
                          child: CustomTextFieldForSearch(
                            suffunc: (){
                              if(FocusManager.instance.primaryFocus!.hasPrimaryFocus){
                                FocusManager.instance.primaryFocus?.unfocus();
                              }
                              homeController.setLogoListByKeywordEmty(true);
                             // FocusManager.instance.primaryFocus?.unfocus();
                              searchfield.text="";
                            },
                            prefixIcon: Icons.search,

                            focusNode: searchfieldFs,
                            controller: searchfield,
                            onChanged: (_) {
                              print("hii");
                              if (searchfield.text.isNotEmpty) {
                                homeController.getLogoListByKeyword(
                                    true, searchfield.text);
                              }else{
                                homeController.setLogoListByKeywordEmty(true);
                              }
                            }, onSubmit:(_){
                              print("hi");
                          },
                          ),
                        ),
                      ),
                    ),
                    homeController.isLoading?Center(child: CircularProgressIndicator(),):

                    homeController.isSearchMood?
                    homeController.searchLogoList!=null&&homeController.searchLogoList!.length>0?
                    Container(
                      padding:
                      EdgeInsets.only(top: 20, left: 10, right: 10),
                      child: GridView.builder(
                        key: UniqueKey(),
                        shrinkWrap: true,
                        gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 3,
                          mainAxisSpacing: 3,
                          childAspectRatio: 1.3,
                          crossAxisCount: 3,
                        ),
                        physics: BouncingScrollPhysics(),
                        itemCount: homeController.searchLogoList!.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              homeController
                                  .isServiceListexist()
                                  .then((value) {
                                if (value) {
                                  Get.to(ServicechooseScreen(
                                    selectedCarModel: homeController
                                        .searchLogoList![index].name!,
                                  ));
                                } else {
                                  Get.snackbar("Error",
                                      "Please Add Business Details",
                                      colorText: Colors.red);
                                }
                              });
                              //  homeController.setTempList(new TempService(homeController.serviceList![index].business_name, null, null, null,null));
                            },
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: Card(
                                  elevation: 2,
                                  child: Container(
                                    padding: EdgeInsets.all(0),
                                    child: homeController
                                        .searchLogoList![index].url!
                                        .substring(0, 1) ==
                                        "a"
                                        ? Image.asset(homeController
                                        .searchLogoList![index].url!)
                                        : Image.file(
                                      File(homeController
                                          .searchLogoList![index].url!),
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ):
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Center(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 150,
                            ),
                            Icon(
                              Icons.miscellaneous_services_outlined,
                              size: 40,
                              color: Colors.red,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "No data found",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.red, fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    )
                    :homeController.logoList != null && homeController.logoList!.length > 0
                        ? Container(
                            padding:
                                EdgeInsets.only(top: 20, left: 10, right: 10),
                            child: GridView.builder(
                              key: UniqueKey(),
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisSpacing: 3,
                                mainAxisSpacing: 3,
                                childAspectRatio: 1.3,
                                crossAxisCount: 3,
                              ),
                              physics: BouncingScrollPhysics(),
                              itemCount: homeController.logoList!.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {

                                    FocusManager.instance.primaryFocus?.unfocus();
                                    homeController
                                        .isServiceListexist()
                                        .then((value) {
                                      if (value) {
                                        Get.to(ServicechooseScreen(
                                          selectedCarModel: homeController
                                              .logoList![index].name!,
                                        ));
                                      } else {
                                        Get.snackbar("Error",
                                            "Please Add Business Details",
                                            colorText: Colors.red);
                                      }
                                    });
                                    //  homeController.setTempList(new TempService(homeController.serviceList![index].business_name, null, null, null,null));
                                  },
                                  child: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(0.0),
                                      child: Card(
                                        elevation: 2,
                                        child: Container(
                                          padding: EdgeInsets.all(0),
                                          child: homeController
                                                      .logoList![index].url!
                                                      .substring(0, 1) ==
                                                  "a"
                                              ? Image.asset(homeController
                                                  .logoList![index].url!)
                                              : Image.file(
                                                  File(homeController
                                                      .logoList![index].url!),
                                                  fit: BoxFit.fitWidth,
                                                ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        : Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            child: Center(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 200,
                                  ),
                                  Icon(
                                    Icons.miscellaneous_services_outlined,
                                    size: 40,
                                    color: Colors.red,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "No Car is Added",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                          )
                  ],
                ),
              );
      }),
    );
  }

  toggleDrawer() async {
    if (_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState!.openEndDrawer();
    } else {
      _scaffoldKey.currentState!.openDrawer();
    }
  }
}
