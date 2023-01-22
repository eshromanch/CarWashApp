import 'dart:io';
import 'dart:math';

import 'package:car_wash_app/controller/home_controller.dart';
import 'package:car_wash_app/data/model/body/TempService.dart';
import 'package:car_wash_app/data/repository/service_repo.dart';
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
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as Img;
import 'package:path_provider/path_provider.dart';

import 'history_controller.dart';

class ServiceController extends GetxController implements GetxService {
  final ServiceRepo serviceRepo;
  final GasVatDatabase database;
  XFile? _pickedLogo;
  ServiceController(
      {required this.database, required this.serviceRepo});

  bool _isLoading = false;




  List<Service>? _serviceList;

  InvoiceResponse? _invoiceResponse;
 // CreatedInvoiceResponse? _createdInvoiceResponse;
  /*InvoiceShow ? _invoiceShow;*/


  List<Service>? get serviceList => _serviceList;
  XFile? get pickedLogo=>_pickedLogo;
  bool get isLoading => _isLoading;

  /*InvoiceResponse? get invoiceResponse => _invoiceResponse;*/
 /* InvoiceShow ?get invoiceShow=>_invoiceShow;*/
//  CreatedInvoiceResponse? get createdInvoiceResponse => _createdInvoiceResponse;



  Future<void> getBusinessProfile(bool isloader) async {
    print("jiji");
    if(isloader){
      _isLoading = true;
      update();
    }


      _serviceList= await serviceRepo.getBusinessFromDatabase(database);

    if(isloader){
      _isLoading = false;
      update();
    }


    }

  Future<int> submitServiceInfo(Service service) async {
    _isLoading = true;
    update();

    int r= await serviceRepo.insertServiceIntoDatabase(database,service);

    _isLoading = false;
    update();
    return r;
  }
  Future<bool> isServiceListExist() async {
    _isLoading = true;
    update();

    _serviceList= await serviceRepo.getBusinessFromDatabase(database);
    if(_serviceList!=null&&_serviceList!.length>0){

      return true;

    }else{

      return false;

    }

  }
  Future<int?> deletServiceInfo(Service service) async {
    print("hoga mara");
    _isLoading = true;
    update();

    int r= await serviceRepo.deleteServiceIntoDatabase(database,service)??1;
    Get.find<HomeController>().getLogoList(true);
      print(r);
    _isLoading = false;
    update();
    return r;
  }

  Future<int> updateServiceInfo(Service service) async {
    _isLoading = true;
    update();

    int r= await serviceRepo.UpdateServiceIntoDatabase(database,service);
    if(r>0){
      getBusinessProfile(false);
      _isLoading = false;
      update();
      return r;
    }
    print(r);
    _isLoading = false;
    update();
    return r;


  }




  void pickImage() async {

        _pickedLogo = await ImagePicker().pickImage(source: ImageSource.gallery);
      update();

  }

  void SetpickImageNull() async {

    _pickedLogo = null;
    //update();

  }
  Future<String?> saveImageToDisk() async {
    _isLoading=true;
    update();
    if (null != _pickedLogo) {
      Directory directory = await getTemporaryDirectory();

      try {
        String path = _pickedLogo!.path;
        File tempFile = File(path);
        Img.Image? image = Img.decodeImage(tempFile.readAsBytesSync());
         Img.Image mImage = Img.copyResize(image!, width: 300);
        String imgType = path.split('.').last;
        String mPath =
            '${directory.path.toString()}/image_${DateTime.now()}.$imgType';
        File dFile = File(mPath);
        if (imgType == 'jpg' || imgType == 'jpeg') {
          dFile.writeAsBytesSync(Img.encodeJpg(mImage!));
        } else {
          dFile.writeAsBytesSync(Img.encodePng(mImage!));
        }
        return mPath;
      } catch (e) {
        _isLoading=false;
        update();
        return null;
      }
    }
    else{
      _isLoading=false;
      update();
      return null;
    }

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