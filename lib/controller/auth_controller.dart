

import 'package:car_wash_app/controller/logo_controller.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:car_wash_app/data/model/body/signup_body.dart';

import 'package:car_wash_app/data/model/response/login_response.dart';
import 'package:car_wash_app/data/model/response/response_model.dart';
import 'package:car_wash_app/data/repository/auth_repo.dart';
import 'package:car_wash_app/database/db/database.dart';
import 'package:car_wash_app/helper/CheckConnectivityofInternet.dart';
import 'package:car_wash_app/util/app_constants.dart';
import 'package:car_wash_app/view/base/custom_snackbar.dart';
import 'package:get/get.dart';
import 'package:image_downloader/image_downloader.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;
  final GasVatDatabase db;
  AuthController( {required this.authRepo,required this.db}) ;

  bool _isLoading = false;



  List<UserInfo> userInfoList=[];


  bool get isLoading => _isLoading;




  Future<void> addUserToDatabase() async {

    if(!authRepo.isAdded()) {

      _isLoading = true;
      update();
      createUserList();
      Get.find<LogoController>().initImages().then((value) async {
     /* UserInfo userInfo = new UserInfo(
      password: "12345", email: "sales@popcorn.com.bd");*/
      int d=0;
      for(int i=1;i<=100;i++){
        int a = 0;
        a = await authRepo.addUserToDatabase(db, userInfoList[i-1]);
        if(i==100&&a!=0){
          d=1;
        }
      }

      if (d == 0) {
        print("not registar");
      } else {
        print(d);
        saveUserAdded();
      }
      });

      _isLoading = false;
      update();
    }

  }
  void createUserList(){
    for(int i=10001;i<=10100;i++){
      userInfoList.add(new UserInfo(email: 'FF'+i.toString(),password: '12345'+(i-10000).toString()));
      print(userInfoList[i-10001].email);
      print(userInfoList[i-10001].password);
    }
  }


  Future<ResponseModel> login(String phone, String password) async {
    _isLoading = true;
    update();
    UserInfo userInfo=new UserInfo(password: password,email: phone);
    List<UserInfo> userInfoFromDb=await authRepo.login(userInfo:userInfo,db: db );
   // print(userInfoFromDb!.email!);
     ResponseModel responseModel;
    if (userInfoFromDb!=null&& userInfoFromDb.length>0) {
      print(userInfoFromDb[0].email);
      if(userInfoFromDb[0].email==phone) {
        if(userInfoFromDb[0].password==password){
          authRepo.saveUserLogin("logged In");
          responseModel = ResponseModel(true, "login Successfully");
        }else{
          responseModel = ResponseModel(false, "Password not matched");
        }

      }else{
        responseModel = ResponseModel(false, "Email Address not matched");
      }

    } else {
      EasyLoading.dismiss(animation: false);
      responseModel = ResponseModel(false, "Credential not matched");
    }
    _isLoading = false;
    update();
    return responseModel;
  }
  bool isLoggedIn() {
    return authRepo.isLoggedIn();
  }
  Future<ResponseModel> login1(String phone, String password) async {
    print("i am here");
    _isLoading = true;
    update();
    UserInfo userInfo=new UserInfo(password: password,email: phone);
    UserInfo? userInfoFromDb=await authRepo.login1(userInfo:userInfo,db: db );
    // print(userInfoFromDb!.email!);
    ResponseModel responseModel;
    if (userInfoFromDb!=null) {
      print(userInfoFromDb.email);
      if(userInfoFromDb.email==phone) {
        print(userInfoFromDb.password);
        if(userInfoFromDb.password==password){
          authRepo.saveUserLogin("logged In");
          responseModel = ResponseModel(true, "login Successfully");
        }else{
          responseModel = ResponseModel(false, "Password not matched");
        }

      }else{
        responseModel = ResponseModel(false, "Email Address not matched");
      }

    } else {
      EasyLoading.dismiss(animation: false);
      responseModel = ResponseModel(false, "Credential not matched");
    }
    _isLoading = false;
    update();
    return responseModel;
  }


  bool isAdded() {
    return authRepo.isAdded();
  }

  void saveUserAdded() {
     authRepo.saveUserAdded(true);
  }
  Future<bool> clearSharedData()async {
    return  authRepo.clearSharedData();
  }
/*
  bool isLoggedIn() {
    return authRepo.isLoggedIn();
  }


  Future<bool> logout() async {

    List<InvoiceShow> InvoiceShowList=await database.createdInvoiceDao.getUnsavedInvoice(0);
    if(InvoiceShowList.length>0){
      showCustomSnackBar("Please Sync Offline data first");
      return false;

    }else{
      try {
        await database.oilDao.cleanOilInfoTable();
        await database.userDao.cleanUserTable();
        await database.adminDao.cleanAdminInfoTable();
        await database.createdInvoiceDao.cleanInvoiceShowTable();
        clearSharedData();
        return true;
      }catch(e){
        showCustomSnackBar("Something Wrong contact your admin,"+e.toString());
        return false;
      }

    }
  }

  bool clearSharedData() {
    return authRepo.clearSharedData();
  }

  Future<void> saveImagetoLocalStorag(String url) async{
    var imageId = await ImageDownloader.downloadImage(url);

    if(imageId!=null){
      var path = await ImageDownloader.findPath(imageId!);
      if(path!=null){
        authRepo.saveUserImagePath(path);
        //print(path.toString());
      }
     
    }
    


  }


  String getsaveImageFromLocalStorag() {

    return  authRepo.getUserImagePath();

    }

*/




















}