import 'dart:io';

class CheckInternetConectivity{

  static Future<bool?> checkInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
        print('connected');
      }
    } on SocketException catch (_) {
      print('not connected');
      return false;
    }
  }



}