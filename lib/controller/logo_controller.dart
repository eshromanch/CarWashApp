import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:car_wash_app/controller/home_controller.dart';
import 'package:car_wash_app/data/model/body/Logo.dart';
import 'package:car_wash_app/data/model/body/TempService.dart';
import 'package:car_wash_app/data/repository/logo_repo.dart';
import 'package:car_wash_app/data/repository/service_repo.dart';
import 'package:car_wash_app/util/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

class LogoController extends GetxController implements GetxService {
  final LogoRepo logoRepo;
  final GasVatDatabase database;
  XFile? _pickedLogo;
  LogoController(
      {required this.database, required this.logoRepo});

  bool _isLoading = false;




  List<Logo>? _logoList;





  List<Logo>? get logoList => _logoList;
  XFile? get pickedLogo=>_pickedLogo;
  bool get isLoading => _isLoading;




  Future<void> getLogoList(bool isloader) async {
    print("jiji");
    if(isloader){
      _isLoading = true;
      update();
    }


    _logoList= await logoRepo.getLogoFromDatabase(database);
    _logoList!.sort((a, b) {
      return a.name!.toLowerCase().compareTo(b.name!.toLowerCase());
    });
    if(isloader){
      _isLoading = false;
      update();
    }


    }

  Future<int> submitLogoInfo(Logo logo) async {
    _isLoading = true;
    update();
     _pickedLogo=null;
    int r= await logoRepo.insertLogoIntoDatabase(database,logo);

    _isLoading = false;
    update();
    return r;
  }

 /* Future<void> getallFiles(BuildContext context) async {
    final manifestJson = await DefaultAssetBundle.of(context).loadString('AssetManifest.json');
    final images = json.decode(manifestJson).keys.where((String key) => key.startsWith('assets/carlogo'));
    print(images.);
  }*/

  Future initImages() async {
    bool isAdded=await getLogoInsertIntoDatabase();
    if(isAdded){
      return false;
    }else{
      final manifestContent = await rootBundle.loadString('AssetManifest.json');

      final Map<String, dynamic> manifestMap = json.decode(manifestContent);
      // >> To get paths you need these 2 lines

      final imagePaths = manifestMap.keys
          .where((String key) => key.startsWith('assets/carlogo'))
          .toList();
      try {
        imagePaths.map((e) async {
          String finalName;
          String tempName = e.split("/")[2];
          List<String> logoName = tempName.split(".")[0].split("-");
          if (logoName.length > 2) {
            finalName = logoName[0].substring(0, 1).toUpperCase() +
                logoName[0].substring(1) + " " +
                logoName[1].substring(0, 1).toUpperCase() +
                logoName[1].substring(1);
          } else {
            finalName = logoName[0].substring(0, 1).toUpperCase() +
                logoName[0].substring(1);
          }

          // finalName=finalName.substring(0,1).toUpperCase()+finalName.substring(1);
          print(finalName);
          await submitLogoInfo(new Logo(name: finalName, url: e));
        }).toList();
        setLogoInsertIntoDatabase(true);

      }catch(e){
        Get.snackbar("Error", "Something Wrong");
      }
    }
    // >> To get paths you need these 2 lines

  }
  Future<int?> deletLogo(Logo logo) async {
    print("hoga mara");
    _isLoading = true;
    update();
    print(logo.name);
    int r= await logoRepo.deleteLogoIntoDatabase(database,logo)??1;
   // Get.find<HomeController>().get(true);
      print(r);
    _isLoading = false;
    update();
    return r;
  }

  Future<int> updatelogoInfo(Logo logo) async {
    _isLoading = true;
    update();

    int r= await logoRepo.UpdateLogoIntoDatabase(database,logo);
    if(r>0){
      getLogoList(false);
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
        if(_pickedLogo!=null) {
          String path = _pickedLogo!.path;
          File tempFile = File(path);

          Img.Image? image = Img.decodeImage(tempFile.readAsBytesSync());
          if(image!.width<image.height){
            _pickedLogo=null;
            Get.snackbar("Error","Please do not select portrait image",colorText:Colors.red);
          }
        }
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
     // Directory directory = await getTemporaryDirectory();
      Directory? directory =  await getExternalStorageDirectory();

      if(directory!=null){
        print(directory.path!);
        try {
          String path = _pickedLogo!.path;
          File tempFile = File(path);

          Img.Image? image = Img.decodeImage(tempFile.readAsBytesSync());

          Img.Image mImage = Img.copyResize(image!, width: 300,);
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

    }
    else{
      _isLoading=false;
      update();
      return null;
    }

  }
  Future<void> setLogoInsertIntoDatabase(bool isAdd) async {

    await logoRepo.setLogoInsertIntoDatabase( isAdd);
  }

  Future<bool> getLogoInsertIntoDatabase() async {

   return await logoRepo.getLogoInsertIntoDatabase();
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