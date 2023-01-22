import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:car_wash_app/controller/home_controller.dart';
import 'package:car_wash_app/data/model/body/TempService.dart';
import 'package:car_wash_app/helper/date_converter.dart';
import 'package:car_wash_app/util/app_constants.dart';
import 'package:car_wash_app/view/screens/home/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:car_wash_app/data/model/response/login_response.dart';

import 'package:car_wash_app/view/screens/amountEntry/amountEntryScreen.dart';
import 'package:car_wash_app/view/screens/amountEntry/test.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sunmi_printer_plus/column_maker.dart';
import 'package:sunmi_printer_plus/enums.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';
import 'package:sunmi_printer_plus/sunmi_style.dart';

class PaymentScreen extends StatefulWidget {
  final String  selectedCarModel;
  final String selectedService;

  PaymentScreen({Key? key, required this.selectedCarModel, required this.selectedService, }) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String? paymentype=null;
  bool printBinded = false;
  int paperSize = 0;
  String serialNumber = "";
  String printerVersion = "";
  Uint8List? companyLogo = null;
  int selectedPaymentType=0;
  /*@override
  void initState() {
    super.initState();

    _bindingPrinter().then((bool? isBind) async {
      SunmiPrinter.paperSize().then((int size) {
        setState(() {
          paperSize = size;
        });
      });

      SunmiPrinter.printerVersion().then((String version) {
        setState(() {
          printerVersion = version;
        });
      });

      SunmiPrinter.serialNumber().then((String serial) {
        setState(() {
          serialNumber = serial;
        });
      });

      setState(() {
        printBinded = isBind!;
      });
    });
  }

  Future<bool?> _bindingPrinter() async {
    final bool? result = await SunmiPrinter.bindingPrinter();
    return result;
  }*/

  @override
  Widget build(BuildContext context) {
   // int size=Get.find<HomeController>().tempList!.length;
   // print(size);
    print(widget.selectedService);
    return Scaffold(
      appBar:AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 3,
        title: Text("Payment",style: TextStyle(color: Colors.black,fontSize: 16),),
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
        child:SingleChildScrollView(
          child: Container(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height/8,),
                  Padding(
                    padding: const EdgeInsets.only(left: 45.0,right: 45,top:20,bottom: 10),
                    child: InkWell(
                      onTap: ()=>{

                        Get.to(AmountEntry(selectedCarModel: widget.selectedCarModel,
                            selectedService: widget.selectedService, selectedPaymentType: AppConstants.CASH))
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset("assets/images/wallet.png",width: 70,height: 70,color:Colors.black,),
                          SizedBox(height: 10,),
                          Text("CASH",style: TextStyle(fontSize: 20,color: Colors.black),)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.only(left: 45.0,right: 45,top:20,bottom: 10),
                    child: InkWell(
                      onTap: ()=>{

                         Get.to(AmountEntry(selectedCarModel: widget.selectedCarModel,
                      selectedService: widget.selectedService, selectedPaymentType: AppConstants.CARD))
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset("assets/images/credit-cards-payment.png",width: 70,height: 70,color: Colors.black),
                          SizedBox(height: 10,),
                          Text("CARD",style: TextStyle(color:Colors.black,fontSize: 20),)
                        ],
                      ),
                    ),
                  ),

                /*  InkWell(
                    onTap: () {

                      if(paymentype!=null&&paymentype!.isNotEmpty&&selectedPaymentType!=0){
                        *//*Service service=Get.find<HomeController>().serviceList![widget.selectedItem];
                        List<TempService>? tempList=Get.find<HomeController>().tempList;
                        if(service!=null&&tempList!=null){
                          printInvoice(service,tempList);
                        }*//*

                      }else{
                        Get.snackbar("Error","Please select payment type");
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 28.0),
                      child: Container(
                        alignment: Alignment.center,
                        height: 40,
                        width: 100,
                        decoration: BoxDecoration(
                          color: HexColor("#1F54C3"),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "Next",
                          style: TextStyle(
                              fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ),*/
                  SizedBox(height: MediaQuery.of(context).size.height/4,),
                  InkWell(
                    onTap: ()=>{
                     // Get.find<HomeController>().tempList!.clear(),
                      Get.back(),
                      Get.back()
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
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /*Future<void> printInvoice(Service service,List<TempService> tempList ) async {
    String path=service.logo_path!;
    await _readFileByte(path);
    String time = DateConverter.formatDate(DateTime.now());
    //subtotal===
    double subtoal=0;
    tempList.map((e) {
     // subtoal=subtoal+double.parse(e.servicePrice!);
    }).toList();
    //vat=====
    double vat=0;
    if(service.vat!=null&&service.vat!>0){
      print(service.vat);
      vat=(subtoal*service.vat!)/100;
    }

    //total bill
    double total=subtoal+vat;

   //random Number========
    int randomnum=getRandom();


    print(time);
    print(vat);
    print(subtoal);
    print(randomnum.toString());


    await SunmiPrinter.initPrinter();
    await SunmiPrinter.startTransactionPrint(true);

    if (companyLogo != null) {
      await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
      await SunmiPrinter.printImage(companyLogo!);
      await SunmiPrinter.lineWrap(1);
    }
    await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
    await SunmiPrinter.printText(service.business_name!,style: SunmiStyle(bold: true,fontSize: SunmiFontSize.MD));

    await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
    await SunmiPrinter.printText(service.address_line1!+service.address_line2!);

    await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
    await SunmiPrinter.printText("Tell:"+service.mobile!);

    await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
    await SunmiPrinter.printText("Email:"+service.email!);

    await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
    await SunmiPrinter.printText(service.website!);


    await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
    await SunmiPrinter.printBarCode(randomnum.toString(),
        barcodeType: SunmiBarcodeType.CODE128,
        textPosition: SunmiBarcodeTextPos.TEXT_UNDER,
        height: 50);


    await SunmiPrinter.line();
    await SunmiPrinter.printText('Date:'+time,
        style: SunmiStyle(align: SunmiPrintAlign.LEFT));
    await SunmiPrinter.printText('Operator:Sales Team',
        style: SunmiStyle(align: SunmiPrintAlign.LEFT));
    await SunmiPrinter.line();
    await SunmiPrinter.printRow(cols: [
      ColumnMaker(
          text: 'Description',
          width: 15,
          align: SunmiPrintAlign.LEFT),
      ColumnMaker(
          text: 'Total',
          width: 15,
          align: SunmiPrintAlign.RIGHT),
    ]);
    await SunmiPrinter.line();

   tempList.map((e) async {

     await SunmiPrinter.printRow(cols: [
       ColumnMaker(
           text: e.serviceName!,
           width: 22,
           align: SunmiPrintAlign.LEFT),
       ColumnMaker(
          // text: e.servicePrice!,
           width: 8,
           align: SunmiPrintAlign.RIGHT),
     ]);
   }).toList();
    await SunmiPrinter.line();
    await SunmiPrinter.printText('Sub Total:'+subtoal.toString(),
        style: SunmiStyle(align: SunmiPrintAlign.RIGHT));
    await SunmiPrinter.printText('VAT('+service.vat.toString()+'%):'+vat.toString(),
        style: SunmiStyle(align: SunmiPrintAlign.RIGHT));
    await SunmiPrinter.setAlignment(SunmiPrintAlign.RIGHT);
    await SunmiPrinter.line(len:20);
    await SunmiPrinter.printText('Net Payable :'+total.toString(),
        style: SunmiStyle(align: SunmiPrintAlign.RIGHT,bold: true));

    await SunmiPrinter.lineWrap(1);
    await SunmiPrinter.printText('***'+paymentype.toString()+'***',
        style: SunmiStyle(align: SunmiPrintAlign.CENTER,bold: true));
    await SunmiPrinter.lineWrap(1);
    await SunmiPrinter.printText('***',
        style: SunmiStyle(align: SunmiPrintAlign.CENTER,bold: true));
    await SunmiPrinter.lineWrap(1);
    if(service.footer_note!=null){
      await SunmiPrinter.printText(service.footer_note!,
          style: SunmiStyle(align: SunmiPrintAlign.CENTER,fontSize:SunmiFontSize.SM ,bold: true));
    }
    await SunmiPrinter.lineWrap(3);
    await SunmiPrinter
        .submitTransactionPrint(); // submit and start print, you can keep submit while in loop
// remember to exit the transaction mode after finish printing.
    await SunmiPrinter.exitTransactionPrint(true);



  }



  Future<void>? _readFileByte(String filePath) async {
    Uri myUri = Uri.parse(filePath);
    File audioFile = new File.fromUri(myUri);

    await audioFile.readAsBytes().then((value) {
      companyLogo = Uint8List.fromList(value);
      print('reading of bytes is completed');
    }).catchError((onError) {
      print('Exception Error while reading audio from path:' +
          onError.toString());
    });

  }
  int getRandom() {
    var rng = new Random();
    var code = rng.nextInt(90000000) + 10000000;
    return code;
  }*/
}
