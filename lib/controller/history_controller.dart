/*
import 'dart:io';
import 'dart:math';

import 'package:floor/floor.dart' as floor;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:car_wash_app/data/model/body/InvoiceShowBody.dart';
import 'package:car_wash_app/data/model/body/signup_body.dart';
import 'package:car_wash_app/data/model/response/CreatedInvoiceResponse.dart';
import 'package:car_wash_app/data/model/response/invoiceResponse.dart';

import 'package:car_wash_app/data/model/response/login_response.dart';
import 'package:car_wash_app/data/model/response/oil_info_response.dart' as dat;
import 'package:car_wash_app/data/model/response/response_model.dart';
import 'package:car_wash_app/data/repository/auth_repo.dart';
import 'package:car_wash_app/data/repository/history_repo.dart';
import 'package:car_wash_app/data/repository/home_repo.dart';
import 'package:car_wash_app/data/repository/invoice_repo.dart';
import 'package:car_wash_app/database/db/database.dart';
import 'package:car_wash_app/helper/CheckConnectivityofInternet.dart';
import 'package:car_wash_app/view/base/custom_snackbar.dart';
import 'package:get/get.dart';

class HistoryController extends GetxController implements GetxService {

  final HistoryRepo historyRepo;
  final GasVatDatabase database;

  HistoryController(
      {required this.database, required this.historyRepo});

  bool _isLoading = false;




  List<InvoiceShow> _invoiceShow=[];
  List<InvoiceShow> get invoiceShow =>_invoiceShow;






  bool get isLoading => _isLoading;


  Future<void> getInvoiceListFromDatabase() async {
     _isLoading=true;
     update();

    _invoiceShow= await historyRepo.getInvoiceList(database);

    //DateTime dateTime = DateTime.now();
     _isLoading=false;
     update();

  }

  Future<void> saveInvoiceListToOnlineDatabase() async {
    _isLoading=true;
    update();
      _invoiceShow=[];

    _invoiceShow= await historyRepo.getUnSavedInvoiceList(database);
    if(_invoiceShow.length>0){
      List<String> amount=[];
      List<String> litter=[];
      List<String> name=[];
      List<String> price=[];
      List<String> purchasePrice=[];
      List<String> vatPrice=[];
      List<String> vat=[];
      List<String> invoiceNo=[];
      List<String> oilInfoId=[];
      List<String> adminId=[];
      List<String> userId=[];
      List<String> createdAt=[];
      List<String> updatedAt=[];
      InvoiceShowBody invoiceShowBody;
       _invoiceShow.map((e) {
             amount.add(e.amount.toString());
            litter.add(e.litter.toString());
            name.add(e.name.toString());
            price.add(e.price.toString());
            purchasePrice.add(e.purchasePrice.toString());
            vatPrice.add(e.vatPrice.toString());
            vat.add(e.vat.toString());
            invoiceNo.add(e.invoiceNo.toString());
            oilInfoId.add(e.oilInfoId.toString());
            adminId.add(e.adminId.toString());
            userId.add(e.userId.toString());
            createdAt.add(e.createdAt.toString());
            updatedAt.add(e.updatedAt.toString());
       }).toList();
       invoiceShowBody=InvoiceShowBody(amount: amount,litter: litter,name: name,
           price: price,purchasePrice: purchasePrice,
           vatPrice: vatPrice,vat: vat,
         invoiceNo: invoiceNo,oilInfoId: oilInfoId,adminId: adminId,userId: userId,createdAt: createdAt,
         updatedAt: updatedAt
       );
       //print(invoiceShowBody.toJson());

      historyRepo.saveInvoiceListIntoServer(invoiceShowBody).then((value) {
        if(value.statusCode==201) {
          _invoiceShow.map((e) {

            database.createdInvoiceDao.UpdateInvoiceShow(e.id!);
          }).toList();
          showCustomSnackBar("Invoices are updated Successfully",isError: false);
        }

      });


    }else{
      showCustomSnackBar("All Invoice are synced",isError: false);
    }

    //DateTime dateTime = DateTime.now();
    _isLoading=false;
    update();

  }










}*/
