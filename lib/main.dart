import 'package:car_wash_app/theme/light_theme.dart';
import 'package:car_wash_app/util/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:get/get.dart';
import 'controller/auth_controller.dart';
import 'helper/get_di.dart' as di;
import 'helper/route_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();



  await di.init();
  bool islogin= Get.find<AuthController>().isLoggedIn()??false;
  runApp(MyApp(islogin: islogin,));
}

class MyApp extends StatefulWidget {
  final bool islogin;

  const MyApp({Key? key, required this.islogin}) : super(key: key);
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}
void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.ring
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 30.0
    ..radius = 5.0
    ..progressColor = Colors.white
    ..backgroundColor =Colors.deepPurpleAccent
    ..indicatorColor = Colors.white
    ..textColor = Colors.white
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = false;
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppConstants.APP_NAME,
      debugShowCheckedModeBanner: false,
      navigatorKey: Get.key,
      theme:light,

      // locale: localizeController.locale,
      /// fallbackLocale: Locale(AppConstants.languages[0].languageCode, AppConstants.languages[0].countryCode),
      // translations: Messages(languages: languages),
      initialRoute:widget.islogin?RouteHelper.getHomeRoute():RouteHelper.getSignInRoute() ,
      getPages: RouteHelper.routes,
      defaultTransition: Transition.topLevel,
      transitionDuration: Duration(milliseconds: 500),
      builder:  EasyLoading.init(),

    );
  }
}


