import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:car_wash_app/controller/service_controller.dart';
import 'package:car_wash_app/data/model/response/login_response.dart';
import 'package:car_wash_app/helper/date_converter.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';


import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:sunmi_printer_plus/column_maker.dart';
import 'package:sunmi_printer_plus/enums.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';
import 'package:sunmi_printer_plus/sunmi_style.dart';

class AmountEntry extends StatefulWidget {

  final String selectedCarModel;
  final String selectedService;
  final String selectedPaymentType;

  //final String cashOrCard;
  const AmountEntry(
      {Key? key, required this.selectedCarModel, required this.selectedService, required this.selectedPaymentType,
        })
      : super(key: key);

  @override
  _AmountEntryState createState() => _AmountEntryState();
}

class _AmountEntryState extends State<AmountEntry> {
  TextEditingController amountController = TextEditingController();
  bool printBinded = false;
  int paperSize = 0;
  String serialNumber = "";
  String printerVersion = "";
  int currentItem = 0;
  Uint8List? companyLogo = null;


  final List<Map<String, dynamic>> data = [];
  final f = NumberFormat("\$###,###.00", "en_US");
  double inputData = 0;

  @override
  void initState() {

    super.initState();

    _bindingPrinter().then((bool? isBind) async {
      SunmiPrinter.getPrinterStatus().then((value) => print(value.toString()));
      SunmiPrinter.paperSize().then((int size) {
        paperSize = size;
      });

      SunmiPrinter.printerVersion().then((String version) {
        printerVersion = version;
      });

      SunmiPrinter.serialNumber().then((String serial) {
        serialNumber = serial;
      });

      printBinded = isBind!;

      /*_getPrinterStatus();
        _getPrinterMode();*/
    });


  }



  Future<bool?> _bindingPrinter() async {
    final bool? result = await SunmiPrinter.bindingPrinter();
    return result;
  }

  @override
  Widget build(BuildContext context) {


    //  EasyLoading.showToast("paper->$paperSize \nprintBinded->$printBinded \nserialNumber->$serialNumber \nprinterVersion->$printerVersion ");

    return Scaffold(


      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 3,
        title: Text(
          "Amount",
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
      //drawer: CustomDrawerTwo(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Padding(
                padding: const EdgeInsets.only(left: 35.0, right: 28, top: 25),
                child: Card(
                  elevation: 6,
                  child: Container(
                    height: 250,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding:
                          const EdgeInsets.only(left: 28.0, right: 18.0),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: amountController,
                            decoration: InputDecoration(
                                hintText: "Amount",
                                hintStyle: TextStyle(fontSize: 24),
                                contentPadding: EdgeInsets.only(left: 70)),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            datavalidation();
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
                                "Print",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
            SizedBox(
              height: MediaQuery.of(context).size.height/3,
            ),
            InkWell(
              onTap: () {
                Get.back();
                Get.back();
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
                        height: 45,
                        width: 140,
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
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
  void datavalidation() {
    String ammount = amountController.text.trim();

    if (!ammount.isEmpty) {
      double ammountDouble = double.parse(ammount);
      if (ammountDouble > 0) {
        printInvoice(ammount);
        //createInvoice(ammountDouble.toString());
      } else {
        Get.snackbar("Error", "Enter Valid amount",colorText: Colors.red);

      }
    } else {
      Get.snackbar("Error", "Enter  amount",colorText: Colors.red);
    }
  }


  Future<void> printInvoice(String amount ) async {
    Service service=Get.find<ServiceController>().serviceList![0];
    double subtoal=double.parse(amount);
    String time = DateConverter.formatDate(DateTime.now());
    if(service!=null){

      //vat=====
      double vat=0;
      if(service.vat!=null&&service.vat!>0){
        print(service.vat);
        vat=(subtoal*service.vat!)/100;
      }
      subtoal=subtoal-vat;


      String qrCode = qrCodeGentor(
          service.business_name!,
          service!.website.toString(),
          time,
          subtoal.toStringAsFixed(2),
          vat.toString());

    String path=service.logo_path!;
    await _readFileByte(path);

    //subtotal===





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

    if(service.email!=null&&service.email!.isNotEmpty){
      await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
      await SunmiPrinter.printText("Email:"+service.email!);
    }

      await SunmiPrinter.lineWrap(1);
    await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
    await SunmiPrinter.printText("VAT "+service.website!);

    await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
    await SunmiPrinter.printBarCode(randomnum.toString(),
        barcodeType: SunmiBarcodeType.CODE128,
        textPosition: SunmiBarcodeTextPos.TEXT_UNDER,
        height: 50);
      await SunmiPrinter.lineWrap(1);

    await SunmiPrinter.line();

      await SunmiPrinter.setAlignment(SunmiPrintAlign.RIGHT);
      //await SunmiPrinter.printText('$dateالتاريخ: ');
      await SunmiPrinter.printText('$time'+':'+'التاريخ');

      await SunmiPrinter.setAlignment(SunmiPrintAlign.RIGHT);
      // await SunmiPrinter.printText('${res.invoiceShow!.invoiceNo!}رقم الفاتوره:');

      await SunmiPrinter.printText('${randomnum}'+':'+' رقم الفاتوره');

      await SunmiPrinter.setAlignment(SunmiPrintAlign.RIGHT);
      // await SunmiPrinter.printText('Cash Invoice :فاتوره كاش');
      await SunmiPrinter.printText('Cash Invoice'+':'+'فاتوره نقداً');
      await SunmiPrinter.setAlignment(SunmiPrintAlign.RIGHT);
      // await SunmiPrinter.printText('${res.adminInfo!.name!}امين الصندوق: ');
      await SunmiPrinter.printText('${service.business_name}'+':'+'امين الصندوق');
     /* await SunmiPrinter.printRow(cols: [
        ColumnMaker(
            text: time,
            width: 15,
            align: SunmiPrintAlign.LEFT),
        ColumnMaker(
          text: 'التاريخ',
          width: 15,
          align: SunmiPrintAlign.RIGHT),



      ]);
      await SunmiPrinter.lineWrap(1);
     await SunmiPrinter.printRow(cols: [
        ColumnMaker(
            text: randomnum.toString(),
            width: 15,
            align: SunmiPrintAlign.LEFT),
        ColumnMaker(
            text: 'رقم الفاتوره',
            width: 15,
            align: SunmiPrintAlign.RIGHT),
      ]);*/
      /*
      await SunmiPrinter.printRow(cols: [
        ColumnMaker(
            text: "Cash Invoice",
            width: 15,
            align: SunmiPrintAlign.LEFT),
        ColumnMaker(
            text: 'فاتوره نقداً',
            width: 15,
            align: SunmiPrintAlign.RIGHT),
      ]);
      await SunmiPrinter.printRow(cols: [
        ColumnMaker(
            text: service.business_name.toString(),
            width: 15,
            align: SunmiPrintAlign.LEFT),
        ColumnMaker(
            text: 'امين الصندوق',
            width: 15,
            align: SunmiPrintAlign.RIGHT),
      ]);*/

      await SunmiPrinter.line();


      await SunmiPrinter.printText('Car(السيارات): '+widget.selectedCarModel,
          style: SunmiStyle(align: SunmiPrintAlign.LEFT));
    await SunmiPrinter.printText('Service(خدمة): '+widget.selectedService,
        style: SunmiStyle(align: SunmiPrintAlign.LEFT));

    await SunmiPrinter.printText('Price(السعر): '+subtoal.toStringAsFixed(2),
        style: SunmiStyle(align: SunmiPrintAlign.LEFT));
    await SunmiPrinter.line();

     // subtotal
      await SunmiPrinter.printText('subtotal(المجموع الفرعي)'+subtoal.toStringAsFixed(2),
          style: SunmiStyle(align: SunmiPrintAlign.LEFT));

      await SunmiPrinter.setAlignment(SunmiPrintAlign.LEFT);
      await SunmiPrinter.printText(
          'Vat(VAT '+service.vat.toString()+'%):' +'${vat.toStringAsFixed(2)}'+ 'SAR');

      await SunmiPrinter.setAlignment(SunmiPrintAlign.LEFT);
      await SunmiPrinter.printText(
        '(الضريبة ١٥٪؜)',
      );


      await SunmiPrinter.setAlignment(SunmiPrintAlign.LEFT);
      await SunmiPrinter.printText(
          'Net Price: ${amount} SAR',
          style: SunmiStyle(bold: true));
      await SunmiPrinter.setAlignment(SunmiPrintAlign.LEFT);
      await SunmiPrinter.printText(
          "(المجموع شامل الضريبة)",
          style: SunmiStyle(bold: true));


      /* await SunmiPrinter.printRow(cols: [
      ColumnMaker(
          text: 'Description',
          width: 15,
          align: SunmiPrintAlign.LEFT),
      ColumnMaker(
          text: 'Total',
          width: 15,
          align: SunmiPrintAlign.RIGHT),
    ]);
    await SunmiPrinter.line();*/

  /*  tempList.map((e) async {

      await SunmiPrinter.printRow(cols: [
        ColumnMaker(
            text: e.serviceName!,
            width: 22,
            align: SunmiPrintAlign.LEFT),
        ColumnMaker(
            text: e.servicePrice!,
            width: 8,
            align: SunmiPrintAlign.RIGHT),
      ]);
    }).toList();*/
   /* await SunmiPrinter.line();
    await SunmiPrinter.printText('Sub Total:'+subtoal.toString(),
        style: SunmiStyle(align: SunmiPrintAlign.RIGHT));
    await SunmiPrinter.printText('VAT('+service.vat.toString()+'%):'+vat.toString(),
        style: SunmiStyle(align: SunmiPrintAlign.RIGHT));
    await SunmiPrinter.setAlignment(SunmiPrintAlign.RIGHT);
    await SunmiPrinter.line(len:20);
    await SunmiPrinter.printText('Net Payable :'+total.toString(),
        style: SunmiStyle(align: SunmiPrintAlign.RIGHT,bold: true));
*/
    await SunmiPrinter.lineWrap(1);
    await SunmiPrinter.printText('***'+widget.selectedPaymentType.toString()+'***',
        style: SunmiStyle(align: SunmiPrintAlign.CENTER,bold: true));

      await SunmiPrinter.lineWrap(1);
      await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
      await SunmiPrinter.printQRCode(qrCode);


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
  }



 /* createInvoice(String price) async {
    int id = widget.list!.elementAt(currentItem).id != null
        ? int.parse("${widget.list!.elementAt(currentItem).id}")
        : 0;
    //double price=double.parse(inputData.toString());
    EasyLoading.show(maskType: EasyLoadingMaskType.clear);

    Get.find<HomeController>()
        .getInvoice(id.toString(), price)
        .then((status) async {
      EasyLoading.dismiss();
      if (status.isSuccess) {
        EasyLoading.showToast(status.message,
            toastPosition: EasyLoadingToastPosition.bottom);

        CreatedInvoiceResponse createdInvoiceResponse =
        Get.find<HomeController>().createdInvoiceResponse!;
        if(createdInvoiceResponse!.adminInfo!=null){
          _printTicket(createdInvoiceResponse);
        }

      } else {
        showCustomSnackBar(status.message);
      }
    });
  }

  Future<void> _getPrinterStatus() async {
    try {
      final PrinterStatus result = await SunmiPrinter.getPrinterStatus();
      log(result.toString());
      _printerStatus = result;
    } catch (e) {
      log("_printerStatus Errorr");
    }
  }

  Future<void> _printTicket(CreatedInvoiceResponse res) async {
    List<String> adresslist = res.adminInfo!.address!.split(',');
    // log(adresslist[0]);
    *//* await SunmiPrinter.initPrinter();
      await SunmiPrinter.startTransactionPrint(true);*//*
    *//* await SunmiPrinter.printText('Very small!', style: SunmiStyle(fontSize: SunmiFontSize.XS));
      await SunmiPrinter.lineWrap(2);

      await SunmiPrinter.exitTransactionPrint(true);
      final List<int> _escPos = await _customEscPos(res);*//*
    var isInternet = await CheckInternetConectivity.checkInternet();
    if (isInternet != null && isInternet) {
      companyLogo = (await NetworkAssetBundle(
          Uri.parse(AppConstants.IMAGE_BASE_URL + res.adminInfo!.image!))
          .load(AppConstants.IMAGE_BASE_URL + res.adminInfo!.image!))
          .buffer
          .asUint8List();
    }
    else{
      String path=Get.find<AuthController>().getsaveImageFromLocalStorag();
      await _readFileByte(path);
    }

    EasyLoading.showToast("Printer Status: $_printerStatus",
        duration: Duration(milliseconds: 1000),
        toastPosition: EasyLoadingToastPosition.bottom);
    await Future.delayed(Duration(milliseconds: 800));
    EasyLoading.showToast("Printing.....",
        duration: Duration(milliseconds: 1500),
        toastPosition: EasyLoadingToastPosition.bottom);
    EasyLoading.show(status: "Printing...");
    // String date = DateTime.now().toLocal().toString().split(" ")[0];
    String time = DateConverter.formatDate(DateTime.now());

    *//*var price = res.invoiceShow!.price;
    var sprice = price!.toStringAsFixed(2);
    var myliter = double.parse("${res.invoiceShow!.litter}").toStringAsFixed(2);
    var ammount = double.parse("${res.invoiceShow!.amount}").toStringAsFixed(2);

    var withoutvarprice =
        double.parse((price * double.parse(myliter)).toStringAsFixed(2));
    var vat = double.parse(
        (withoutvarprice * double.parse("${res.invoiceShow!.vat}") / 100)
            .toStringAsFixed(2));
    var net = withoutvarprice + vat;
    *//*
    double withoutvarprice =
    (res.invoiceShow!.amount! - res.invoiceShow!.vatPrice!);
    var liter = double.parse(res.invoiceShow!.litter!);

    //final profile = await CapabilityProfile.load();
    //final generator = Generator(PaperSize.mm58, profile);
    String qrCode = qrCodeGentor(
        res.adminInfo!.name!,
        res.adminInfo!.vatNumber.toString(),
        res.invoiceShow!.createdAt!.toString(),
        res.invoiceShow!.amount!.toStringAsFixed(2),
        res.invoiceShow!.vatPrice.toString());

    try {
      // log("$sprice - $myliter - $withoutvarprice -$vat $net ");
      log("_printerStatus" + _printerStatus.toString());
      if (_printerStatus != PrinterStatus.ABNORMAL_COMMUNICATION) {
        await SunmiPrinter.initPrinter();
        await SunmiPrinter.startTransactionPrint(true);
        // Enter into the transaction mode
        await SunmiPrinter.startTransactionPrint(true);
        // Set whatever alignment u like

        if (companyLogo != null) {
          await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
          await SunmiPrinter.printImage(companyLogo!);
          await SunmiPrinter.lineWrap(1);
        }
        await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
        await SunmiPrinter.printText(res.adminInfo!.businessName!,style: SunmiStyle(bold: true));


        adresslist.map((e) async {
          await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
          await SunmiPrinter.printText(e, style: SunmiStyle(bold: true));
        }).toList();

        //  await SunmiPrinter.printText('Jeddah, Saudi Arabia.');
        await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
        await SunmiPrinter.printText(res.adminInfo!.mobile!);
        await SunmiPrinter.lineWrap(1);

        await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
        await SunmiPrinter.printText("C.R. No.: " + res.adminInfo!.tinNumber!);

        await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
        await SunmiPrinter.printText("Vat " + res.adminInfo!.vatNumber!);

        await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
        await SunmiPrinter.printBarCode(res.invoiceShow!.invoiceNo!,
            barcodeType: SunmiBarcodeType.CODE128,
            textPosition: SunmiBarcodeTextPos.TEXT_UNDER,
            height: 40);
        await SunmiPrinter.lineWrap(1);

        await SunmiPrinter.line();
        await SunmiPrinter.setAlignment(SunmiPrintAlign.RIGHT);
        //await SunmiPrinter.printText('$dateالتاريخ: ');
        await SunmiPrinter.printText('$time'+':'+'التاريخ');

        await SunmiPrinter.setAlignment(SunmiPrintAlign.RIGHT);
        // await SunmiPrinter.printText('${res.invoiceShow!.invoiceNo!}رقم الفاتوره:');

        await SunmiPrinter.printText('${res.invoiceShow!.invoiceNo!}'+':'+'رقم الفاتوره');

        await SunmiPrinter.setAlignment(SunmiPrintAlign.RIGHT);
        // await SunmiPrinter.printText('Cash Invoice :فاتوره كاش');
        await SunmiPrinter.printText('Cash Invoice'+':'+'فاتوره نقداً');
        await SunmiPrinter.setAlignment(SunmiPrintAlign.RIGHT);
        // await SunmiPrinter.printText('${res.adminInfo!.name!}امين الصندوق: ');
        await SunmiPrinter.printText('${res.adminInfo!.name!}'+':'+'امين الصندوق');
        await SunmiPrinter.line();

        await SunmiPrinter.setAlignment(SunmiPrintAlign.LEFT);
        await SunmiPrinter.printText(
          'Gas Type(نوع الغاز): ${res.invoiceShow!.name ?? " "}',
        );
        await SunmiPrinter.setAlignment(SunmiPrintAlign.LEFT);

        await SunmiPrinter.printText(
            'Litter(قمامة) : ${liter.toStringAsFixed(2)}');

        await SunmiPrinter.setAlignment(SunmiPrintAlign.LEFT);
        await SunmiPrinter.printText(
            'Litter Price(لتر سعر التر): ${res.invoiceShow!.price!.toStringAsFixed(2)}SAR');

        await SunmiPrinter.line();

        await SunmiPrinter.setAlignment(SunmiPrintAlign.LEFT);

        await SunmiPrinter.printText(
          'Price Before VAT: ${withoutvarprice.toStringAsFixed(2)} SAR',
        );
        await SunmiPrinter.setAlignment(SunmiPrintAlign.LEFT);

        await SunmiPrinter.printText(
          '(السعر قبل الضريبة)',
        );

        await SunmiPrinter.setAlignment(SunmiPrintAlign.LEFT);
        await SunmiPrinter.printText(
            'Vat(VAT 15%): ${res.invoiceShow!.vatPrice!.toStringAsFixed(2)} SAR');

        await SunmiPrinter.setAlignment(SunmiPrintAlign.LEFT);
        await SunmiPrinter.printText(
          '(الضريبة ١٥٪؜)',
        );


        await SunmiPrinter.setAlignment(SunmiPrintAlign.LEFT);
        await SunmiPrinter.printText(
            'Net Price: ${res.invoiceShow!.amount} SAR',
            style: SunmiStyle(bold: true));
        await SunmiPrinter.setAlignment(SunmiPrintAlign.LEFT);
        await SunmiPrinter.printText(
            "(المجموع شامل الضريبة)",
            style: SunmiStyle(bold: true));



        await SunmiPrinter.lineWrap(1);

        await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
        await SunmiPrinter.printText('***${widget.paymentType}***',
            style: SunmiStyle(bold: true));
        await SunmiPrinter.lineWrap(1);
        await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
        await SunmiPrinter.printQRCode(qrCode);

        await SunmiPrinter.lineWrap(1);
        await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
        await SunmiPrinter.printText(res.adminInfo!.footerNote.toString());
        await SunmiPrinter.lineWrap(2);

        //  await SunmiPrinter.printRawData(Uint8List.fromList(_escPos));

// you can add other print-relevant methods here..
// lastly add submit print here
        await SunmiPrinter
            .submitTransactionPrint(); // submit and start print, you can keep submit while in loop
// remember to exit the transaction mode after finish printing.
        await SunmiPrinter.exitTransactionPrint(true);

        Get.find<HomeController>().saveInvoiceShowInDatabse();
      } else {
        EasyLoading.dismiss();
      }
      //  log("_printerStatus" + _printerStatus.toString());
      log("_printerStatus" + _printerStatus.toString());
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();
      log("_printTicket Error" + e.toString());
    }
    EasyLoading.dismiss();
    EasyLoading.dismiss();
  }

  void datavalidation() {
    String ammount = amountController.text.trim();

    if (!ammount.isEmpty) {
      double ammountDouble = double.parse(ammount);
      if (ammountDouble > 0) {
        createInvoice(ammountDouble.toString());
      } else {
        EasyLoading.showToast("Enter Valid ammount",
            toastPosition: EasyLoadingToastPosition.bottom);
      }
    } else {
      EasyLoading.showToast("Enter  Ammount",
          toastPosition: EasyLoadingToastPosition.bottom);
    }
  }

*//*  getInvoice(int id) async {
    EasyLoading.show(maskType: EasyLoadingMaskType.clear);

    Get.find<HomeController>()
        .getCreatedInvoice(id.toString())
        .then((status) async {
      EasyLoading.dismiss();
      if (status.isSuccess) {
        EasyLoading.showToast(status.message,
            toastPosition: EasyLoadingToastPosition.bottom);
        CreatedInvoiceResponse createdInvoiceResponse =
            Get.find<HomeController>().createdInvoiceResponse!;
        //getcompanylogo(AppConstants.IMAGE_BASE_URL+createdInvoiceResponse.adminInfo!.image!);
       // getcompanylogo("https://previews.123rf.com/images/ironsv/ironsv2003/ironsv200300204/142464426-cat-icon-kitty-vector-icon-cat-symbol-isolated-on-background.jpg?fj=1");
       _printTicket(createdInvoiceResponse);
      } else {
        showCustomSnackBar(status.message);
      }
    });
  }*//*
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
  Future<List<int>> _customEscPos(CreatedInvoiceResponse res) async {
    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm58, profile);
    List<int> bytes = [];

    bytes += generator.row([
      PosColumn(
        text: 'col3',
        width: 3,
        styles: const PosStyles(align: PosAlign.center, underline: true),
      ),
      PosColumn(
        text: 'col6',
        width: 6,
        styles: const PosStyles(align: PosAlign.center, underline: true),
      ),
      PosColumn(
        text: 'col3',
        width: 3,
        styles: const PosStyles(align: PosAlign.center, underline: true),
      ),
    ]);

    bytes += generator.reset();
    bytes += generator.cut();

    return bytes;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    EasyLoading.dismiss();
  }

  String qrCodeGentor(String sellerName, String vatRegistration, String time,
      String netTotal, String vatTotal) {
    BytesBuilder bytesBuilder = BytesBuilder();
    //seller name
    bytesBuilder.addByte(1);
    List<int> sellerBytes = utf8.encode(sellerName);
    bytesBuilder.addByte(sellerBytes.length);
    bytesBuilder.add(sellerBytes);

    //seller vat

    bytesBuilder.addByte(2);
    List<int> vatRegistrationNumber = utf8.encode(vatRegistration);
    bytesBuilder.addByte(vatRegistrationNumber.length);
    bytesBuilder.add(vatRegistrationNumber);

    //seller vat

    bytesBuilder.addByte(3);
    List<int> timebytes = utf8.encode(time);
    bytesBuilder.addByte(timebytes.length);
    bytesBuilder.add(timebytes);

    //seller vat

    bytesBuilder.addByte(4);
    List<int> netAmount = utf8.encode(netTotal);
    bytesBuilder.addByte(netAmount.length);
    bytesBuilder.add(netAmount);

    //seller vat

    bytesBuilder.addByte(5);
    List<int> vatTotalBytes = utf8.encode(vatTotal);
    bytesBuilder.addByte(vatTotalBytes.length);
    bytesBuilder.add(vatTotalBytes);

    Uint8List qrcodeBytes = bytesBuilder.toBytes();
    final Base64Encoder base64encoder = Base64Encoder();
    return base64encoder.convert(qrcodeBytes);
  }*/
/* Future<void> getcompanylogo(String url) async {
     companyLogo = (await NetworkAssetBundle(Uri.parse(
    url))
        .load(url))
        .buffer
        .asUint8List();
  }*/
  String qrCodeGentor(String sellerName, String vatRegistration, String time,
      String netTotal, String vatTotal) {
    BytesBuilder bytesBuilder = BytesBuilder();
    //seller name
    bytesBuilder.addByte(1);
    List<int> sellerBytes = utf8.encode(sellerName);
    bytesBuilder.addByte(sellerBytes.length);
    bytesBuilder.add(sellerBytes);

    //seller vat

    bytesBuilder.addByte(2);
    List<int> vatRegistrationNumber = utf8.encode(vatRegistration);
    bytesBuilder.addByte(vatRegistrationNumber.length);
    bytesBuilder.add(vatRegistrationNumber);

    //seller vat

    bytesBuilder.addByte(3);
    List<int> timebytes = utf8.encode(time);
    bytesBuilder.addByte(timebytes.length);
    bytesBuilder.add(timebytes);

    //seller vat

    bytesBuilder.addByte(4);
    List<int> netAmount = utf8.encode(netTotal);
    bytesBuilder.addByte(netAmount.length);
    bytesBuilder.add(netAmount);

    //seller vat

    bytesBuilder.addByte(5);
    List<int> vatTotalBytes = utf8.encode(vatTotal);
    bytesBuilder.addByte(vatTotalBytes.length);
    bytesBuilder.add(vatTotalBytes);

    Uint8List qrcodeBytes = bytesBuilder.toBytes();
    final Base64Encoder base64encoder = Base64Encoder();
    return base64encoder.convert(qrcodeBytes);
  }
}
