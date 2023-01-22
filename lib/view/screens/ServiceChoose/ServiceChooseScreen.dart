import 'package:car_wash_app/controller/home_controller.dart';
import 'package:car_wash_app/data/model/body/TempService.dart';
import 'package:car_wash_app/util/app_constants.dart';
import 'package:car_wash_app/view/screens/amountEntry/amountEntryScreen.dart';
import 'package:car_wash_app/view/screens/home/home_screen.dart';
import 'package:car_wash_app/view/screens/payment/paymentScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class ServicechooseScreen extends StatelessWidget {
   final String selectedCarModel;
   ServicechooseScreen({Key? key, required this.selectedCarModel,}) : super(key: key);
  TextEditingController serviceEt=new TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 3,
        title: Text("Services",style: TextStyle(color: Colors.black,fontSize: 16),),
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
        child: GetBuilder<HomeController>(
          
          builder: (controller) {
            return Padding(
              padding: const EdgeInsets.only(top:80,left: 15,right: 15,),
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                   Column(
                     children: [
                       InkWell(
                         onTap: (){
                           Get.to(PaymentScreen( selectedCarModel: selectedCarModel, selectedService:AppConstants.FULLWASH,));
                         },
                         child: Card(
                           elevation: 1,
                           child: Container(
                             padding: EdgeInsets.only(left: 20,top: 10,bottom: 10,right: 10),
                             child: Row(
                               children: [
                                 Container(

                                   child: Image.asset("assets/images/fullWash.png",height: MediaQuery.of(context).size.height/9,),
                                 ),
                                 SizedBox(width: 15),
                                 Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     Text("Full Wash",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.black),),

                                     Text("غسيل كامل ",textAlign:TextAlign.left,style: TextStyle(fontSize: 14,color: Color(0xff0800FF)),),
                                   ],
                                 )
                               ],
                             ),
                           ),
                         ),
                       ),
                       SizedBox(height: 10,),
                       InkWell(
                         onTap: (){
                           Get.to(PaymentScreen( selectedCarModel: selectedCarModel, selectedService:AppConstants.INTERIORWASH,));

                         },
                         child: Card(
                           elevation: 1,
                           child: Container(
                             padding: EdgeInsets.only(left: 20,top: 10,bottom: 10,right: 10),
                             child: Row(
                               children: [
                                 Container(

                                   child: Image.asset("assets/images/vaccuam.png",height: MediaQuery.of(context).size.height/9,),
                                 ),
                                 SizedBox(width: 15),
                                 Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     Text("Interior Wash",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.black),),

                                     Text("غسيل داخلي ",textAlign:TextAlign.left,style: TextStyle(fontSize: 14,color: Color(0xff0800FF)),),
                                   ],
                                 )
                               ],
                             ),
                           ),
                         ),
                       ),
                       SizedBox(height: 10,),
                       InkWell(
                         onTap: (){
                           Get.to(PaymentScreen( selectedCarModel: selectedCarModel, selectedService:AppConstants.EXTERIORWASH,));

                         },
                         child: Card(
                           elevation: 1,
                           child: Container(
                             padding: EdgeInsets.only(left: 20,top: 10,bottom: 10,right: 10),
                             child: Row(
                               children: [
                                 Container(

                                   child: Image.asset("assets/images/extroriar.png",height: MediaQuery.of(context).size.height/9,),
                                 ),
                                 SizedBox(width: 15),
                                 Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     Text("Exterior Wash",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.black),),

                                     Text("غسيل خارجي ",textAlign:TextAlign.left,style: TextStyle(fontSize: 14,color: Color(0xff0800FF)),),
                                   ],
                                 )
                               ],
                             ),
                           ),
                         ),
                       ),
                     ],
                   ),

                    Positioned(
                     bottom:20,
                      left: MediaQuery.of(context).size.width*0.37,
                      child: InkWell(
                        onTap: () {
                          //Get.find<HomeController>().tempList!.clear();
                          Get.back();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 28.0),
                              child: Container(
                                  alignment: Alignment.center,
                                  height: 40,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Icon(
                                    Icons.home,
                                    color: Colors.white,
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        ),
      ),
    );
  }
}
