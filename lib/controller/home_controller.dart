import 'dart:io';
import 'dart:math';

import 'package:car_wash_app/controller/service_controller.dart';
import 'package:car_wash_app/data/model/body/Logo.dart';
import 'package:car_wash_app/data/model/body/TempService.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:car_wash_app/data/model/body/signup_body.dart';

import 'package:car_wash_app/data/model/response/invoiceResponse.dart';

import 'package:car_wash_app/data/model/response/login_response.dart';

import 'package:car_wash_app/data/model/response/response_model.dart';
import 'package:car_wash_app/data/repository/auth_repo.dart';
import 'package:car_wash_app/data/repository/home_repo.dart';
import 'package:car_wash_app/data/repository/invoice_repo.dart';
import 'package:car_wash_app/database/db/database.dart';
import 'package:car_wash_app/helper/CheckConnectivityofInternet.dart';
import 'package:get/get.dart';

import 'history_controller.dart';

class HomeController extends GetxController implements GetxService {
  final HomeRepo homeRepo;
  final GasVatDatabase database;

  HomeController(
      {required this.database, required this.homeRepo});

  bool _isLoading = false;
 bool _isSearchMood=false;
  bool _acceptTerms = true;
 // InvoiceShow ?TempararyinvoiceShow;
  List<Logo>? _logoList;
  List<Logo>? _searchLogoList;
  List<Service>? _serviceList;
  TempService? _tempService;
  InvoiceResponse? _invoiceResponse;
 // CreatedInvoiceResponse? _createdInvoiceResponse;
  /*InvoiceShow ? _invoiceShow;*/


  List<Logo>? get logoList => _logoList;
  List<Service>? get serviceList => _serviceList;
  List<Logo>? get searchLogoList => _searchLogoList;

  bool get isLoading => _isLoading;
  bool get isSearchMood => _isSearchMood;
  TempService ?get tempService => _tempService;
  /*InvoiceResponse? get invoiceResponse => _invoiceResponse;*/
 /* InvoiceShow ?get invoiceShow=>_invoiceShow;*/
//  CreatedInvoiceResponse? get createdInvoiceResponse => _createdInvoiceResponse;

  bool get acceptTerms => _acceptTerms;

  Future<void> getLogoList(bool isloader) async {
    if(isloader){
      _isLoading = true;
      update();
    }


    _logoList= await homeRepo.getLogoListFromDatabase(database);
    _logoList!.sort((a, b) {
      return a.name!.toLowerCase().compareTo(b.name!.toLowerCase());
    });
    if(isloader){
      _isLoading = false;
      update();
    }


    }


  Future<void> getLogoListByKeyword(bool isloader,String Key) async {
    if(isloader){
      _isLoading = true;
      update();
    }

     _searchLogoList= _logoList!.where((currentName) => currentName.name!.isCaseInsensitiveContains(Key)).toList();
    //_logoList= await homeRepo.getLogoListByKeyWordFromDatabase(database,Key);

    if(isloader){
    _isSearchMood=true;
      _isLoading = false;
      update();
    }


  }
  Future<void> setLogoListByKeywordEmty(bool isloader,) async {
    if(isloader){
      _isLoading = true;
      update();
    }

    _searchLogoList= null;
    //_logoList= await homeRepo.getLogoListByKeyWordFromDatabase(database,Key);

    if(isloader){
      _isSearchMood=false;
      _isLoading = false;
      update();
    }


  }


  Future<int> submitServiceInfo(Service service) async {
    _isLoading = true;
    update();

    int r= await homeRepo.insertServiceIntoDatabase(database,service);
     print(r);
    _isLoading = false;
    update();
    return r;
  }


  Future<void> updateServiceInfo(Service service) async {
    _isLoading = true;
    update();

    int r= await homeRepo.UpdateServiceIntoDatabase(database,service);
    print(r);
    _isLoading = false;
    update();
  }

  Future<List<Service>?> GetServiceList() async {
    _isLoading = true;
    update();

    _logoList= await homeRepo.getLogoListFromDatabase(database);

    _isLoading = false;
    update();
  }

  Future<bool> isServiceListexist() async {
    _isLoading = true;
    update();
    bool ishe=await Get.find<ServiceController>().isServiceListExist();
    _isLoading = false;
    update();
    return ishe;


  }


  void setTempList(TempService tempService){
    _tempService=_tempService;
    //update();
  }



/*
  Future<ResponseModel> getCreatedInvoice(String id) async {
    _isLoading = true;
    update();
    Response response = await invoiceRepo.getInvoicePrint(id);
    ResponseModel responseModel;
    if (response.statusCode == 201) {
      _createdInvoiceResponse = CreatedInvoiceResponse.fromJson(response.body);

      responseModel = ResponseModel(true, response.body["message"]);
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }*/










int getRandom() {
  var rng = new Random();
  var code = rng.nextInt(90000000) + 10000000;
  return code;
}


}