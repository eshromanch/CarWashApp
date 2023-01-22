
import 'dart:async';

import 'package:car_wash_app/data/model/body/Logo.dart';
import 'package:car_wash_app/database/dao/Logo.dart';
import 'package:floor/floor.dart';

import 'package:car_wash_app/data/model/response/login_response.dart';

import 'package:car_wash_app/database/dao/ServiceDao.dart';

import 'package:car_wash_app/database/dao/UserDao.dart';



import 'package:sqflite/sqflite.dart' as sqflite;


part 'database.g.dart';// the generated code will be there




@Database(version: 1, entities: [UserInfo,Service,Logo])
abstract class GasVatDatabase extends FloorDatabase {
   UserDao get userDao;
   ServiceDao get serviceDao;
   LogoDao get logo;

}